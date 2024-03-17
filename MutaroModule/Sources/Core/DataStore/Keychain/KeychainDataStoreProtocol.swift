//
//  KeychainDataStoreProtocol.swift
//
//
//  Created by minguk-kim on 2024/03/17.
//

import Foundation
import Security

public protocol KeychainDataStoreProtocol: Sendable {
    func saveValue(_ value: some Codable & Sendable, forKey key: KeychainStoreKey) throws
    func loadValue<T: Codable & Sendable>(forKey key: KeychainStoreKey) throws -> T
    func deleteValue(forKey key: KeychainStoreKey) throws
}
