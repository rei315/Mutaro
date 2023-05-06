//
//  RegisterJWTFeatureEnvironment.swift
//
//
//  Created by minguk-kim on 2023/05/07.
//

import Foundation

public struct RegisterJWTFeatureEnvironment {
    public let router: RegisterJWTFeatureRoutable

    public init(router: RegisterJWTFeatureRoutable) {
        self.router = router
    }
}
