//
//  RandomStringCreator.swift
//
//
//  Created by minguk-kim on 2023/01/14.
//

import Foundation

struct RandomStringCreator {
    static func randomString(length: Int = 16) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
}
