//
//  HomeFeatureBuilder.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import NeedleFoundation
import UIKit

public protocol HomeFeatureBuildable: Buildable {
    @MainActor
    func build(viewControllers: [UIViewController]) -> UIViewController
}

public protocol FeatureHomeView {
    func homeFeatureBuilder() -> HomeFeatureBuildable
}
