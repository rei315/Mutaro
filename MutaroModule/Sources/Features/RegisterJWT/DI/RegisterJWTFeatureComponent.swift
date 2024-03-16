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

public protocol RegisterJWTFeatureDependency: Dependency, Sendable {
    var keychainDataStore: any KeychainDataStoreProtocol { get }
}

public class RegisterJWTFeatureBuilder: Builder<RegisterJWTFeatureDependency>, RegisterJWTFeatureBuildable {
    @MainActor
    public func build() -> UIViewController {
        RegisterJWTViewController(
            dependency: .init(
                viewModel: .init(environment: environment)
            )
        )
    }

    private var environment: RegisterJWTFeatureEnvironment {
        .init(
            keychainDataStore: dependency.keychainDataStore,
            router: router
        )
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
