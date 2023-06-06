//
//  MyAppToolsFeatureEnvironment.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import Core
import Foundation

public struct MyAppToolsFeatureEnvironment {
    public let ciProductUseCase: CIProductUseCase
    public let router: MyAppToolsRoutable

    public init(
        ciProductUseCase: CIProductUseCase,
        router: MyAppToolsRoutable
    ) {
        self.ciProductUseCase = ciProductUseCase
        self.router = router
    }
}
