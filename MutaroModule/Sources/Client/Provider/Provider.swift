//
//  Provider.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import Foundation

protocol ProviderProtocol {
    func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<
        T, RequestError
    >
    func request(endpoint: Endpoint) async -> Result<Data, RequestError>
}

public final class Provider: ProviderProtocol {
    public static let shared = Provider()

    private let session: URLSession
    private let successRange = 200..<300
    private let decoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()

    private init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    public func request<T>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
        where T: Decodable {
        do {
            let request = try await endpoint.urlRequest()

            let (data, response) = try await session.data(for: request)
            try Task.checkCancellation()

            guard let response = response as? HTTPURLResponse else {
                return .failure(.invalidHttpStatusCode)
            }

            guard successRange.contains(response.statusCode) else {
                return .failure(.status)
            }

            guard let decodedResponse = try? decoder.decode(responseModel, from: data) else {
                return .failure(.decode)
            }

            return .success(decodedResponse)
        } catch let error as RequestError {
            return .failure(error)
        } catch {
            return .failure(.unknown)
        }
    }

    public func request(endpoint: Endpoint) async -> Result<Data, RequestError> {
        do {
            let request = try await endpoint.urlRequest()

            let (data, response) = try await session.data(for: request)
            try Task.checkCancellation()

            guard let response = response as? HTTPURLResponse else {
                return .failure(.invalidHttpStatusCode)
            }

            guard successRange.contains(response.statusCode) else {
                return .failure(.status)
            }

            return .success(data)
        } catch let error as RequestError {
            return .failure(error)
        } catch {
            return .failure(.unknown)
        }
    }
}
