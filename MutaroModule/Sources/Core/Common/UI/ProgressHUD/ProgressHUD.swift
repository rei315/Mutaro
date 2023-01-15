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
        KeyWindowProvider().getKeyWindow()?.addSubview(shared.loadingView)
    }

    public static func hide() {
        shared.loadingView.removeFromSuperview()
    }
}
