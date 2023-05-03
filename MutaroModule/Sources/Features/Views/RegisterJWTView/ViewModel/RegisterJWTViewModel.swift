//
//  RegisterJWTViewModel.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import Combine
import Foundation
import JWTGenerator

public final class RegisterJWTViewModel {
    typealias Routes = RegisterJWTRoute
    private let router: Routes

    let showAlertSubject = PassthroughSubject<AlertState, Never>()
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

        guard let token = try? builder.generateJWT() else {
            showAlertSubject.send(.invalidToken)
            return
        }

        // TODO: - keyID, issuerID, privateKey
        print("Mins: \(token)")
    }
}

extension RegisterJWTViewModel {
    enum AlertState {
        case invalidIssuerID
        case invalidKeyID
        case invalidPrivateKey
        case invalidToken

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
            }

            return string
        }
    }
}
