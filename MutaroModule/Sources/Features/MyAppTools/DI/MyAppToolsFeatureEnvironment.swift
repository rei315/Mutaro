//
//  MyAppToolsFeatureEnvironment.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import Core
import Foundation

public struct MyAppToolsFeatureEnvironment {
    public let router: MyAppToolsRoutable

    public init(router: MyAppToolsRoutable) {
        self.router = router
    }
}
