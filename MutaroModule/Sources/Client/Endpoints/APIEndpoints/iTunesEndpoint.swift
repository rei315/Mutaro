//
//  iTunesEndpoint.swift
//
//
//  Created by minguk-kim on 2023/05/05.
//

import Foundation

public enum iTunesEndpoint {}

public extension iTunesEndpoint {
    struct getAppDetail: Endpoint {
        private let appId: String

        public init(appId: String) {
            self.appId = appId
        }

        public var baseURL: BaseURL = .iTunes
        public var baseHeaders: [String: String]? {
            ["id": appId]
        }

        public var path: String {
            "/lookup"
        }

        public var method: HTTPMethod = .get
        public var parameters: [String: Any]?
        public var multipartParameters: [String: Any]?
    }
}
