//
//  AppIntroductionViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Core
import UIKit

final class AppIntroductionViewModel: NSObject {
    typealias Routes = AppIntroductRoute
    private let router: Routes

    init(router: Routes) {
        self.router = router
    }

    func onTapAgree() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKey.notFirstAppLaunching.rawValue)
    }
}
