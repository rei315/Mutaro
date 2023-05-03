//
//  File.swift
//
//
//  Created by minguk-kim on 2023/01/14.
//

import Foundation

extension DateFormatter {
    func getJPDateString(format: String = "yyyy/MM/dd HH:mm") -> String {
        lets {
            $0.dateFormat = format
            $0.calendar = Calendar(identifier: .gregorian)
            $0.locale = Locale(identifier: "ja_JP")
            $0.timeZone = TimeZone(identifier: "Asia/Tokyo")
        }

        let dateString = string(from: Date())
        return dateString
    }
}
