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

public protocol AppInfoUseCase {
    func fetchAppInfos(storedJWTInfo: MutaroJWT.JWTRequestInfo) async throws -> [AppInfo]
}

public final class AppInfoUseCaseImpl: AppInfoUseCase {
    private let client: Providable

    public init(client: Providable) {
        self.client = client
    }

    public func fetchAppInfos(storedJWTInfo: JWTGenerator.MutaroJWT.JWTRequestInfo) async throws -> [AppInfo] {
        let builder = MutaroJWT.AppstoreConnectJWTBuilder(
            keyId: storedJWTInfo.keyID,
            issuerId: storedJWTInfo.issuerID,
            pemString: storedJWTInfo.privateKey
        )
        let token = try builder.generateJWT()
        let myApps = try await getMyApps(token: token)
        let appInfos = try await getAppInfos(token: token, myApps: myApps)
        return appInfos
    }

    private func getMyApps(token: String) async throws -> [(String, String)] {
        let myAppsParameters = [
            "fields[apps]": "name"
        ]
        let myAppsEndpoint = MyAppsEndpoint.GetAllListMyApps(token: token, additionalParameters: myAppsParameters)
        let myAppsResult = await client.request(
            endpoint: myAppsEndpoint,
            responseModel: MyAppsDTO.self
        )
        let myAppsResultEntity = try myAppsResult.get().toEntity()
        let appInfos = myAppsResultEntity.data?
            .compactMap { data -> (String, String)? in
                guard let id = data.id,
                      let name = data.attributes?.name else {
                    return nil
                }
                return (id, name)
            }

        return appInfos ?? []
    }

    private func getAppInfos(token: String, myApps: [(String, String)]) async throws -> [AppInfo] {
        try await myApps
            .concurrentMap { [weak self] app -> AppInfo? in
                guard let self else {
                    return nil
                }
                let appId = app.0
                let appName = app.1

                let buildsParametr: [String: Any] = [
                    "filter[app]": appId,
                    "sort": "-uploadedDate",
                    "limit": 1
                ]
                let buildsEndpoint = BuildsEndpoint.GetAllBuilds(token: token, additionalParameters: buildsParametr)
                let buildsResult = await self.client.request(endpoint: buildsEndpoint, responseModel: BuildsDTO.self)
                guard let buildsResultEntity = try? buildsResult.get().toEntity(),
                      let data = buildsResultEntity.data?.first else {
                    return .init(
                        id: appId,
                        name: appName,
                        iconUrl: nil
                    )
                }
                let iconAsset = data.attributes?.iconAssetToken
                let width = iconAsset?.width ?? 167
                let height = iconAsset?.height ?? 167
                let imageUrl = iconAsset?.templateURL
                guard let parsedImageUrl = AppleImageTemplateUrlParser.parse(
                    url: imageUrl,
                    width: width,
                    height: height
                ) else {
                    return nil
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
