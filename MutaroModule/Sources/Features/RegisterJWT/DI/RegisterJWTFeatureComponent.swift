//
//  RegisterJWTFeatureComponent.swift
//  MutaroApp
//
//  Created by minguk-kim on 2023/05/06.
//

import Core
import Foundation
import NeedleFoundation
import UIKit

public protocol RegisterJWTFeatureDependency: Dependency {
    // TODO: - var 遷移するB FeatureのBuilder: BModuleBuildable { get }
}

class RegisterJWTFeatureBuilder: Builder<RegisterJWTFeatureDependency>, RegisterJWTFeatureBuildable {
    @MainActor
    public func build() -> UIViewController {
        RegisterJWTViewController(
            dependency: .init(
                viewModel: .init()
            )
        )
    }
}

public class RegisterJWTFeatureBuilderComponent: Component<RegisterJWTFeatureDependency>, FeatureRegisterJWT {
    public func registerJWTFeatureBuilder() -> Core.RegisterJWTFeatureBuildable {
        RegisterJWTFeatureBuilder(dependency: dependency)
    }
}
