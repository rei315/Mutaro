//
//  Providable.swift
//
//
//  Created by minguk-kim on 2023/05/07.
//

import Foundation

public protocol Providable: Sendable {
    func request<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<
        T, RequestError
    >
    func request(endpoint: Endpoint) async -> Result<Data, RequestError>
}
