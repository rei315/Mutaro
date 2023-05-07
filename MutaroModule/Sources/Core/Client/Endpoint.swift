//
//  Endpoint.swift
//
//
//  Created by minguk-kim on 2023/05/07.
//

import Foundation

public protocol Endpoint {
    var baseURL: BaseURL { get set }
    var baseHeaders: [String: String]? { get async }

    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var multipartParameters: [String: Any]? { get }
}
