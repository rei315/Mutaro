//
//  UITableView+Extensions.swift
//
//
//  Created by minguk-kim on 2022/12/29.
//

import Foundation
import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(withType type: T.Type, for indexPath: IndexPath)
        -> T {
        dequeueReusableCell(withIdentifier: type.simpleClassName(), for: indexPath) as! T
    }

    func reloadData(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.0, animations: { self.reloadData() }) { _ in completion() }
    }

    func registerNib(withType type: (some UITableViewCell).Type) {
        register(
            UINib(nibName: type.simpleClassName(), bundle: nil),
            forCellReuseIdentifier: type.simpleClassName()
        )
    }
}
