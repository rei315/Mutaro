//
//  RegisterJWTFeatureEnvironment.swift
//
//
//  Created by minguk-kim on 2023/05/07.
//

import Foundation

public struct RegisterJWTFeatureEnvironment: Sendable {
    public let router: any RegisterJWTFeatureRoutable

    public init(router: any RegisterJWTFeatureRoutable) {
        self.router = router
    }
}
