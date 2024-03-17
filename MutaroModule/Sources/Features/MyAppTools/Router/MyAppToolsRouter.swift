//
//  MyAppToolsRouter.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import Core
import Foundation

public protocol MyAppToolsRoutable: Sendable {}

public final class MyAppToolsRouter: MyAppToolsRoutable {
    public struct Dependency: Sendable {}

    private let dependency: Dependency

    public init(dependency: Dependency) {
        self.dependency = dependency
    }
}
