//
//  MyAppsFeatureEnvironment.swift
//
//
//  Created by minguk-kim on 2023/05/07.
//

import Core
import Foundation

public struct MyAppsFeatureEnvironment {
    public let client: Providable

    public init(client: Providable) {
        self.client = client
    }
}
