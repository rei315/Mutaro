//
//  MyAppsRegisterJWTSectionDecorationView.swift
//  
//
//  Created by minguk-kim on 2023/05/13.
//

import UIKit
import Core

final class MyAppsRegisterJWTSectionDecorationView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = R.color.navy10() ?? .systemGray4
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
