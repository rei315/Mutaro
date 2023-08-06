//
//  SettingFeaturePreview.swift
//  
//
//  Created by minguk-kim on 2023/08/06.
//

import SwiftUI
import SettingFeature
import Core

final class SettingFeaturePreview: PreviewProvider {
    struct Wrapper: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            let vc = MutaroSpyApp.shared.rootComponent.settingFeatureBuilder.build()
            return vc
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
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
