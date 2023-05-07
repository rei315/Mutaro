//
//  ServiceManager.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import Core
import Foundation

public actor ServiceManager {
    static let shared = ServiceManager()

    private init() {}

    func getBaseUrl(_ pattern: BaseURL) -> String {
        pattern.get()
    }
}
