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
        private let additionalParameters: [String: Any]

        public init(token: String, additionalParameters: [String: Any]) {
            self.token = token
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
            "/v1/apps"
        }

        public var method: HTTPMethod = .get
        public var parameters: [String: Any]? {
            additionalParameters
        }

        public var multipartParameters: [String: Any]?
    }

    struct GetAppIcon: Endpoint {
        private let token: String
        private let appId: String

        public init(token: String, appId: String) {
            self.token = token
            self.appId = appId
        }

        public var baseURL: BaseURL = .appstoreConnectAPI
        public var baseHeaders: [String: String]? {
            [
                "Authorization": "Bearer \(token)",
                "Content-Type": "application/json"
            ]
        }

        public var path: String {
            "/v1/builds/\(appId)/icons"
        }

        public var method: HTTPMethod = .get
        public var parameters: [String: Any]?
        public var multipartParameters: [String: Any]?
    }
}
