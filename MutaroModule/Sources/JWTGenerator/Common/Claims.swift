//
//  File.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import Foundation

public enum MutaroJWT {
    public struct AppstoreConnectClaims: Claims {
        let iss: String
        let exp: Date
        let aud: String

        init(
            iss: String,
            exp: Date = Date().addTimeInterval(20 * 60),
            aud: String = "appstoreconnect-v1"
        ) {
            self.iss = iss
            self.exp = exp
            self.aud = aud
        }
    }
}
