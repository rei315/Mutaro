//
//  MutaroListHorizontalPhotoCell.swift
//
//
//  Created by minguk-kim on 2023/01/02.
//

import AppResource
import Combine
import ImageLoader
import UIKit

class MutaroListCirclePhotoCell: UICollectionViewCell {
    public static let imageSize: CGFloat = 70
    private let imageView: UIImageView = .init()
    private var savedTask: Task<(), Never>?

    private let iconSizeSubject = CurrentValueSubject<CGSize?, Never>(nil)
    private let configureValueSubject = CurrentValueSubject<String?, Never>(nil)
    private var cancellables: AnyCancellable?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupSubscription()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        iconSizeSubject.send(rect.size)
    }

    private func setupUI() {
        imageView.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = Resources.Colors.navy20.color
            $0.contentMode = .scaleAspectFill
            contentView.addSubview($0)
            $0.fillConstraint(to: contentView)
            $0.clipToCircle(with: MutaroListCirclePhotoCell.imageSize / 2)
        }
    }

    private func setupSubscription() {
        cancellables =
            configureValueSubject
            .combineLatest(iconSizeSubject)
            .sink { [weak self] in
                self?.setupIcon(value: $0, size: $1)
            }
    }

    func resetCell() {
        savedTask?.cancel()
        savedTask = nil
    }

    func configureCell(_ imageUrl: String) {
        configureValueSubject.send(imageUrl)
    }

    private func setupIcon(value imageUrl: String?, size: CGSize?) {
        guard let size,
            let imageUrl
        else {
            return
        }
        savedTask = Task {
            await imageView.loadImage(fileName: imageUrl, size: size)
        }
    }
}
