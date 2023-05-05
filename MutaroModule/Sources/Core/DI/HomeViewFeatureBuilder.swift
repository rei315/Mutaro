//
//  HomeViewFeatureBuilder.swift
//  
//
//  Created by minguk-kim on 2023/05/06.
//

import NeedleFoundation
import UIKit

public protocol HomeViewFeatureBuildable: Buildable {
    func build() -> UIViewController
}

public protocol HomeViewFeatureBuilder {
    func homeViewFeatureBuilder() -> HomeViewFeatureBuildable
}
