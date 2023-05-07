//
//  BaseURL.swift
//
//
//  Created by minguk-kim on 2023/05/07.
//

import Foundation

public enum BaseURL {
    case appstoreConnectAPI
    case iTunes

    public func get() -> String {
        let url: String

        switch self {
        case .appstoreConnectAPI:
            url = "https://api.appstoreconnect.apple.com"
        case .iTunes:
            url = "https://itunes.apple.com"
        }

        return url
    }
}
