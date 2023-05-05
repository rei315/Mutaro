//
//  MyAppsFeatureBuilder.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import NeedleFoundation
import UIKit

public protocol MyAppsFeatureBuildable: Buildable {
    func build() -> UIViewController
}

public protocol MyAppsFeatureBuilder {
    func myAppsFeatureBuilder() -> MyAppsFeatureBuildable
}
