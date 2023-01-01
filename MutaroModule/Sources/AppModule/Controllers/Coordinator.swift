//
//  File.swift
//
//
//  Created by minguk-kim on 2022/12/29.
//

import UIKit

@MainActor
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
