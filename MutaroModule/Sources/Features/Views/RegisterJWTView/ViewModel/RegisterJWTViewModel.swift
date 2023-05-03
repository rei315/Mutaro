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

public final class RegisterJWTViewModel {
    typealias Routes = RegisterJWTRoute & Closable
    private let router: Routes

    let showAlertSubject = PassthroughSubject<AlertState, Never>()
    let showSavedInfoSubject = PassthroughSubject<JWTRequestInfo, Never>()

    var cancellables: Set<AnyCancellable> = []

    init(router: Routes) {
        self.router = router
    }

    func onTapRegister(
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

        let info = JWTRequestInfo(
            issuerID: issuerID,
            keyID: keyID,
            privateKey: privateKey
        )
        KeychainStore.shared.delete(JWTRequestInfo.self)

        guard let isSuccessed = try? KeychainStore.shared.save(info, forKey: "b"),
              isSuccessed else {
            showAlertSubject.send(.failedSavingJWTRequestInfo)
            return
        }
        showAlertSubject.send(.successedSavingJWTReuqestInfo)
        router.close()
    }

    func loadRegisteredInfo() {
        guard let savedElement = try? KeychainStore.shared.get(JWTRequestInfo.self).first else {
            return
        }
        showSavedInfoSubject.send(savedElement)
    }
}

extension RegisterJWTViewModel {
    struct JWTRequestInfo: Codable {
        let issuerID: String
        let keyID: String
        let privateKey: String
    }

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
