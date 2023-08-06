//
//  SettingFeaturePreview.swift
//
//
//  Created by minguk-kim on 2023/08/06.
//

import Core
import SettingFeature
import SwiftUI

final class SettingFeaturePreview: PreviewProvider {
    struct Wrapper: UIViewControllerRepresentable {
        func makeUIViewController(context _: Context) -> some UIViewController {
            let vc = SettingViewController(
                dependency: .init(
                    viewModel: .init(
                        environment: .init(router: SettingRouterSpy())
                    )
                )
            )
            return vc
        }

        func updateUIViewController(_: UIViewControllerType, context _: Context) {}
    }

    static var previews: some View {
        Group {
            Wrapper()
        }
    }

    #if DEBUG
        @objc class func injected() {
            KeyWindowProvider().getKeyWindow()?.rootViewController = UIHostingController(
                rootView: Wrapper()
            )
        }
    #endif
}
