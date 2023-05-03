//
//  File.swift
//
//
//  Created by minguk-kim on 2023/01/11.
//

import UIKit

public enum FontSize: CGFloat {
    /**
     font size of 32.0
     */
    case plus5 = 32.0
    /**
     font size of 22.0
     */
    case plus4 = 22.0
    /**
     font size of 20.0
     */
    case plus3 = 20.0
    /**
     font size of 18.0
     */
    case plus2 = 18.0
    /**
     font size of 16.0
     */
    case plus1 = 16.0
    /**
     font size of 15.0
     */
    case base = 15.0
    /**
     font size of 13.0
     */
    case minus1 = 13.0
    /**
     font size of 11.0
     */
    case minus2 = 11.0
    /**
     font size of 10.0
     */
    case minus3 = 10.0
    /**
     font size of 8.0
     */
    case minus4 = 8.0

    public func ofFont() -> UIFont {
        UIFont.systemFont(ofSize: rawValue)
    }

    public func ofBoldFont() -> UIFont {
        UIFont.boldSystemFont(ofSize: rawValue)
    }
}
