//
//  MyAppToolsFeatureEnvironment.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import Core
import Foundation

public struct MyAppToolsFeatureEnvironment {
    public let ciProductUseCase: any CIProductUseCase
    public let router: any MyAppToolsRoutable

    public init(
        ciProductUseCase: any CIProductUseCase,
        router: any MyAppToolsRoutable
    ) {
        self.ciProductUseCase = ciProductUseCase
        self.router = router
    }
}
