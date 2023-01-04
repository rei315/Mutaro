//
//  MutaroListViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Combine
import Foundation
import ImageModule
import UIKit

protocol MutaroListViewModelProtocol {

}

final class MutaroListViewModel: NSObject, MutaroListViewModelProtocol {
    @Published var mutaroItems: [Int] = []

    var cancellables: Set<AnyCancellable> = []

    func fetchMutaroItems() {
        let indexes = ImageContentPathProvider.ContentFileType.allCases.indices.map { $0 }

        mutaroItems = indexes
    }

    func prefetchHorizontalSectionItem(row: Int) {
        Task {
            guard let type = ImageContentPathProvider.ContentFileType(rawValue: row) else {
                return
            }
            await UIImage.loadImage(with: type, size: .zero)
        }
    }
}
