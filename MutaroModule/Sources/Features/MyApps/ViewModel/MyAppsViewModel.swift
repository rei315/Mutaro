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
    @currentPublished private(set) var myAppsSubject: [MyAppsEntity.MyAppsData] = []
    let shouldShowRegisterJWTSubject = PassthroughSubject<Bool, Never>()
    var cancellables: Set<AnyCancellable> = []
    let taskCancellable = TaskCancellable()

    public init(
        environment: MyAppsFeatureEnvironment
    ) {
        self.environment = environment
    }

    func setupSubscription() {
        $myAppsSubject
            .sink { [weak self] in
                self?.fetchAppInfos(myApps: $0)
            }
            .store(in: &cancellables)
    }

    func fetchMyApps() async {
        do {
            let storedJWTInfo: MutaroJWT.JWTRequestInfo = try KeychainStore.shared.loadValue(forKey: .jwt)
            shouldShowRegisterJWTSubject.send(false)
            let myApps = try await environment.appInfoUseCase.fetchMyApps(storedJWTInfo: storedJWTInfo)
            myAppsSubject = myApps
        } catch {
            shouldShowRegisterJWTSubject.send(true)
        }
    }

    func fetchAppInfos(myApps: [MyAppsEntity.MyAppsData]) {
        Task {
            do {
                let storedJWTInfo: MutaroJWT.JWTRequestInfo = try KeychainStore.shared.loadValue(forKey: .jwt)
                let myAppsInfo = myApps
                    .compactMap { data -> (String, String)? in
                        guard let id = data.id,
                              let name = data.attributes?.name else {
                            return nil
                        }
                        return (id, name)
                    }
                let appInfos = try await environment.appInfoUseCase.fetchAppInfos(storedJWTInfo: storedJWTInfo, myApps: myAppsInfo)
                appInfosSubject = appInfos
            } catch {
                shouldShowRegisterJWTSubject.send(true)
            }
        }
        .store(in: taskCancellable)
    }

    func onTapRegisterJWT(from viewController: UIViewController) {
        environment.router.showRegisterJWT(from: viewController)
    }

    func onTapMyApp(from viewController: UIViewController, index: Int) {
        guard let appInfo = appInfosSubject[getOrNil: index] else {
            return
        }
        environment.router.showMyAppTools(from: viewController, appId: appInfo.id)
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
