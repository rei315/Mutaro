//
//  File.swift
//
//
//  Created by minguk-kim on 2023/05/04.
//

import Foundation

public extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(
                  withJSONObject: jsonObject,
                  options: [.prettyPrinted]
              ),
              let prettyJSON = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            return nil
        }

        return prettyJSON
    }
}
