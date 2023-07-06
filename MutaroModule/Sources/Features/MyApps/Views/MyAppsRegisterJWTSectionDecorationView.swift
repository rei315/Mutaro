//
//  MyAppsRegisterJWTSectionDecorationView.swift
//
//
//  Created by minguk-kim on 2023/05/13.
//

import Core
import UIKit

final class MyAppsRegisterJWTSectionDecorationView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(resource: .navy10)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
