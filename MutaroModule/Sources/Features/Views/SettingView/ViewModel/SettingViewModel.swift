//
//  SettingViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import UIKit
import Combine

final class SettingViewModel: NSObject {
    @Published private(set) var shouldAddDeveloperSettingSubject = PassthroughSubject<Void, Never>()
    
    var cancellables: Set<AnyCancellable> = []
    
    func setupDeveloperSettings() {
        shouldAddDeveloperSettingSubject.send(())
    }
}
