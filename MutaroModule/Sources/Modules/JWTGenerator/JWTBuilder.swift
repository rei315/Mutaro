//
//  JWTBuilder.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import Foundation
import SwiftJWT

public extension MutaroJWT {
    struct AppstoreConnectJWTBuilder {
        let keyId: String
        let issuerId: String
        let pemString: String

        public init(keyId: String, issuerId: String, pemString: String) {
            self.keyId = keyId
            self.issuerId = issuerId
            self.pemString = pemString
        }

        public func generateJWT() throws -> String {
            let privateKey = Data(pemString.utf8)
            let header = Header(kid: keyId)
            let claims = AppstoreConnectClaims(
                iss: issuerId,
                exp: Date(timeIntervalSinceNow: 20 * 60),
                aud: "appstoreconnect-v1"
            )
            var jwt = JWT(header: header, claims: claims)
            let signedJWT = try jwt.sign(using: .es256(privateKey: privateKey))

            return signedJWT
        }

        struct AppstoreConnectClaims: Claims {
            let iss: String
            let exp: Date
            let aud: String

            init(
                iss: String,
                exp: Date,
                aud: String
            ) {
                self.iss = iss
                self.exp = exp
                self.aud = aud
            }
        }
    }
}
