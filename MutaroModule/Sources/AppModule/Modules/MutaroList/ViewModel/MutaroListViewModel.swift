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
import MutaroClientModule
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
            //            guard let type = ImageContentPathProvider.ContentFileType(rawValue: row) else {
            //                return
            //            }
            //            await UIImage.loadImage(with: type, size: .zero)
        }
    }
}
