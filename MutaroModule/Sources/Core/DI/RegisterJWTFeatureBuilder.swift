//
//  RegisterJWTFeatureBuilder.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import NeedleFoundation
import UIKit

public protocol RegisterJWTFeatureBuildable: Buildable {
    @MainActor
    func build() -> UIViewController
}

public protocol FeatureRegisterJWT {
    func registerJWTFeatureBuilder() -> RegisterJWTFeatureBuildable
}
