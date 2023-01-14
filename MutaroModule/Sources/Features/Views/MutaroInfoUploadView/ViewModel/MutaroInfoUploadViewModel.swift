//
//  MutaroInfoUploadViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/12.
//

import Foundation
import PhotosUI
import Combine

struct MutaroPhotoData {
    let image: UIImage
    let url: URL
    let fileName: String
}

import Repositories

final public class MutaroInfoUploadViewModel: NSObject {
    typealias Routes = MutaroInfoUploadRoute
    private let router: Routes

    @Published var pickedPhotoData: MutaroPhotoData?
    var cancellables: Set<AnyCancellable> = []
    
    init(router: Routes) {
        self.router = router
    }
    
    func didFinishedPickedPhoto(results: [PHPickerResult]) async {
        do {
            guard let itemProvider = results.first?.itemProvider,
                  let typeIdentifier = itemProvider.registeredTypeIdentifiers.first,
                  let photoType = typeIdentifier.components(separatedBy: ".").last,
                  let photoName = itemProvider.suggestedName,
                  itemProvider.hasItemConformingToTypeIdentifier(typeIdentifier) else {
                return
            }
            
            let photoURL = try await itemProvider.loadItem(forTypeIdentifier: typeIdentifier)
            let photoData = try Data(contentsOf: photoURL)
            guard let image = UIImage(data: photoData) else {
                return
            }

            self.pickedPhotoData = .init(
                image: image,
                url: photoURL,
                fileName: "\(photoName).\(photoType)"
            )
        } catch {
            print("Mins: failed to select image")
        }
    }
    
    func onTapPost() async {
        guard let pickedPhotoData else {
            return
        }
        do {
            let photoUrl = try await MutaroClient
                .MutaroPhotoResource
                .postMutaroPhoto(
                    fileUrl: pickedPhotoData.url,
                    fileName: pickedPhotoData.fileName
                )
            
            try await MutaroClient
                .MutaroDetailResource
                .postMutaros(
                    imageUrl: photoUrl,
                    title: "good",
                    description: "description"
                )
            
        } catch {
            print("Mins: error - \(error)")
        }
    }
}
