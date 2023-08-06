//
//  MutaroSpyApp.swift
//
//
//  Created by minguk-kim on 2023/08/06.
//

import Core
import FirebaseSetup
import NeedleFoundation
import UIKit

final class MutaroSpyApp {
    public static let shared = MutaroSpyApp()
    
    public var rootComponent: RootComponentSpy!
    
    public func setup() {
        registerProviderFactories()
        rootComponent = RootComponentSpy()
        FirebaseSetup.configure()
    }
}
