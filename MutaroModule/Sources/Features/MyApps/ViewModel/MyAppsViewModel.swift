//
//  MyAppsViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Combine
import Core
import Foundation
import ImageLoader
import JWTGenerator
import KeychainStore
import UIKit

protocol MyAppsViewModelProtocol {}

public final class MyAppsViewModel: NSObject, MyAppsViewModelProtocol {
    private let environment: MyAppsFeatureEnvironment

    var currentJWTInfo: MutaroJWT.JWTRequestInfo?
    @currentPublished private(set) var appInfosSubject: [AppInfo] = []
    let shouldShowRegisterJWTSubject = PassthroughSubject<Bool, Never>()
    var cancellables: Set<AnyCancellable> = []

    public init(
        environment: MyAppsFeatureEnvironment
    ) {
        self.environment = environment
    }

    func loadStoredJWTInfo() async {
        do {
            let storedJWTInfo: MutaroJWT.JWTRequestInfo = try KeychainStore.shared.loadValue(forKey: .jwt)

            if let currentJWTInfo, currentJWTInfo != storedJWTInfo {
                shouldShowRegisterJWTSubject.send(true)
                return
            }

            shouldShowRegisterJWTSubject.send(false)
            currentJWTInfo = storedJWTInfo
            let appInfos = try await environment.appInfoUseCase.fetchAppInfos(storedJWTInfo: storedJWTInfo)
            appInfosSubject = appInfos
        } catch {
            shouldShowRegisterJWTSubject.send(true)
        }
    }

    func onTapRegisterJWT(from viewController: UIViewController) {
        environment.router.showRegisterJWT(from: viewController)
    }

    func prefetchItem(
        _ rowType: MyAppsViewController.MyAppsRow?
    ) {
        switch rowType {
        case .none, .registerJWT:
            break
        case let .app(index):

            guard let url = appInfosSubject[getOrNil: index]?.iconUrl else {
                return
            }
            let cache = ImageCacheType.myAppCache.getCache()
            environment.imageDownloadService.downloadImage(with: url, cache: cache)
        }
    }

    func cancelPrefrechItem(
        _ rowType: MyAppsViewController.MyAppsRow?
    ) {
        switch rowType {
        case .none, .registerJWT:
            break
        case let .app(index):
            guard let url = appInfosSubject[getOrNil: index]?.iconUrl else {
                return
            }
            environment.imageDownloadService.cancelDownloadImage(with: url)
        }
    }
}
