//
//  MyAppsViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import AppStoreRepository
import Combine
import Core
import Foundation
import ImageLoader
import JWTGenerator
import KeychainStore
import TestFlightRepository

protocol MyAppsViewModelProtocol {}

public final class MyAppsViewModel: NSObject, MyAppsViewModelProtocol {
    private let imageDownloadService: ImageDownloadable
    private let environment: MyAppsFeatureEnvironment

    let currentJWTInfoSubject = CurrentValueSubject<MutaroJWT.JWTRequestInfo?, Never>(nil)
    let appInfosSubject = CurrentValueSubject<[AppInfo], Never>([])

    var cancellables: Set<AnyCancellable> = []

    public init(
        environment: MyAppsFeatureEnvironment,
        imageDownloadService: ImageDownloadable = ImageDownloadService()
    ) {
        self.environment = environment
        self.imageDownloadService = imageDownloadService
    }

    func setupSubscription() {
        currentJWTInfoSubject
            .removeDuplicates()
            .compactMap { $0 }
            .sink { [weak self] in
                self?.fetchMyApps(storedJWTInfo: $0)
            }
            .store(in: &cancellables)
    }

    func loadStoredJWTInfo() {
        do {
            let storedJWTInfo: MutaroJWT.JWTRequestInfo = try KeychainStore.shared.loadValue(forKey: .jwt)
            guard let currentSavedJWTInfo = currentJWTInfoSubject.value, currentSavedJWTInfo != storedJWTInfo else {
                currentJWTInfoSubject.send(storedJWTInfo)
                return
            }
        } catch {
            // TODO: - show need to register
        }
    }

    func fetchMyApps(storedJWTInfo: MutaroJWT.JWTRequestInfo) {
        Task {
            let builder = MutaroJWT.AppstoreConnectJWTBuilder(
                keyId: storedJWTInfo.keyID,
                issuerId: storedJWTInfo.issuerID,
                pemString: storedJWTInfo.privateKey
            )
            guard let token = try? builder.generateJWT() else {
                // TODO: - show need to register
                print("Mins: failed generate token")
                return
            }

            do {
                let myApps = try await getMyApps(token: token)
                let appInfos = try await getAppInfos(token: token, myApps: myApps)
                appInfosSubject.send(appInfos)
            } catch {
                print("Mins: \(error)")
            }
        }
    }

    private func getMyApps(token: String) async throws -> [(String, String)] {
        let myAppsParameters = [
            "fields[apps]": "name"
        ]
        let myAppsEndpoint = MyAppsEndpoint.GetAllListMyApps(token: token, additionalParameters: myAppsParameters)
        let myAppsResult = await environment.client.request(endpoint: myAppsEndpoint, responseModel: MyAppsElement.self)
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
                let buildsResult = await self.environment.client.request(endpoint: buildsEndpoint, responseModel: BuildsElement.self)
                guard let buildsResultElement = try? buildsResult.get(),
                      let data = buildsResultElement.data?.first else {
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

    func prefetchItem(
        _ rowType: MyAppsViewController.MyAppsRow?
    ) {
        switch rowType {
        case .none, .registerJWT:
            break
        case let .app(index):
            guard let url = appInfosSubject.value[getOrNil: index]?.iconUrl else {
                return
            }
            imageDownloadService.downloadImage(with: url, cache: .myAppCache)
        }
    }

    func cancelPrefrechItem(
        _ rowType: MyAppsViewController.MyAppsRow?
    ) {
        switch rowType {
        case .none, .registerJWT:
            break
        case let .app(index):
            guard let url = appInfosSubject.value[getOrNil: index]?.iconUrl else {
                return
            }
            imageDownloadService.cancelDownloadImage(with: url)
        }
    }
}

extension MyAppsViewModel {
    struct AppInfo: Equatable {
        let id: String
        let name: String
        let iconUrl: String?
    }
}
