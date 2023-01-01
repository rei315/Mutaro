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
    let mutaroItems = CurrentValueSubject<[String], Never>([])

    var cancellables: Set<AnyCancellable> = []

    func fetchMutaroItems() {
        mutaroItems.send(["mu", "mutaro", "mumu", "mu?", "nyaong"])
    }
}
