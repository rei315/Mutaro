//
//  MyAppsRouter.swift
//  
//
//  Created by minguk-kim on 2023/05/13.
//

import UIKit
import Core

public protocol MyAppsRoutable {
    func showRegisterJWT(from viewController: UIViewController)
}

public class MyAppsRouter: MyAppsRoutable {
    public struct Dependency {
        public let registerJWTFeatureBuilder: RegisterJWTFeatureBuildable
        
        public init(registerJWTFeatureBuilder: RegisterJWTFeatureBuildable) {
            self.registerJWTFeatureBuilder = registerJWTFeatureBuilder
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
}
