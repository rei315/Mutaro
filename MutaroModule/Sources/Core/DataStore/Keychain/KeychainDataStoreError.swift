//
//  File.swift
//  
//
//  Created by minguk-kim on 2024/03/17.
//

import Foundation
import Security

public enum KeychainError: Error {
    case saveError(OSStatus)
    case loadError(OSStatus)
    case deleteError(OSStatus)
}
