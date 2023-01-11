//
//  SettingViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import UIKit
import Combine

final class SettingViewModel: NSObject {
    typealias Routes = SettingRoute & MutaroInfoUploadRoute
    private let router: Routes
    
    @Published private(set) var shouldAddDeveloperSettingSubject = PassthroughSubject<Void, Never>()
    
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
