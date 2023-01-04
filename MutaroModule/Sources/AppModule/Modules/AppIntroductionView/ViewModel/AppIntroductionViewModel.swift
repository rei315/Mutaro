//
//  AppIntroductionViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import CommonAppModule
import UIKit

final class AppIntroductionViewModel: NSObject {
    func onTapAgree() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKey.notFirstAppLaunching.rawValue)
    }
}
