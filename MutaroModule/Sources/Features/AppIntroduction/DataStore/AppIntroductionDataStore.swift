//
//  AppIntroductionDataStore.swift
//
//
//  Created by minguk-kim on 2024/03/17.
//

import Foundation
import Core

public protocol AppIntroductionDataStoreProtocol: Sendable {
    func storeFirstLaunchStatus(with status: Bool)
}

public final class AppIntroductionDataStore: AppIntroductionDataStoreProtocol, Sendable {
    public func storeFirstLaunchStatus(with status: Bool) {
        UserDefaults.standard.set(status, forKey: UserDefaultsKey.notFirstAppLaunching.rawValue)
    }
}
