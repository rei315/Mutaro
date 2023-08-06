//
//  SwiftUI+Extensions.swift
//
//
//  Created by minguk-kim on 2023/08/06.
//

import SwiftUI

extension SwiftUI.AnyView {
    func toViewController() -> UIViewController {
        let hostingController = UIHostingController(rootView: self)
        hostingController.view.frame = UIScreen.main.bounds
        return hostingController
    }
}

extension SwiftUI.View {
    func toViewController() -> UIViewController {
        let hostingController = UIHostingController(rootView: self)
        hostingController.view.frame = UIScreen.main.bounds
        return hostingController
    }
}
