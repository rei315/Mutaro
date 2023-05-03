//
//  AnimatedTransition.swift
//
//
//  Created by minguk-kim on 2023/01/12.
//

import UIKit

final class AnimatedTransition: NSObject {
    let animatedTransition: AnimatedTransitioning
    var isAnimated: Bool = true

    init(animatedTransition: AnimatedTransitioning, isAnimated: Bool = true) {
        self.animatedTransition = animatedTransition
        self.isAnimated = isAnimated
    }
}

extension AnimatedTransition: Transition {
    // MARK: - Transition

    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?)
    {
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .custom
        from.present(viewController, animated: isAnimated, completion: completion)
    }

    func close(_ viewController: UIViewController, completion: (() -> Void)?) {
        viewController.dismiss(animated: isAnimated, completion: completion)
    }
}

extension AnimatedTransition: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented _: UIViewController,
        presenting _: UIViewController,
        source _: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        animatedTransition.isPresenting = true
        return animatedTransition
    }

    func animationController(forDismissed _: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
        animatedTransition.isPresenting = false
        return animatedTransition
    }
}
