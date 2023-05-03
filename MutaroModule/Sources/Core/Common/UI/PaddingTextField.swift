//
//  PaddingTextField.swift
//
//
//  Created by minguk-kim on 2023/01/14.
//

import UIKit

public final class PaddingTextField: UITextField {
    public var textPadding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
