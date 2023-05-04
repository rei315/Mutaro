//
//  MyAppsViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Combine
import Core
import Foundation
import UIKit

protocol MyAppsViewModelProtocol {}

public final class MyAppsViewModel: NSObject, MyAppsViewModelProtocol {
    typealias Routes = MyAppsRoute
    private let router: Routes

    var cancellables: Set<AnyCancellable> = []

    init(router: Routes) {
        self.router = router
    }
}
