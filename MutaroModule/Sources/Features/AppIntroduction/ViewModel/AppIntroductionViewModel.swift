//
//  AppIntroductionViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Core
import UIKit

@MainActor
public protocol AppIntroductDelegate: AnyObject {
    func onTapAgree()
}

@MainActor
public protocol AppIntroductRoute {
    func makeAppIntroduct(_ delegate: AppIntroductDelegate) -> UIViewController
}

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
