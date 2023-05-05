//
//  RegisterJWTFeatureBuilder.swift
//  
//
//  Created by minguk-kim on 2023/05/06.
//

import NeedleFoundation
import UIKit

public protocol RegisterJWTFeatureBuildable: Buildable {
    func build() -> UIViewController
}

public protocol RegisterJWTFeatureBuilder {
    func registerJWTFeatureBuilder() -> RegisterJWTFeatureBuildable
}
