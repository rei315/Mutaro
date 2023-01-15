//
//  MutaroInfoUploadViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/12.
//

import Combine
import Core
import Foundation
import PhotosUI
import Repositories

struct MutaroPhotoData {
    let url: URL
    let fileName: String
}

final public class MutaroInfoUploadViewModel: NSObject {
    typealias Routes = MutaroInfoUploadRoute & Closable
    private let router: Routes

    @Published var pickedPhotoData: MutaroPhotoData?
    let didFinishedPostMutaroInfo = PassthroughSubject<Void, Never>()

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
                itemProvider.hasItemConformingToTypeIdentifier(typeIdentifier)
            else {
                return
            }

            let photoURL = try await itemProvider.loadFileRepresentation(
                forTypeIdentifier: typeIdentifier
            )

            self.pickedPhotoData = .init(
                url: photoURL,
                fileName: "\(photoName).\(photoType)"
            )
        } catch {
            print("Mins: failed to select image")
        }
    }

    func onTapPost(title: String?, description: String?) async {
        guard let pickedPhotoData,
            let title,
            let description
        else {
            return
        }
        await MainActor.run {
            ProgressHUD.show()
        }

        do {
            let photoUrl =
                try await MutaroClient
                .MutaroPhotoResource
                .postMutaroPhoto(
                    fileUrl: pickedPhotoData.url,
                    fileName: pickedPhotoData.fileName
                )

            try await MutaroClient
                .MutaroDetailResource
                .postMutaros(
                    imageUrl: photoUrl,
                    title: title,
                    description: description
                )
            await MainActor.run {
                ProgressHUD.hide()
            }
            didFinishedPostMutaroInfo.send(())
        } catch {
            await MainActor.run {
                ProgressHUD.hide()
            }
            print("Mins: error - \(error)")
        }
    }

    func dismiss() {
        router.close()
    }
}
