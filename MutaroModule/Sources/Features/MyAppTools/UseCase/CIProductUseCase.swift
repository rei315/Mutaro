//
//  CIProductUseCase.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import Client
import Core
import Foundation
import JWTGenerator

public protocol CIProductUseCase {
    func fetchCIProducts(storedJWTInfo: JWTGenerator.MutaroJWT.JWTRequestInfo, appId: String) async throws -> CIProductsEntity.CIProductsData?
}

public final class CIProductUseCaseImp: CIProductUseCase {
    private let client: Providable

    public init(client: Providable) {
        self.client = client
    }

    public func fetchCIProducts(storedJWTInfo: JWTGenerator.MutaroJWT.JWTRequestInfo, appId: String) async throws -> CIProductsEntity.CIProductsData? {
        let builder = MutaroJWT.AppstoreConnectJWTBuilder(
            keyId: storedJWTInfo.keyID,
            issuerId: storedJWTInfo.issuerID,
            pemString: storedJWTInfo.privateKey
        )
        let token = try builder.generateJWT()
        let ciProducts = try await getCIProducts(token: token, appId: appId)
        return ciProducts
    }

    private func getCIProducts(token: String, appId: String) async throws -> CIProductsEntity.CIProductsData? {
        let ciProductsEndpoint = CIProductsEndpoint.GetAllProducts(
            token: token,
            appId: appId,
            additionalParameters: [:]
        )
        let ciProductsResult = await client.request(
            endpoint: ciProductsEndpoint,
            responseModel: CIProductsDTO.self
        )
        let ciProductsEntity = try ciProductsResult.get().toEntity()
        return ciProductsEntity.data
    }
}
