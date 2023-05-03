//
//  SettingDefaultCollectionViewCell.swift
//
//
//  Created by minguk-kim on 2023/01/10.
//

import AppResource
import Core
import UIKit

class SettingDefaultCollectionViewCell: UICollectionViewCell {
    private let iconView: UIImageView = .init()
    private let labelView: UILabel = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        contentView.backgroundColor = .blue.withAlphaComponent(0.2)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let iconSize: CGFloat = 36

        iconView.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.contentMode = .scaleAspectFit
            $0.clipToCircle(with: iconSize / 2)
            contentView.addSubview($0)
        }
        labelView.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = FontSize.plus1.ofFont()
            $0.textColor = Resources.Colors.navy.color
            contentView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: iconSize),
            iconView.heightAnchor.constraint(equalToConstant: iconSize),

            labelView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            labelView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func bind(type: SettingViewController.SettingType) {
        labelView.text = type.title
        iconView.image = type.icon
    }
}
