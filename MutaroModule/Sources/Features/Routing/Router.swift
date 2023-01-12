//
//  Router.swift
//
//
//  Created by minguk-kim on 2023/01/12.
//

import UIKit

public protocol Closable: AnyObject {
    func close()

    func close(completion: (() -> Void)?)
}

public protocol Dismissable: AnyObject {
    func dismiss()

    func dismiss(completion: (() -> Void)?)
}

public protocol Routable: AnyObject {
    func route(to viewController: UIViewController, as transition: Transition)

    func route(
        to viewController: UIViewController, as transition: Transition, completion: (() -> Void)?)
}

public protocol Router: Routable {
    var root: UIViewController? { get set }
}
