//
//  MyAppsViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Client
import Combine
import Core
import Foundation
import JWTGenerator
import KeychainStore

protocol MyAppsViewModelProtocol {}

public final class MyAppsViewModel: NSObject, MyAppsViewModelProtocol {
    typealias Routes = MyAppsRoute
    private let router: Routes
    let currentJWTInfo = CurrentValueSubject<MutaroJWT.JWTRequestInfo?, Never>(nil)

    var cancellables: Set<AnyCancellable> = []

    init(router: Routes) {
        self.router = router
    }

    func loadStoredJWTInfo() {
        guard let storedJWTInfo = try? KeychainStore.shared.get(MutaroJWT.JWTRequestInfo.self).first else {
            // TODO: - show need to register
            print("Mins: failed get stored jwt info")
            return
        }

        guard let currentSavedJWTInfo = currentJWTInfo.value, currentSavedJWTInfo != storedJWTInfo else {
            currentJWTInfo.send(storedJWTInfo)
            return
        }
    }

    func fetchMyApps(storedJWTInfo: MutaroJWT.JWTRequestInfo) async -> [AppInfo] {
        let builder = MutaroJWT.AppstoreConnectJWTBuilder(
            keyId: storedJWTInfo.keyID,
            issuerId: storedJWTInfo.issuerID,
            pemString: storedJWTInfo.privateKey
        )
        guard let token = try? builder.generateJWT() else {
            // TODO: - show need to register
            print("Mins: failed generate token")
            return []
        }

        do {
            let myApps = try await getMyApps(token: token)
            let appInfos = try await myApps.concurrentMap { app -> AppInfo? in
                let appId = app.0
                let appName = app.1
                let buildsParametr: [String: Any] = [
                    "filter[app]": appId,
                    "sort": "-uploadedDate",
                    "limit": 1
                ]
                let buildsEndpoint = BuildsEndpoint.GetAllBuilds(token: token, additionalParameters: buildsParametr)
                let buildsResult = await Provider.shared.request(endpoint: buildsEndpoint, responseModel: BuildsElement.self)
                guard let buildsResultElement = try? buildsResult.get(),
                      let data = buildsResultElement.data?.first else {
                    return nil
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
            }.compactMap { $0 }
            return appInfos
        } catch {
            return []
        }
    }

    private func getMyApps(token: String) async throws -> [(String, String)] {
        let myAppsParameters = [
            "fields[apps]": "name"
        ]
        let myAppsEndpoint = MyAppsEndpoint.GetAllListMyApps(token: token, additionalParameters: myAppsParameters)
        let myAppsResult = await Provider.shared.request(endpoint: myAppsEndpoint, responseModel: MyAppsElement.self)
        let myAppsResultElement = try myAppsResult.get()
        let appInfos = myAppsResultElement.data?
            .compactMap { data -> (String, String)? in
                guard let id = data.id,
                      let name = data.attributes?.name else {
                    return nil
                }
                return (id, name)
            }

        return appInfos ?? []
    }

    struct AppInfo {
        let id: String
        let name: String
        let iconUrl: String
    }
}
