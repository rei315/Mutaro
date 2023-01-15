//
//  LoadingViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/15.
//

import Combine
import Foundation

class LoadingViewModel: NSObject {
    typealias Routes = LoadingRoute & Dismissable
    private let router: Routes

    var cancellables: Set<AnyCancellable> = []

    init(router: Routes, shouldCloseLoadingSubject: PassthroughSubject<Void, Never>) {
        self.router = router
        super.init()

        shouldCloseLoadingSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.dismiss()
            }
            .store(in: &cancellables)
    }

    func dismiss() {
        router.dismiss()
    }
}
