//
//  ServiceManager.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import Foundation

enum BaseURL {
    case appstoreConnectAPI

    func get() -> String {
        let url: String

        switch self {
        case .appstoreConnectAPI:
            url = "https://api.appstoreconnect.apple.com"
        }

        return url
    }
}

actor ServiceManager {
    static let shared = ServiceManager()

    private init() {}

    func getBaseUrl(_ pattern: BaseURL) -> String {
        pattern.get()
    }
}
