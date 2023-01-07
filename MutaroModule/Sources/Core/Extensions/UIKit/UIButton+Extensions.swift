//
//  UIButton+Extensions.swift
//
//
//  Created by minguk-kim on 2022/12/29.
//

import UIKit

extension UIButton {
    public func updateAction(_ targetEvent: UIControl.Event, action: @escaping () -> Void) {
        enumerateEventHandlers { action, targetAction, event, stop in
            guard targetEvent == event else {
                return
            }

            if let action = action {
                self.removeAction(action, for: event)
            }
            if let (target, selector) = targetAction {
                self.removeTarget(target, action: selector, for: event)
            }
        }

        addAction(
            .init(
                handler: { _ in
                    action()
                }
            ),
            for: targetEvent
        )
    }
}
