//
//  Endpoint.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import Foundation

protocol Endpoint {
    var baseURL: BaseURL { get set }
    var baseHeaders: [String: String]? { get async }

    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var multipartParameters: [String: Any]? { get }
}

extension Endpoint {
    func urlRequest() async throws -> URLRequest {
        let queryString = query(parameters)
        guard let url = try await url(method: method, query: queryString) else {
            throw APIClientError.components
        }
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = method.rawValue

        switch method {
        case .put, .post:
            if let queryString,
               let data = queryString.data(using: .utf8) {
                let length = data.count

                urlRequest.setValue(
                    "application/x-www-form-urlencoded; charset=utf-8",
                    forHTTPHeaderField: "Content-Type"
                )
                urlRequest.setValue(
                    "\(length)",
                    forHTTPHeaderField: "Content-Length"
                )
                urlRequest.httpBody = data
            }
        case .get, .delete:
            break
        }

        await baseHeaders?.forEach {
            urlRequest.setValue($1, forHTTPHeaderField: $0)
        }

        return urlRequest
    }

    func url(method: HTTPMethod, query: String?) async throws -> URL? {
        let fullPath = "\(baseURL.get())\(path)"

        guard let url = URL(string: fullPath) else {
            throw APIClientError.components
        }

        if let query,
           method == .get || method == .delete,
           var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            let percentEncodedQuery =
                (components.percentEncodedQuery.map { $0 + "&" } ?? "") + query
            components.percentEncodedQuery = percentEncodedQuery
            return components.url
        }

        return url
    }
}

extension Endpoint {
    private func query(_ parameters: [String: Any]?) -> String? {
        guard let parameters else {
            return nil
        }
        var components: [(String, String)] = []

        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }

    public func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        switch value {
        case let dictionary as [String: Any]:
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        case let array as [Any]:
            for value in array {
                components += queryComponents(fromKey: "\(key)[]", value: value)
            }
        case let number as NSNumber:
            if number.isBool {
                components.append((escape(key), escape(number.boolValue ? "1" : "0")))
            } else {
                components.append((escape(key), escape("\(number)")))
            }
        case let bool as Bool:
            components.append((escape(key), escape(bool ? "1" : "0")))
        default:
            components.append((escape(key), escape("\(value)")))
        }
        return components
    }

    public func escape(_ string: String) -> String {
        string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? string
    }
}
