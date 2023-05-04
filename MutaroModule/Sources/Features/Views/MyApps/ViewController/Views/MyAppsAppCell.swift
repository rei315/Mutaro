//
//  MyAppsAppCell.swift
//
//
//  Created by minguk-kim on 2023/05/05.
//

import UIKit

final class MyAppsAppCell: UICollectionViewCell {
    private let thumbnailImageView: UIImageView = .init()

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
        thumbnailImageView.lets {
            contentView.addSubview($0)
            $0.fillConstraint(to: contentView)
        }
    }

    func bind(url _: String) {}
}
