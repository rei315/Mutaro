//
//  AnimatedTransitioning.swift
//
//
//  Created by minguk-kim on 2023/01/12.
//

import UIKit

protocol AnimatedTransitioning: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
}
