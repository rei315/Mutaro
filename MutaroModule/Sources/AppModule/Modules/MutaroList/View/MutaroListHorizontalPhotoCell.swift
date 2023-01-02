//
//  MutaroListHorizontalPhotoCell.swift
//
//
//  Created by minguk-kim on 2023/01/02.
//

import Combine
import ImageModule
import UIKit

class MutaroListHorizontalPhotoCell: UICollectionViewCell {
    private let imageView: UIImageView = .init()

    private let rectSubject = CurrentValueSubject<CGSize?, Never>(nil)
    private let imageSubject = CurrentValueSubject<
        ImageContentPathProvider.ContentFileType?, Never
    >(nil)

    private var cancellables: Set<AnyCancellable> = []

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        imageView.clipToCircle()
        rectSubject.send(rect.size)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupSubscription()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubscription() {
        rectSubject
            .compactMap { $0 }
            .zip(imageSubject.compactMap { $0 })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (size, type) in
                self?.setupImage(size, type: type)
            }
            .store(in: &cancellables)
    }

    private func setupUI() {
        imageView.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.contentMode = .scaleAspectFill
            contentView.addSubview($0)
            $0.fillConstraint(to: contentView)
        }
    }

    func configureCell(imageType: ImageContentPathProvider.ContentFileType) {
        imageSubject.send(imageType)
    }

    private func setupImage(_ size: CGSize, type: ImageContentPathProvider.ContentFileType) {
        Task { @MainActor in
            await imageView.loadImage(with: type, size: size)
        }
    }
}
