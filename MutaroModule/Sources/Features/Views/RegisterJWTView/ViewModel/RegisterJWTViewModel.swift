//
//  RegisterJWTViewModel.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import Foundation

public final class RegisterJWTViewModel {
    typealias Routes = RegisterJWTRoute
    private let router: Routes

    init(router: Routes) {
        self.router = router
    }
}
