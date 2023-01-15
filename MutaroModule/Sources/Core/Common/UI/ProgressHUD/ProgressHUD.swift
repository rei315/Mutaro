//
//  ProgressHUD.swift
//
//
//  Created by minguk-kim on 2023/01/15.
//

import UIKit

public final class ProgressHUD {
    static let shared = ProgressHUD()
    let loadingView: LoadingView = .init(frame: UIScreen.main.bounds)
}

extension ProgressHUD {
    public static func show() {
        shared.loadingView.alpha = 0
        KeyWindowProvider().getKeyWindow()?.addSubview(shared.loadingView)
        UIView.animate(
            withDuration: 0.2,
            animations: {
                shared.loadingView.alpha = 1
            })
    }

    public static func hide() {
        UIView.animate(
            withDuration: 0.2,
            animations: {
                shared.loadingView.alpha = 0
            }
        ) { _ in
            shared.loadingView.removeFromSuperview()
        }
    }
}
