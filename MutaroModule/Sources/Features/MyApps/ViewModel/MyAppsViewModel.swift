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

protocol MyAppsViewModelProtocol {
    func transform(input: MyAppsViewModel.Input) -> MyAppsViewModel.Output
    func getAppInfos(_ index: Int) -> AppInfo?
}

extension MyAppsViewModel {
    struct Input {
        let viewWillAppear: AnyPublisher<Void, Never>
        let viewDidLoad: AnyPublisher<Void, Never>
        let didTapMyApp: AnyPublisher<(from: UIViewController, index: Int), Never>
        let didTapRegisterJWT: AnyPublisher<UIViewController, Never>
        let prefetchItem: AnyPublisher<MyAppsViewController.MyAppsRow?, Never>
        let cancelPrefetch: AnyPublisher<MyAppsViewController.MyAppsRow?, Never>
    }

    struct Output {
        let showJWTRegister: AnyPublisher<Bool, Never>
        let onUpdateAppInfos: AnyPublisher<[AppInfo], Never>
    }
}

public final class MyAppsViewModel: NSObject, MyAppsViewModelProtocol {
    private let environment: MyAppsFeatureEnvironment

    private let appInfosSubject: CurrentValueSubject<[AppInfo], Never> = .init([])
    private let myAppsSubject: CurrentValueSubject<[MyAppsEntity.MyAppsData], Never> = .init([])
    private let showRegisterJWT: PassthroughSubject<Bool, Never> = .init()

    private var cancellables: Set<AnyCancellable> = []

    public init(
        environment: MyAppsFeatureEnvironment
    ) {
        self.environment = environment
    }

    func transform(input: Input) -> Output {
        let viewWillAppear = input
            .viewWillAppear
            .share()

        let myApps = viewWillAppear
            .asyncMapThrows { try await self.fetchMyApps() }
            .eraseToAnyPublisher()
            .share()

        myApps
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.showRegisterJWT.send(false)
                case .failure:
                    self?.showRegisterJWT.send(true)
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)

        myApps
            .replaceError(with: [])
            .assign(to: \.value, on: myAppsSubject)
            .store(in: &cancellables)

        let appInfos = myApps
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .asyncMapThrows { try await self.fetchAppInfos(myApps: $0) }
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .share()

        appInfos
            .assign(to: \.value, on: appInfosSubject)
            .store(in: &cancellables)

        input
            .didTapMyApp
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.onTapMyApp(from: $0.from, index: $0.index)
            }
            .store(in: &cancellables)

        input
            .didTapRegisterJWT
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.onTapRegisterJWT(from: $0)
            }
            .store(in: &cancellables)

        input
            .prefetchItem
            .sink { [weak self] in
                self?.prefetchItem($0)
            }
            .store(in: &cancellables)

        input
            .cancelPrefetch
            .sink { [weak self] in
                self?.cancelPrefrechItem($0)
            }
            .store(in: &cancellables)

        return .init(
            showJWTRegister: showRegisterJWT.eraseToAnyPublisher(),
            onUpdateAppInfos: appInfosSubject.eraseToAnyPublisher()
        )
    }

    private func fetchMyApps() async throws -> [MyAppsEntity.MyAppsData] {
        do {
            let storedJWTInfo: MutaroJWT.JWTRequestInfo = try KeychainStore.shared.loadValue(forKey: .jwt)
            let myApps = try? await environment.appInfoUseCase.fetchMyApps(storedJWTInfo: storedJWTInfo)
            return myApps ?? []
        } catch {
            throw JWTError.loadError
        }
    }

    private func fetchAppInfos(myApps: [MyAppsEntity.MyAppsData]) async throws -> [AppInfo] {
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
        return appInfos
    }

    private func onTapRegisterJWT(from viewController: UIViewController) {
        environment.router.showRegisterJWT(from: viewController)
    }

    private func onTapMyApp(from viewController: UIViewController, index: Int) {
        guard let appInfo = appInfosSubject.value[getOrNil: index] else {
            return
        }
        environment.router.showMyAppTools(from: viewController, appId: appInfo.id)
    }

    private func prefetchItem(
        _ rowType: MyAppsViewController.MyAppsRow?
    ) {
        switch rowType {
        case .none, .registerJWT:
            break
        case let .app(index):
            guard let url = appInfosSubject.value[getOrNil: index]?.iconUrl else {
                return
            }
            let cache = ImageCacheType.myAppCache.getCache()
            environment.imageDownloadService.downloadImage(with: url, cache: cache)
        }
    }

    private func cancelPrefrechItem(
        _ rowType: MyAppsViewController.MyAppsRow?
    ) {
        switch rowType {
        case .none, .registerJWT:
            break
        case let .app(index):
            guard let url = appInfosSubject.value[getOrNil: index]?.iconUrl else {
                return
            }
            environment.imageDownloadService.cancelDownloadImage(with: url)
        }
    }
}

extension MyAppsViewModel {
    func getAppInfos(_ index: Int) -> AppInfo? {
        appInfosSubject.value[getOrNil: index]
    }
}

extension MyAppsViewModel {
    enum JWTError: Error {
        case loadError
    }
}
