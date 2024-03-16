//
//  RegisterJWTViewModel.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import Combine
import Core
import Foundation
import JWTGenerator
import KeychainStore
import UIKit

@MainActor
public protocol RegisterJWTRoute {
    func openRegisterJWTRoute()
}

@MainActor
protocol RegisterJWTViewModelProtocol {
    func transform(input: RegisterJWTViewModel.Input) -> RegisterJWTViewModel.Output
}

extension RegisterJWTViewModel {
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let didPickedPrivateKeyFile: AnyPublisher<[URL], Never>
        let didTapRegister: AnyPublisher<RegisterItem, Never>
    }

    struct Output {
        let showAlert: AnyPublisher<AlertState, Never>
        let onUpdateSavedInfo: AnyPublisher<MutaroJWT.JWTRequestInfo, Never>
        let didPickPrivateKeyFile: AnyPublisher<String, Never>
    }
}

@MainActor
public final class RegisterJWTViewModel: RegisterJWTViewModelProtocol, Sendable {
    private let showAlertSubject = PassthroughSubject<AlertState, Never>()
    private var cancellables: Set<AnyCancellable> = []
    private let taskCancellables: TaskCancellable = .init()

    private let environment: RegisterJWTFeatureEnvironment

    public init(environment: RegisterJWTFeatureEnvironment) {
        self.environment = environment
    }

    func transform(input: Input) -> Output {
        let registeredInfo = input
            .viewDidLoad
            .compactMap { self.loadRegisteredInfo() }

        let privateKey = input
            .didPickedPrivateKeyFile
            .compactMap { self.didPickDocuments(urls: $0) }

        input
            .didTapRegister
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.onTapRegister(item: $0)
            }
            .store(in: &cancellables)

        return .init(
            showAlert: showAlertSubject.eraseToAnyPublisher(),
            onUpdateSavedInfo: registeredInfo.eraseToAnyPublisher(),
            didPickPrivateKeyFile: privateKey.eraseToAnyPublisher()
        )
    }

    private func onTapRegister(
        item: RegisterItem
    ) {
        guard let issuerID = item.issuerID,
              !issuerID.isEmpty else {
            showAlertSubject.send(.invalidIssuerID)
            return
        }

        guard let keyID = item.keyID,
              !keyID.isEmpty else {
            showAlertSubject.send(.invalidKeyID)
            return
        }

        guard let privateKey = item.privateKey,
              !privateKey.isEmpty else {
            showAlertSubject.send(.invalidPrivateKey)
            return
        }

        let builder = MutaroJWT.AppstoreConnectJWTBuilder(
            keyId: keyID,
            issuerId: issuerID,
            pemString: privateKey
        )

        guard (try? builder.generateJWT()) != nil else {
            showAlertSubject.send(.invalidToken)
            return
        }

        let info = MutaroJWT.JWTRequestInfo(
            issuerID: issuerID,
            keyID: keyID,
            privateKey: privateKey
        )

        do {
            try KeychainDataStore.shared.deleteValue(forKey: .jwt)
            try KeychainDataStore.shared.saveValue(info, forKey: .jwt)
            showAlertSubject.send(.successedSavingJWTReuqestInfo)
            environment.router.close(from: item.viewController)
        } catch {
            showAlertSubject.send(.failedSavingJWTRequestInfo)
        }
    }

    private func loadRegisteredInfo() -> MutaroJWT.JWTRequestInfo? {
        try? KeychainDataStore.shared.loadValue(forKey: .jwt)
    }

    private func didPickDocuments(urls: [URL]) -> String? {
        guard let url = urls.first,
              let data = try? Data(contentsOf: url) else {
            return nil
        }

        let privateKey = String(decoding: data, as: UTF8.self)
        return privateKey
    }
}

extension RegisterJWTViewModel {
    enum AlertState {
        case invalidIssuerID
        case invalidKeyID
        case invalidPrivateKey
        case invalidToken
        case failedSavingJWTRequestInfo
        case successedSavingJWTReuqestInfo

        var title: String {
            let string: String

            switch self {
            case .invalidIssuerID:
                string = "Issuer IDに値を追加してください。"
            case .invalidKeyID:
                string = "Key IDに値を追加してください。"
            case .invalidPrivateKey:
                string = "Private Keyに値を追加してください。"
            case .invalidToken:
                string = "正しい値が入ってないため、JWTの生成が失敗しました。"
            case .failedSavingJWTRequestInfo:
                string = "Keychainに保存を失敗しました。"
            case .successedSavingJWTReuqestInfo:
                string = "入力した情報を保存しました。"
            }

            return string
        }
    }

    struct RegisterItem: Sendable {
        let viewController: UIViewController
        let issuerID: String?
        let keyID: String?
        let privateKey: String?
    }
}
