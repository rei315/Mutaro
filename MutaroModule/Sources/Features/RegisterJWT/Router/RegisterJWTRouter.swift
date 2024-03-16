//
//  RegisterJWTRouter.swift
//
//
//  Created by minguk-kim on 2023/05/07.
//

import UIKit

public protocol RegisterJWTFeatureRoutable {
    @MainActor
    func close(from viewController: UIViewController)
}

public final class RegisterJWTFeatureRouter: RegisterJWTFeatureRoutable {
    public struct Dependency {}

    private let dependency: Dependency

    public init(dependency: Dependency) {
        self.dependency = dependency
    }

    @MainActor
    public func close(from viewController: UIViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }
}
