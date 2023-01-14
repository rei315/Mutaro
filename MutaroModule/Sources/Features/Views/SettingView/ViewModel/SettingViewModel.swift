//
//  SettingViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Combine
import UIKit

final class SettingViewModel: NSObject {
    typealias Routes = SettingRoute & MutaroInfoUploadRoute
    private let router: Routes

    let shouldAddDeveloperSettingSubject = PassthroughSubject<Void, Never>()

    var cancellables: Set<AnyCancellable> = []

    init(router: Routes) {
        self.router = router
        super.init()
    }

    func setupDeveloperSettings() {
        shouldAddDeveloperSettingSubject.send(())
    }

    func onTapDevToolUploadMutaroInfo() {
        router.openMutaroInfoUpload()
    }
}
