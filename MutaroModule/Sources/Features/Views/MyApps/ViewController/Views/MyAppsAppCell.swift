//
//  MyAppsAppCell.swift
//
//
//  Created by minguk-kim on 2023/05/05.
//

import UIKit

final class MyAppsAppCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {}
}
