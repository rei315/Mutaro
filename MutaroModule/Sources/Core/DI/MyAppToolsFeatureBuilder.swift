//
//  MyAppToolsFeatureBuilder.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import NeedleFoundation
import UIKit

public protocol MyAppToolsFeatureBuildable: Buildable {
    @MainActor
    func build() -> UIViewController
}

public protocol FeatureMyAppTools {
    func myAppToolsFeatureBuilder() -> MyAppToolsFeatureBuildable
}
