//
//  KeychainStore.swift
//
//
//  Created by minguk-kim on 2023/05/04.
//

import Foundation
import Security

public final class KeychainStore {
    public static let shared = KeychainStore()

    private let service = Bundle.main.bundleIdentifier ?? "Mutaro.com"
    private let teamID = Bundle.main.object(forInfoDictionaryKey: "AppIdentifierPrefix") ?? "key"
    private lazy var accessGroup = "\(teamID)\(service)"

    public func save(_ element: some Codable, forKey key: String) throws -> Bool {
        let encoder = JSONEncoder()
        let infoData = try encoder.encode(element)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrService as String: service,
            kSecValueData as String: infoData,
            kSecAttrAccessGroup as String: accessGroup
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    public func get<T: Codable>(_: T.Type) throws -> [T] {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecMatchLimit: kSecMatchLimitAll,
            kSecReturnAttributes: true,
            kSecReturnData: true,
            kSecAttrAccessGroup: accessGroup
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }
        guard let items = result as? [[CFString: Any]] else {
            throw KeychainError.unexpectedData
        }
        let decoder = JSONDecoder()
        return try items.compactMap { item in
            guard let itemData = item[kSecValueData] as? Data else {
                return nil
            }
            return try decoder.decode(T.self, from: itemData)
        }
    }

    @discardableResult
    public func delete(_: (some Codable).Type) -> Bool {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccessGroup: accessGroup
        ]
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess || status == errSecItemNotFound
    }
}

enum KeychainError: Error {
    case unhandledError(status: OSStatus)
    case unexpectedData
}
