//
//  MyAppsAppCell.swift
//
//
//  Created by minguk-kim on 2023/05/05.
//

import AppResource
import ImageLoader
import UIKit

final class MyAppsAppCell: UICollectionViewCell {
    private let stackView: UIStackView = .init()
    private let thumbnailImageView: UIImageView = .init()
    private let titleLabel: UILabel = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        contentView.lets {
            $0.layer.cornerRadius = rect.width / 2
        }
    }

    private func setupView() {
        contentView.lets {
            $0.clipsToBounds = true
        }

        stackView.lets {
            $0.axis = .vertical
            $0.addArrangedSubview(thumbnailImageView)
            $0.addArrangedSubview(titleLabel)
            contentView.addSubview(stackView)
            $0.fillConstraint(to: contentView)
        }

        thumbnailImageView.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.widthAnchor.constraint(equalTo: $0.heightAnchor, multiplier: 1.0)
            ])
        }

        titleLabel.lets {
            $0.font = FontSize.minus1.ofFont()
            $0.textColor = Resources.Colors.navy70.color
            $0.textAlignment = .center
        }
    }

    func bind(url: String?, title: String) {
        titleLabel.text = title

        thumbnailImageView.rt_cancelImageLoad()

        guard let url else {
            thumbnailImageView.backgroundColor = .darkGray
            return
        }
        thumbnailImageView.backgroundColor = .clear
        thumbnailImageView.rt_setImage(
            withURL: .init(string: url),
            targetCache: ImageCacheType.myAppCache.getCache()
        )
    }
}
