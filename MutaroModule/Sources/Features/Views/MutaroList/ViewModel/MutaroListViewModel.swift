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
    @Published var mutaroItems: [MutaroModel] = []

    var cancellables: Set<AnyCancellable> = []

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
            let imageUrl = mutaroItems[row].imageUrl
            await UIImage.loadImage(urlString: imageUrl, size: .zero)
        }
    }
}
