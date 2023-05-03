//
//  MutaroListViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Combine
import Core
import Foundation
import UIKit

protocol MutaroListViewModelProtocol {}

public final class MutaroListViewModel: NSObject, MutaroListViewModelProtocol {
    typealias Routes = MutaroListRoute
    private let router: Routes

    var cancellables: Set<AnyCancellable> = []

    init(router: Routes) {
        self.router = router
    }
}
