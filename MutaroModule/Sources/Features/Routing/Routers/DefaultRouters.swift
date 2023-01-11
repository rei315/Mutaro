//
//  DefaultRouters.swift
//  
//
//  Created by minguk-kim on 2023/01/12.
//

import UIKit

public class DefaultRouter: NSObject, Router, Closable, Dismissable {
    private let rootTransition: Transition
    weak public var root: UIViewController?

    public init(rootTransition: Transition) {
        self.rootTransition = rootTransition
    }

    deinit {
        print("🗑 Deallocating \(self) with \(String(describing: rootTransition))")
    }

    // MARK: - Routable
    public func route(to viewController: UIViewController, as transition: Transition, completion: (() -> Void)?) {
        guard let root = root else { return }
        transition.open(viewController, from: root, completion: completion)
    }

    public func route(to viewController: UIViewController, as transition: Transition) {
        route(to: viewController, as: transition, completion: nil)
    }

    // MARK: - Closable
    public func close(completion: (() -> Void)?) {
        guard let root = root else { return }
        rootTransition.close(root, completion: completion)
    }

    public func close() {
        close(completion: nil)
    }

    // MARK: - Dismissable
    public func dismiss(completion: (() -> Void)?) {
        root?.dismiss(animated: rootTransition.isAnimated, completion: completion)
    }

    public func dismiss() {
        dismiss(completion: nil)
    }
}
