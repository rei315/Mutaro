//
//  EmptyTransition.swift
//
//
//  Created by minguk-kim on 2023/01/12.
//

import UIKit

public final class EmptyTransition {
    public var isAnimated: Bool
    public init(isAnimated: Bool = true) {
        self.isAnimated = isAnimated
    }
}

extension EmptyTransition: Transition {
    // MARK: - Transition
    public func open(
        _ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?
    ) {}
    public func close(_ viewController: UIViewController, completion: (() -> Void)?) {}
}
