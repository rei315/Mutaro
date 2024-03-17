//
//  ViewBuilder.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import Foundation
import NeedleFoundation

public protocol Buildable {}

open class Builder<Dependency: Sendable>: Buildable, @unchecked Sendable {
    public let dependency: Dependency

    public init(dependency: Dependency) {
        self.dependency = dependency
    }
}
