//
//  ViewBuilder.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import Foundation
import NeedleFoundation

public protocol Buildable: AnyObject {}

open class Builder<Dependency>: Buildable {
    public let dependency: Dependency

    public init(dependency: Dependency) {
        self.dependency = dependency
    }
}
