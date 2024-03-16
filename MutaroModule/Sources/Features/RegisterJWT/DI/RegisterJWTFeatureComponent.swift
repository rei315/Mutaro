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

@MainActor
public protocol RegisterJWTFeatureDependency: Dependency {
    // TODO: - var 遷移するB FeatureのBuilder: BModuleBuildable { get }
}

@MainActor
public class RegisterJWTFeatureBuilder: Builder<RegisterJWTFeatureDependency>, RegisterJWTFeatureBuildable {
    public func build() -> UIViewController {
        RegisterJWTViewController(
            dependency: .init(
                viewModel: .init(environment: environment)
            )
        )
    }

    private var environment: RegisterJWTFeatureEnvironment {
        .init(router: router)
    }

    private var router: any RegisterJWTFeatureRoutable {
        RegisterJWTFeatureRouter(
            dependency: .init()
        )
    }
}

public class RegisterJWTFeatureBuilderComponent: Component<RegisterJWTFeatureDependency>, FeatureRegisterJWT {
    public func registerJWTFeatureBuilder() -> any Core.RegisterJWTFeatureBuildable {
        RegisterJWTFeatureBuilder(dependency: dependency)
    }
}
