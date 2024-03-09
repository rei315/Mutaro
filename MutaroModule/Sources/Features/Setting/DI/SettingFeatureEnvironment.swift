//
//  SettingFeatureEnvironment.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import Foundation

public struct SettingFeatureEnvironment: Sendable {
    public let router: any SettingRoutable

    public init(router: any SettingRoutable) {
        self.router = router
    }
}
