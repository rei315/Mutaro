//
//  SettingFeatureEnvironment.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import Foundation

public struct SettingFeatureEnvironment {
    public let router: SettingRoutable

    public init(router: SettingRoutable) {
        self.router = router
    }
}
