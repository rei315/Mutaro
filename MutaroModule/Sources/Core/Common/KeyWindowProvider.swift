//
//  KeyWindowProvider.swift
//
//
//  Created by minguk-kim on 2023/01/15.
//

import UIKit

struct KeyWindowProvider {
    func getKeyWindow() -> UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first
    }
}
