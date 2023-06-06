//
//  MyAppsRouter.swift
//
//
//  Created by minguk-kim on 2023/05/13.
//

import Core
import UIKit

public protocol MyAppsRoutable {
    func showRegisterJWT(from viewController: UIViewController)
    func showMyAppTools(from viewController: UIViewController, appId: String)
}

public class MyAppsRouter: MyAppsRoutable {
    public struct Dependency {
        public let registerJWTFeatureBuilder: RegisterJWTFeatureBuildable
        public let myAppToolsFeatureBuilder: MyAppToolsFeatureBuildable

        public init(
            registerJWTFeatureBuilder: RegisterJWTFeatureBuildable,
            myAppToolsFeatureBuilder: MyAppToolsFeatureBuildable
        ) {
            self.registerJWTFeatureBuilder = registerJWTFeatureBuilder
            self.myAppToolsFeatureBuilder = myAppToolsFeatureBuilder
        }
    }

    private let dependency: Dependency

    public init(dependency: Dependency) {
        self.dependency = dependency
    }

    @MainActor
    public func showRegisterJWT(from viewController: UIViewController) {
        let vc = dependency.registerJWTFeatureBuilder.build()
        viewController.navigationController?.pushViewController(
            vc,
            animated: true
        )
    }

    @MainActor
    public func showMyAppTools(from viewController: UIViewController, appId: String) {
        let vc = dependency.myAppToolsFeatureBuilder.build(appId: appId)
        viewController.navigationController?.pushViewController(
            vc,
            animated: true
        )
    }
}
