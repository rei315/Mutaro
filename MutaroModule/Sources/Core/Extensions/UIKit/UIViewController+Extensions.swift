//
//  UIViewController+Extensions.swift
//
//
//  Created by minguk-kim on 2022/12/29.
//

import UIKit

private var lastHideNavBarVCAssociationKey = 0

extension UIViewController {
    private static var lastHideNavBarVC: UIViewController? {
        get {
            return objc_getAssociatedObject(UIViewController.self, &lastHideNavBarVCAssociationKey)
                as? UIViewController
        }
        set {
            objc_setAssociatedObject(
                UIViewController.self, &lastHideNavBarVCAssociationKey, newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    // call this method in `viewVillAppear`
    func hideNavigationBar(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        UIViewController.lastHideNavBarVC = self
    }

    // call this method in `viewVillDisappear`
    func showNavigationBarIfNeeded(_ animated: Bool, forceHideNavigationBar: Bool = false) {
        if self == UIViewController.lastHideNavBarVC || forceHideNavigationBar {
            UIViewController.lastHideNavBarVC = nil
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
}

extension UIViewController {
    public func setSmallTitle() {
        navigationItem.largeTitleDisplayMode = .never
    }
}
