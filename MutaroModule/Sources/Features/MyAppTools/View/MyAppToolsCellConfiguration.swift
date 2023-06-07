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
    func makeContentView() -> UIView & UIContentView {
        MyAppToolCellView(configuration: self)
    }

    func updated(for _: UIConfigurationState) -> MyAppToolCellConfiguration {
        self
    }
}

final class MyAppToolCellView: UIView, UIContentView {
    var configuration: UIContentConfiguration

    init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .null)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {}
}
