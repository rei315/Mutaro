//
//  MyAppsRegisterJWTCell.swift
//
//
//  Created by minguk-kim on 2023/05/05.
//

import Core
import UIKit

final class MyAppsRegisterJWTCell: UICollectionViewCell {
    private let titleLabel: UILabel = .init()
    private let descriptionLabel: UILabel = .init()
    private let registerButton: UIButton = .init(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.lets {
            $0.addSubview(titleLabel)
            $0.addSubview(descriptionLabel)
            $0.addSubview(registerButton)
        }

        titleLabel.lets {
            $0.numberOfLines = 2
            $0.font = FontSize.base.ofBoldFont()
            $0.textColor = R.color.black() ?? .black
            $0.text = "JWTトークン生成するための情報を入力して\nXcodeCloud機能を使う！"
            $0.textAlignment = .center
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
                $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
            ])
        }

        descriptionLabel.lets {
            $0.numberOfLines = 2
            $0.font = FontSize.minus1.ofFont()
            $0.textColor = R.color.navy40() ?? .systemGray4
            $0.text = "AppstoreConnect API機能を使うにはJWTトークンを生成するための情報を入力する必要があります"
            $0.textAlignment = .center
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
            ])
        }

        registerButton.lets {
            $0.layer.cornerRadius = 4
            $0.backgroundColor = .blue.withAlphaComponent(0.2)
            $0.setTitle("情報を入力する", for: .normal)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
                $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
            ])
        }
    }

    func bind(_ action: @escaping () -> Void) {
        registerButton.updateAction(.touchUpInside, action: action)
    }
}
