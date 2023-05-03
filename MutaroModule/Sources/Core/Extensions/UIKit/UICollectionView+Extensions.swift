//
//  UICollectionView+Extensions.swift
//
//
//  Created by minguk-kim on 2022/12/29.
//

import UIKit

public extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(
        withType type: T.Type, for indexPath: IndexPath
    ) -> T {
        dequeueReusableCell(withReuseIdentifier: type.simpleClassName(), for: indexPath)
            as! T
    }

    func registerNib(withType type: (some UICollectionViewCell).Type) {
        register(
            UINib(nibName: type.simpleClassName(), bundle: nil),
            forCellWithReuseIdentifier: type.simpleClassName()
        )
    }

    func registerClass(withType type: (some UICollectionViewCell).Type) {
        register(type.self, forCellWithReuseIdentifier: type.simpleClassName())
    }
}
