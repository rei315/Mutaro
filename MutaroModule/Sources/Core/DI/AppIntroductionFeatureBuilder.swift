//
//  AppIntroductionFeatureBuilder.swift
//  
//
//  Created by minguk-kim on 2023/05/06.
//

import NeedleFoundation
import UIKit

public protocol AppIntroductionFeatureBuildable: Buildable {
    func build() -> UIViewController
}

public protocol AppIntroductionFeatureBuilder {
    func appIntroductionBuilder() -> AppIntroductionFeatureBuildable
}
