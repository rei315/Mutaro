//
//  UICollectionView+Extensions.swift
//
//
//  Created by minguk-kim on 2022/12/29.
//

import UIKit

extension UICollectionView {
    public func dequeueReusableCell<T: UICollectionViewCell>(
        withType type: T.Type, for indexPath: IndexPath
    ) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.simpleClassName(), for: indexPath)
            as! T
    }

    public func registerNib<T: UICollectionViewCell>(withType type: T.Type) {
        register(
            UINib(nibName: type.simpleClassName(), bundle: nil),
            forCellWithReuseIdentifier: type.simpleClassName())
    }

    public func registerClass<T: UICollectionViewCell>(withType type: T.Type) {
        register(type.self, forCellWithReuseIdentifier: type.simpleClassName())
    }
}
