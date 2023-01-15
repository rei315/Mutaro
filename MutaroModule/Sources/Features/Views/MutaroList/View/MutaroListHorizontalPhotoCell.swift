//
//  MutaroListHorizontalPhotoCell.swift
//
//
//  Created by minguk-kim on 2023/01/02.
//

import AppResource
import ImageLoader
import UIKit

class MutaroListHorizontalPhotoCell: UICollectionViewCell {
    public static let imageSize: CGFloat = 100

    private let imageView: UIImageView = .init()

    private var savedTask: Task<(), Never>?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        imageView.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = Resources.Colors.navy20.color
            $0.contentMode = .scaleAspectFill
            contentView.addSubview($0)
            $0.fillConstraint(to: contentView)
            $0.clipToCircle(with: MutaroListHorizontalPhotoCell.imageSize / 2)
        }
    }

    func resetCell() {
        imageView.image = nil
    }

    func configureCell(_ imageUrl: String) {
        savedTask = Task {
            let size: CGSize = .init(
                width: MutaroListHorizontalPhotoCell.imageSize,
                height: MutaroListHorizontalPhotoCell.imageSize
            )

            await imageView.loadImage(fileName: imageUrl, size: size)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        savedTask?.cancel()
        savedTask = nil
    }
}
