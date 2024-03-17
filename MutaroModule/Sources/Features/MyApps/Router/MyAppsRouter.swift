//
//  MyAppsRouter.swift
//
//
//  Created by minguk-kim on 2023/05/13.
//

import Core
import UIKit

public protocol MyAppsRoutable: Sendable {
    @MainActor
    func showRegisterJWT(from viewController: UIViewController)
    @MainActor
    func showMyAppTools(from viewController: UIViewController, appId: String)
}

public final class MyAppsRouter: MyAppsRoutable {
    public struct Dependency: Sendable {
        public let registerJWTFeatureBuilder: any RegisterJWTFeatureBuildable
        public let myAppToolsFeatureBuilder: any MyAppToolsFeatureBuildable

        public init(
            registerJWTFeatureBuilder: any RegisterJWTFeatureBuildable,
            myAppToolsFeatureBuilder: any MyAppToolsFeatureBuildable
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
