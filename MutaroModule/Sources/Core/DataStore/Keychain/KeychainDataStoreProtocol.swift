//
//  File.swift
//  
//
//  Created by minguk-kim on 2024/03/17.
//

import Foundation
import Security

public protocol KeychainDataStoreProtocol {
    func saveValue(_ value: some Codable, forKey key: KeychainStoreKey) throws
    func loadValue<T: Codable>(forKey key: KeychainStoreKey) throws -> T
    func deleteValue(forKey key: KeychainStoreKey) throws
}

public enum KeychainError: Error {
    case saveError(OSStatus)
    case loadError(OSStatus)
    case deleteError(OSStatus)
}
