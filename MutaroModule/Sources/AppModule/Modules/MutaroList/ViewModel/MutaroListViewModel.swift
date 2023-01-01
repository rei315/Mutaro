//
//  MutaroListViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Combine
import Foundation

protocol MutaroListViewModelProtocol {

}

final class MutaroListViewModel: NSObject, MutaroListViewModelProtocol {
    @Published var mutaroItems: [String] = []

    var cancellables: Set<AnyCancellable> = []

    func fetchMutaroItems() {
        mutaroItems = ["mu", "mutaro", "mumu", "mu?", "nyaong"]
    }
}
