//
//  RegisterJWTViewModel.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import Foundation
import JWTGenerator

public final class RegisterJWTViewModel {
    typealias Routes = RegisterJWTRoute
    private let router: Routes

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
            // TODO: - Alert for issuerID
            return
        }

        guard let keyID,
              !keyID.isEmpty else {
            // TODO: - Alert for keyID
            return
        }

        guard let privateKey,
              !privateKey.isEmpty else {
            // TODO: - Alert for privateKey
            return
        }

        let builder = MutaroJWT.AppstoreConnectJWTBuilder(
            keyId: keyID,
            issuerId: issuerID,
            pemString: privateKey
        )

        guard let token = try? builder.generateJWT() else {
            // TODO: - Alert for failed to generate jwt
            return
        }

        // TODO: - keyID, issuerID, privateKey
        print("Mins: \(token)")
    }
}
