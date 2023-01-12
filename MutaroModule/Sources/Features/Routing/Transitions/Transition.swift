//
//  Transition.swift
//
//
//  Created by minguk-kim on 2023/01/12.
//

import UIKit

public protocol Transition: AnyObject {
    var isAnimated: Bool { get set }

    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?)
    func close(_ viewController: UIViewController, completion: (() -> Void)?)
}
