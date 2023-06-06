//
//  Endpoint.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import Core
import Foundation

public extension Endpoint {
    func urlRequest() async throws -> URLRequest {
        let queryItems = query(parameters)
        guard let url = try await url(method: method, queryItems: queryItems) else {
            throw APIClientError.components
        }
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = method.rawValue

        switch method {
        case .put, .post:
            var components = URLComponents()
            components.queryItems = queryItems
            if let data = components.query?.data(using: .utf8) {
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

    func url(method: HTTPMethod, queryItems: [URLQueryItem]) async throws -> URL? {
        let fullPath = "\(baseURL.get())\(path)"

        if method == .get || method == .delete,
           var components = URLComponents(string: fullPath) {
            components.queryItems = queryItems
            return components.url
        }

        return URL(string: fullPath)
    }
}

public extension Endpoint {
    private func query(_ parameters: [String: Any]?) -> [URLQueryItem] {
        guard let parameters else {
            return []
        }
        var components: [URLQueryItem] = []
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components
    }

    func queryComponents(fromKey key: String, value: Any) -> [URLQueryItem] {
        var components: [URLQueryItem] = []
        switch value {
        case let dictionary as [String: Any]:
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(nestedKey)", value: value)
            }
        case let array as [Any]:
            for value in array {
                components += queryComponents(fromKey: "\(key)", value: value)
            }
        case let number as NSNumber:
            if number.isBool {
                components.append(URLQueryItem(name: key, value: number.boolValue ? "1" : "0"))
            } else {
                components.append(URLQueryItem(name: key, value: "\(number)"))
            }
        case let bool as Bool:
            components.append(URLQueryItem(name: key, value: bool ? "1" : "0"))
        default:
            components.append(URLQueryItem(name: key, value: "\(value)"))
        }
        return components
    }
}
