//
//  KeyWindowProvider.swift
//
//
//  Created by minguk-kim on 2023/01/15.
//

import UIKit

public struct KeyWindowProvider {
    public init() {}

    public func getKeyWindow() -> UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first
    }
}
