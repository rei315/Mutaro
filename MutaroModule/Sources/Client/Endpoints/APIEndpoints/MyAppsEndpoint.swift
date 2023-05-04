//
//  MyAppsEndpoint.swift
//
//
//  Created by minguk-kim on 2023/05/04.
//

import Foundation

public enum MyAppsEndpoint {}

public extension MyAppsEndpoint {
    struct GetAllListMyApps: Endpoint {
        private let token: String

        public init(token: String) {
            self.token = token
        }

        public var baseURL: BaseURL = .appstoreConnectAPI

        public var baseHeaders: [String: String]? {
            ["Authorization": "Bearer \(token)"]
        }

        public var path: String {
            "apps"
        }

        public var method: HTTPMethod = .get

        public var parameters: [String: Any]?

        public var multipartParameters: [String: Any]?
    }
}
