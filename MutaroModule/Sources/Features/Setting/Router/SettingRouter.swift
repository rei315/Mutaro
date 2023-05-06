//
//  File.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import Core
import UIKit

public protocol SettingRoutable {
    func showRegisterJWT(from viewController: UIViewController)
}

public class SettingRouter: SettingRoutable {
    public struct Dependency {
        public let registerJWTFeatureBuilder: RegisterJWTFeatureBuildable

        init(registerJWTFeatureBuilder: RegisterJWTFeatureBuildable) {
            self.registerJWTFeatureBuilder = registerJWTFeatureBuilder
        }
    }

    private let dependency: Dependency

    public init(dependency: Dependency) {
        self.dependency = dependency
    }

    @MainActor
    public func showRegisterJWT(from viewController: UIViewController) {
        let registerJWT = dependency.registerJWTFeatureBuilder.build()
        viewController.navigationController?.pushViewController(registerJWT, animated: true)
    }
}
