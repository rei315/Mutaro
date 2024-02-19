//
//  AlertHUD.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import UIKit

public final class AlertHUD: NSObject {
    static let shared = AlertHUD()
    lazy var alertView: AlertView = .init(width: AlertHUD.shared.width, height: AlertHUD.shared.height)
    private let height: CGFloat = 60
    private lazy var width: CGFloat = UIScreen.main.bounds.width - 16
}

public extension AlertHUD {
    @MainActor
    static func show(
        _ title: String,
        backgroundColor: UIColor,
        font: UIFont,
        textColor: UIColor
    ) {
        let window = KeyWindowProvider().getKeyWindow()
        let centerXPos = window?.center.x ?? UIScreen.main.bounds.width / 2
        let topPadding = window?.rootViewController?.view.safeAreaInsets.top ?? 0

        shared.alertView.lets { view in
            view.show(
                title,
                backgroundColor: backgroundColor,
                font: font,
                textColor: textColor
            )
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapView))
            view.addGestureRecognizer(tapGesture)
            view.alpha = 0.2

            let xPos = centerXPos - view.frame.width / 2
            view.frame = .init(
                x: xPos,
                y: -view.frame.height,
                width: view.frame.width,
                height: view.frame.height
            )
            window?.addSubview(view)

            UIView.animate(withDuration: 0.5, delay: 0.5) {
                view.alpha = 0.9
                view.frame = .init(
                    x: xPos,
                    y: topPadding + 8,
                    width: view.frame.width,
                    height: view.frame.height
                )
            } completion: { _ in
                Task {
                    try await Task.sleep(seconds: 3)
                    hide()
                }
            }
        }
    }

    @MainActor
    static func hide() {
        guard shared.alertView.superview != nil else {
            return
        }
        shared.alertView.lets { view in
            UIView.animate(withDuration: 0.5) {
                view.alpha = 0.2
                view.frame = .init(
                    x: view.frame.minX,
                    y: -view.frame.height,
                    width: view.frame.width,
                    height: view.frame.height
                )
            } completion: { _ in
                view.removeFromSuperview()
            }
        }
    }

    @MainActor
    @objc static func onTapView() {
        hide()
    }
}
