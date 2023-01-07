//
//  File.swift
//
//
//  Created by minguk-kim on 2023/01/02.
//

import UIKit

public enum AppColor: Int {
    case white = 0xFFFFFF
    case black = 0x000000

    case wine = 0xD70025
    case darkTurquoise = 0x008D9B
    case turquoise = 0x02A49F
    case lightTurquoise = 0xEDF8F8

    case navy = 0x2E2E3B
    case navy70 = 0x62626C
    case navy40 = 0x8C8C93
    case navy20 = 0xD5D5D8
    case navy10 = 0xEAEAEB
    case navy05 = 0xF4F4F5
    case darkGrey = 0x333333
    case grey = 0x6C6C75

    case red = 0xE52E39

    public func toColor() -> UIColor {
        return color(rawValue)
    }

    public func toColorWith(alpha: CGFloat) -> UIColor {
        return colorWithAlpha(rawValue, alpha)
    }

    public func toHex() -> String {
        return String(format: "#%06x", rawValue)
    }

    private func color(_ hexCode: Int) -> UIColor {
        colorWithAlpha(hexCode, 1.0)
    }

    private func colorWithAlpha(_ hexCode: Int, _ alpha: CGFloat) -> UIColor {
        let red = CGFloat((hexCode & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexCode & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hexCode & 0x0000FF) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
