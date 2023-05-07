//
//  RegisterJWTViewModel.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import Combine
import Foundation
import JWTGenerator
import KeychainStore
import UIKit

public protocol RegisterJWTRoute {
    func openRegisterJWTRoute()
}

public final class RegisterJWTViewModel {
    let showAlertSubject = PassthroughSubject<AlertState, Never>()
    let showSavedInfoSubject = PassthroughSubject<MutaroJWT.JWTRequestInfo, Never>()
    let didPickPrivateKeyFileSubject = PassthroughSubject<String, Never>()
    var cancellables: Set<AnyCancellable> = []

    private let environment: RegisterJWTFeatureEnvironment

    public init(environment: RegisterJWTFeatureEnvironment) {
        self.environment = environment
    }

    func onTapRegister(
        from viewController: UIViewController,
        issuerID: String?,
        keyID: String?,
        privateKey: String?
    ) {
        guard let issuerID,
              !issuerID.isEmpty else {
            showAlertSubject.send(.invalidIssuerID)
            return
        }

        guard let keyID,
              !keyID.isEmpty else {
            showAlertSubject.send(.invalidKeyID)
            return
        }

        guard let privateKey,
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
            try KeychainStore.shared.deleteValue(forKey: .jwt)
            try KeychainStore.shared.saveValue(info, forKey: .jwt)
            showAlertSubject.send(.successedSavingJWTReuqestInfo)
            environment.router.close(from: viewController)
        } catch {
            showAlertSubject.send(.failedSavingJWTRequestInfo)
        }
    }

    func loadRegisteredInfo() {
        do {
            let savedElement: MutaroJWT.JWTRequestInfo = try KeychainStore.shared.loadValue(forKey: .jwt)
            showSavedInfoSubject.send(savedElement)
        } catch {
            // TODO: - error
        }
    }

    func didPickDocuments(urls: [URL]) {
        guard let url = urls.first,
              let data = try? Data(contentsOf: url) else {
            return
        }

        let privateKey = String(decoding: data, as: UTF8.self)
        didPickPrivateKeyFileSubject.send(privateKey)
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
}
