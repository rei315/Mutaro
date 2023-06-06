//
//  CIProductsEndpoint.swift
//
//
//  Created by minguk-kim on 2023/06/06.
//

import Core
import Foundation

public enum CIProductsEndpoint {}

public extension CIProductsEndpoint {
    struct GetAllProducts: Endpoint {
        private let token: String
        private let additionalParameters: [String: Any]

        public init(token: String, additionalParameters: [String: Any]) {
            self.token = token
            self.additionalParameters = additionalParameters
        }

        public var baseURL: Core.BaseURL = .appstoreConnectAPI

        public var baseHeaders: [String: String]? {
            [
                "Authorization": "Bearer \(token)",
                "Content-Type": "application/json"
            ]
        }

        public var path: String {
            "/v1/ciProducts"
        }

        public var method: Core.HTTPMethod = .get

        public var parameters: [String: Any]? {
            additionalParameters
        }

        public var multipartParameters: [String: Any]?
    }
}
