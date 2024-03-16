//
//  KeychainStore.swift
//
//
//  Created by minguk-kim on 2023/05/04.
//

import Foundation
import Security
import Core

public struct KeychainDataStore: KeychainDataStoreProtocol, Sendable {
    private let service = Bundle.main.bundleIdentifier ?? "Mutaro.com"

    public init() {}
    
    public func saveValue(_ value: some Codable, forKey key: KeychainStoreKey) throws {
        let data = try JSONEncoder().encode(value)

        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key.rawValue
        ]

        let updateQuery: [CFString: Any] = [
            kSecValueData: data
        ]

        let status = SecItemUpdate(query as CFDictionary, updateQuery as CFDictionary)

        if status == errSecItemNotFound {
            var fullQuery = query
            fullQuery[kSecValueData] = data

            let status = SecItemAdd(fullQuery as CFDictionary, nil)

            if status != errSecSuccess {
                throw KeychainError.saveError(status)
            }
        } else if status != errSecSuccess {
            throw KeychainError.saveError(status)
        }
    }

    public func loadValue<T: Codable>(forKey key: KeychainStoreKey) throws -> T {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key.rawValue,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: kCFBooleanTrue as Any
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status != errSecItemNotFound else {
            throw KeychainError.loadError(status)
        }

        guard status == errSecSuccess, let data = result as? Data else {
            throw KeychainError.loadError(status)
        }

        let value = try JSONDecoder().decode(T.self, from: data)
        return value
    }

    public func deleteValue(forKey key: KeychainStoreKey) throws {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key.rawValue
        ]

        let status = SecItemDelete(query as CFDictionary)

        if status != errSecSuccess, status != errSecItemNotFound {
            throw KeychainError.deleteError(status)
        }
    }
}
