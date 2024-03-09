//
//  AppInfoUseCase.swift
//
//
//  Created by minguk-kim on 2023/06/04.
//

import Client
import Core
import Foundation
import JWTGenerator

public protocol AppInfoUseCase: Sendable {
    func fetchAppInfos(storedJWTInfo: JWTGenerator.MutaroJWT.JWTRequestInfo, myApps: [(id: String, name: String)]) async throws -> [AppInfo]
    func fetchMyApps(storedJWTInfo: JWTGenerator.MutaroJWT.JWTRequestInfo) async throws -> [MyAppsEntity.MyAppsData]
}

public final class AppInfoUseCaseImpl: AppInfoUseCase {
    private let client: any Providable

    public init(client: any Providable) {
        self.client = client
    }

    public func fetchMyApps(storedJWTInfo: JWTGenerator.MutaroJWT.JWTRequestInfo) async throws -> [MyAppsEntity.MyAppsData] {
        let builder = MutaroJWT.AppstoreConnectJWTBuilder(
            keyId: storedJWTInfo.keyID,
            issuerId: storedJWTInfo.issuerID,
            pemString: storedJWTInfo.privateKey
        )
        let token = try builder.generateJWT()
        let myApps = try await getMyApps(token: token)
        return myApps
    }

    public func fetchAppInfos(storedJWTInfo: JWTGenerator.MutaroJWT.JWTRequestInfo, myApps: [(id: String, name: String)]) async throws -> [AppInfo] {
        let builder = MutaroJWT.AppstoreConnectJWTBuilder(
            keyId: storedJWTInfo.keyID,
            issuerId: storedJWTInfo.issuerID,
            pemString: storedJWTInfo.privateKey
        )
        let token = try builder.generateJWT()
        let appInfos = try await getAppInfos(token: token, myApps: myApps)
        return appInfos
    }

    private func getMyApps(token: String) async throws -> [MyAppsEntity.MyAppsData] {
        let myAppsParameters = [
            "fields[apps]": "name"
        ]
        let myAppsEndpoint = MyAppsEndpoint.GetAllListMyApps(token: token, additionalParameters: myAppsParameters)
        let myAppsResult = await client.request(
            endpoint: myAppsEndpoint,
            responseModel: MyAppsDTO.self
        )
        let myAppsResultEntity = try myAppsResult.get().toEntity()

        return myAppsResultEntity.data ?? []
    }

    private func getAppInfos(token: String, myApps: [(id: String, name: String)]) async throws -> [AppInfo] {
        try await myApps
            .concurrentMap { [weak self] app -> AppInfo? in
                guard let self else {
                    return nil
                }
                let appId = app.0
                let appName = app.1

                let buildsEndpoint = BuildsEndpoint.GetAllBuilds(token: token, appId: appId, additionalParameters: [:])
                let buildsResult = await self.client.request(endpoint: buildsEndpoint, responseModel: BuildsDTO.self)

                guard let buildsResultEntity = try? buildsResult.get().toEntity(),
                      let datas = buildsResultEntity.data else {
                    return .init(
                        id: appId,
                        name: appName,
                        iconUrl: nil
                    )
                }
                let filteredDatas = datas.filter { datum in
                    datum.attributes?.uploadedDate != nil
                }
                guard let lastUploadedData = filteredDatas.sorted(by: { lhs, rhs in
                    guard let lhsUploadedDate = lhs.attributes?.uploadedDate,
                          let rhsUploadedDate = rhs.attributes?.uploadedDate else {
                        return true
                    }
                    return lhsUploadedDate > rhsUploadedDate
                }).first else {
                    return .init(
                        id: appId,
                        name: appName,
                        iconUrl: nil
                    )
                }

                let iconAsset = lastUploadedData.attributes?.iconAssetToken
                let width = iconAsset?.width ?? 167
                let height = iconAsset?.height ?? 167
                let imageUrl = iconAsset?.templateURL
                guard let parsedImageUrl = AppleImageTemplateUrlParser.parse(
                    url: imageUrl,
                    width: width,
                    height: height
                ) else {
                    return .init(
                        id: appId,
                        name: appName,
                        iconUrl: nil
                    )
                }
                return .init(
                    id: appId,
                    name: appName,
                    iconUrl: parsedImageUrl
                )
            }
            .compactMap { $0 }
    }
}
