//
//  MutaroListViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Combine
import CommonAppModule
import Foundation
import ImageModule
import UIKit

protocol MutaroListViewModelProtocol {

}

final class MutaroListViewModel: NSObject, MutaroListViewModelProtocol {
    @Published var mutaroItems: [Int] = []

    var cancellables: Set<AnyCancellable> = []
    private let networkStatusManager: NetworkStatusManagerProtocol

    init(networkStatusManager: NetworkStatusManagerProtocol = NetworkStatusManager()) {
        self.networkStatusManager = networkStatusManager
    }

    func fetchMutaroItems() {
        Task {
            // TODO: - MutaroResourceで処理する
            if await networkStatusManager.isOnline {
                
            } else {
                let indexes = ImageContentPathProvider.ContentFileType.allCases.indices.map { $0 }
                mutaroItems = indexes
            }
        }
    }

    func prefetchHorizontalSectionItem(row: Int) {
        Task {
            // TODO: - MutaroResourceで処理する
            if await networkStatusManager.isOnline {
                
            } else {
                guard let type = ImageContentPathProvider.ContentFileType(rawValue: row) else {
                    return
                }
                await UIImage.loadImage(with: type, size: .zero)
            }
        }
    }
}
