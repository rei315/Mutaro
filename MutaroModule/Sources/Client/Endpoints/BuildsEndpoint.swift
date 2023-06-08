//
//  BuildsEndpoint.swift
//
//
//  Created by minguk-kim on 2023/05/04.
//

import Core
import Foundation

public enum BuildsEndpoint {}

public extension BuildsEndpoint {
    struct GetAllBuilds: Endpoint {
        private let token: String
        private let appId: String
        private let additionalParameters: [String: Any]

        public init(token: String, appId: String, additionalParameters: [String: Any]) {
            self.token = token
            self.appId = appId
            self.additionalParameters = additionalParameters
        }

        public var baseURL: BaseURL = .appstoreConnectAPI
        public var baseHeaders: [String: String]? {
            [
                "Authorization": "Bearer \(token)",
                "Content-Type": "application/json"
            ]
        }

        public var path: String {
            "/v1/apps/\(appId)/builds"
        }

        public var method: HTTPMethod = .get
        public var parameters: [String: Any]? {
            additionalParameters
        }

        public var multipartParameters: [String: Any]?
    }
}
