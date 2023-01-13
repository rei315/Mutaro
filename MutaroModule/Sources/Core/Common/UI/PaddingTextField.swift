//
//  PaddingTextField.swift
//  
//
//  Created by minguk-kim on 2023/01/14.
//

import UIKit

public class PaddingTextField: UITextField {
    public var textPadding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
