//
//  MutaroListViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Combine
import Core
import Foundation
import ImageLoader
import Repositories
import UIKit

protocol MutaroListViewModelProtocol {
    func fetchMutaroItems() async
}

public final class MutaroListViewModel: NSObject, MutaroListViewModelProtocol {
    typealias Routes = MutaroListRoute
    private let router: Routes
    @Published var mutaroItems: [MutaroModel] = []

    var cancellables: Set<AnyCancellable> = []

    init(router: Routes) {
        self.router = router
    }

    func fetchMutaroItems() async {
        do {
            let mutaroDTOs = try await MutaroClient.MutaroDetailResource.getMutaros()
            let mutaroModels = mutaroDTOs.map { MutaroModel(dto: $0) }
            mutaroItems = mutaroModels
        } catch {
            mutaroItems = []
        }
    }

    func prefetchHorizontalSectionItem(row: Int) {
        Task {
            guard let imageUrl = mutaroItems[getOrNil: row]?.imageUrl else {
                return
            }
            await ImageLoadManager.shared.prefetchImage(for: imageUrl)
        }
    }

    func cancelPrefetchHorizontalSectionItem(row: Int) {
        Task {
            guard let imageUrl = mutaroItems[getOrNil: row]?.imageUrl else {
                return
            }
            await ImageLoadManager.shared.cancelPrefetch(key: imageUrl)
        }
    }
}
