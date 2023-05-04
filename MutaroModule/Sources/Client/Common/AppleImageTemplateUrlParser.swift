//
//  AppleImageTemplateUrlParser.swift
//
//
//  Created by minguk-kim on 2023/05/05.
//

import Foundation

public enum AppleImageTemplateUrlParser {
    public static func parse(url: String?, width: Int, height: Int) -> String? {
        guard let url else {
            return nil
        }
        return url
            .replacingOccurrences(of: "{w}", with: "\(width)")
            .replacingOccurrences(of: "{h}", with: "\(height)")
            .replacingOccurrences(of: ".{w}", with: ".jpeg")
    }
}
