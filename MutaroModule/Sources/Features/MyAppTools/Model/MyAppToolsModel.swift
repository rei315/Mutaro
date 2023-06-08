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

actor MyAppToolsModel {
    private let appId: String
    private var toolItems: ToolItem {
        didSet {
            checkAvailableItems(item: toolItems)
        }
    }

    private let ciProductUseCase: CIProductUseCase

    public let itemTypeSubject = PassthroughSubject<[ItemType], Never>()

    init(appId: String, ciProductUseCase: CIProductUseCase) {
        self.appId = appId
        toolItems = .init()
        self.ciProductUseCase = ciProductUseCase
    }

    func fetch() async {
        toolItems.ciProductsData = await getCIProducts()
    }

    private func checkAvailableItems(
        item: ToolItem
    ) {
        var result: [ItemType] = []

        let isEnabledXcodeCloud = item.ciProductsData != nil
        if isEnabledXcodeCloud {
            result.append(.xcodeCloud)
        }

        itemTypeSubject.send(result)
    }

    private func getCIProducts() async -> CIProductsEntity.CIProductsData? {
        do {
            let storedJWTInfo: MutaroJWT.JWTRequestInfo = try KeychainStore.shared.loadValue(forKey: .jwt)
            let ciProducts = try await ciProductUseCase.fetchCIProducts(
                storedJWTInfo: storedJWTInfo,
                appId: appId
            )
            return ciProducts
        } catch {
            return nil
        }
    }

    func getXcodeCloudData() -> CIProductsEntity.CIProductsData? {
        toolItems.ciProductsData
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

    struct ToolItem {
        var ciProductsData: CIProductsEntity.CIProductsData?

        init(ciProductsData: CIProductsEntity.CIProductsData? = nil) {
            self.ciProductsData = ciProductsData
        }
    }
}
