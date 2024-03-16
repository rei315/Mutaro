//
//  MyAppToolsModel.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import Combine
import Core
import Foundation
import JWTGenerator
import KeychainStore
import UIKit

struct MyAppToolsModel {
    private let appId: String
    private let ciProductUseCase: any CIProductUseCase

    init(appId: String, ciProductUseCase: any CIProductUseCase) {
        self.appId = appId
        self.ciProductUseCase = ciProductUseCase
    }

    func checkAvailableItems(
        ciProduct: CIProductsEntity.CIProductsData?
    ) -> [ItemType] {
        var result: [ItemType] = []

        let isEnabledXcodeCloud = ciProduct != nil
        if isEnabledXcodeCloud {
            result.append(.xcodeCloud)
        }

        return result
    }

    func getCIProducts() async -> CIProductsEntity.CIProductsData? {
        do {
            let storedJWTInfo: MutaroJWT.JWTRequestInfo = try KeychainDataStore.shared.loadValue(forKey: .jwt)
            let ciProducts = try await ciProductUseCase.fetchCIProducts(
                storedJWTInfo: storedJWTInfo,
                appId: appId
            )
            return ciProducts
        } catch {
            return nil
        }
    }
}

extension MyAppToolsModel {
    public enum ItemType: Equatable {
        case xcodeCloud

        var title: String {
            switch self {
            case .xcodeCloud:
                return "XcodeCloud"
            }
        }

        var icon: UIImage? {
            switch self {
            case .xcodeCloud:
                return .init(systemName: "cloud")
            }
        }
    }
}
