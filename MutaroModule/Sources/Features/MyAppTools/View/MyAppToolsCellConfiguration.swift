//
//  MyAppToolsCellConfiguration.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import UIKit

extension UICollectionViewCell {
    func myAppToolCellConfiguration() -> MyAppToolCellConfiguration {
        MyAppToolCellConfiguration()
    }
}

struct MyAppToolCellConfiguration: UIContentConfiguration, Hashable {
    var title: String?

    func makeContentView() -> UIView & UIContentView {
        MyAppToolCellView(configuration: self)
    }

    func updated(for _: UIConfigurationState) -> MyAppToolCellConfiguration {
        self
    }
}

final class MyAppToolCellView: UIView, UIContentView {
    private let titleLabel: UILabel = .init()

    var configuration: UIContentConfiguration {
        didSet {
            guard let configuration = configuration as? MyAppToolCellConfiguration else {
                return
            }
            bind(with: configuration)
        }
    }

    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .null)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        titleLabel.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)

            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
            ])
        }
    }

    private func bind(with configuration: MyAppToolCellConfiguration) {
        titleLabel.text = configuration.title
    }
}
