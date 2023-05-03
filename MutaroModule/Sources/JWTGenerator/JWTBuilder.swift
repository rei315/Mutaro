//
//  JWTBuilder.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import SwiftJWT

public extension MutaroJWT {
    enum ClaimsState {
        case appstoreConnectV1

        func get(issuerId: String) -> Claims {
            switch self {
            case .appstoreConnectV1:
                return AppstoreConnectClaims(iss: issuerId)
            }
        }
    }

    struct AppstoreConnectJWTBuilder {
        let keyId: String
        let issuerId: String
        let pemString: String

        public init(keyId: String, issuerId: String, pemString: String) {
            self.keyId = keyId
            self.issuerId = issuerId
            self.pemString = pemString
        }

        public func generateJWT(_ claimsState: ClaimsState) throws -> String {
            guard let privateKey = pemString.data(using: .utf8) else {
                throw JWTError.pemStringIsWrongPattern
            }

            let header = Header(kid: keyId)
            let claims = claimsState.get(issuerId: issuerId)
            let jwt = SwiftJWT.JWT(header: header, claims: claims)
            let signedJWT = try jwt.sign(using: .rs256(privateKey: privateKey))

            return signedJWT
        }
    }
}
