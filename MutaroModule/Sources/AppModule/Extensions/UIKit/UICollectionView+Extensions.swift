//
//  UICollectionView+Extensions.swift
//  
//
//  Created by minguk-kim on 2022/12/29.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(
        withType type: T.Type, for indexPath: IndexPath
    ) -> T {
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withReuseIdentifier: type.simpleClassName(), for: indexPath)
            as! T
    }

    func registerNib<T: UICollectionViewCell>(withType type: T.Type) {
        register(
            UINib(nibName: type.simpleClassName(), bundle: nil),
            forCellWithReuseIdentifier: type.simpleClassName())
    }

    func registerClass<T: UICollectionViewCell>(withType type: T.Type) {
        register(type.self, forCellWithReuseIdentifier: type.simpleClassName())
    }
}
