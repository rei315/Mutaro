

import AppIntroductionFeature
import Client
import Core
import Foundation
import HomeFeature
import ImageLoader
import MyAppToolsFeature
import MyAppsFeature
import NeedleFoundation
import RegisterJWTFeature
import SettingFeature
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class HomeFeatureDependency7d2b3cafa1a26787323bProvider: HomeFeatureDependency {


    init() {

    }
}
/// ^->DevRootComponent->HomeFeatureBuilderComponent
private func factory61c9a65d91c54126627be3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return HomeFeatureDependency7d2b3cafa1a26787323bProvider()
}
private class MyAppToolsFeatureDependency8819cdcb20ff8ed502dcProvider: MyAppToolsFeatureDependency {
    var client: Providable {
        return devRootComponent.client
    }
    private let devRootComponent: DevRootComponent
    init(devRootComponent: DevRootComponent) {
        self.devRootComponent = devRootComponent
    }
}
/// ^->DevRootComponent->MyAppToolsFeatureComponent
private func factory1cd9013174eed344cbd4295202051d8ff8d8a13a(_ component: NeedleFoundation.Scope) -> AnyObject {
    return MyAppToolsFeatureDependency8819cdcb20ff8ed502dcProvider(devRootComponent: parent1(component) as! DevRootComponent)
}
private class RegisterJWTFeatureDependencyb8fd3e5e6507e3cea0d9Provider: RegisterJWTFeatureDependency {


    init() {

    }
}
/// ^->DevRootComponent->RegisterJWTFeatureBuilderComponent
private func factory3027719ba7197de4dae7e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return RegisterJWTFeatureDependencyb8fd3e5e6507e3cea0d9Provider()
}
private class MyAppsFeatureDependency6e3d99de62d490ee639fProvider: MyAppsFeatureDependency {
    var client: Providable {
        return devRootComponent.client
    }
    var imageDownloadService: ImageDownloadService {
        return devRootComponent.imageDownloadService
    }
    var registerJWTFeatureBuilder: RegisterJWTFeatureBuildable {
        return devRootComponent.registerJWTFeatureBuilder
    }
    var myAppToolsFeatureBuilder: MyAppToolsFeatureBuildable {
        return devRootComponent.myAppToolsFeatureBuilder
    }
    private let devRootComponent: DevRootComponent
    init(devRootComponent: DevRootComponent) {
        self.devRootComponent = devRootComponent
    }
}
/// ^->DevRootComponent->MyAppsFeatureBuilderComponent
private func factory7c6a8079ee013eb6ac6c295202051d8ff8d8a13a(_ component: NeedleFoundation.Scope) -> AnyObject {
    return MyAppsFeatureDependency6e3d99de62d490ee639fProvider(devRootComponent: parent1(component) as! DevRootComponent)
}
private class SettingFeatureDependencya3733705422ddb073e76Provider: SettingFeatureDependency {
    var registerJWTFeatureBuilder: RegisterJWTFeatureBuildable {
        return devRootComponent.registerJWTFeatureBuilder
    }
    private let devRootComponent: DevRootComponent
    init(devRootComponent: DevRootComponent) {
        self.devRootComponent = devRootComponent
    }
}
/// ^->DevRootComponent->SettingFeatureBuilderComponent
private func factory5d4e408a43798995182c295202051d8ff8d8a13a(_ component: NeedleFoundation.Scope) -> AnyObject {
    return SettingFeatureDependencya3733705422ddb073e76Provider(devRootComponent: parent1(component) as! DevRootComponent)
}
private class AppIntroductionFeatureDependencyec2688ffe4048af7f26dProvider: AppIntroductionFeatureDependency {
    var myAppsFeatureBuilder: MyAppsFeatureBuildable {
        return devRootComponent.myAppsFeatureBuilder
    }
    var settingFeatureBuilder: SettingFeatureBuildable {
        return devRootComponent.settingFeatureBuilder
    }
    var homeFeatureBuilder: HomeFeatureBuildable {
        return devRootComponent.homeFeatureBuilder
    }
    private let devRootComponent: DevRootComponent
    init(devRootComponent: DevRootComponent) {
        self.devRootComponent = devRootComponent
    }
}
/// ^->DevRootComponent->AppIntroductionFeatureBuilderComponent
private func factorya635079052b624173c15295202051d8ff8d8a13a(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AppIntroductionFeatureDependencyec2688ffe4048af7f26dProvider(devRootComponent: parent1(component) as! DevRootComponent)
}

#else
extension DevRootComponent: Registration {
    public func registerItems() {


    }
}
extension HomeFeatureBuilderComponent: Registration {
    public func registerItems() {

    }
}
extension MyAppToolsFeatureComponent: Registration {
    public func registerItems() {
        keyPathToName[\MyAppToolsFeatureDependency.client] = "client-Providable"
    }
}
extension RegisterJWTFeatureBuilderComponent: Registration {
    public func registerItems() {

    }
}
extension MyAppsFeatureBuilderComponent: Registration {
    public func registerItems() {
        keyPathToName[\MyAppsFeatureDependency.client] = "client-Providable"
        keyPathToName[\MyAppsFeatureDependency.imageDownloadService] = "imageDownloadService-ImageDownloadService"
        keyPathToName[\MyAppsFeatureDependency.registerJWTFeatureBuilder] = "registerJWTFeatureBuilder-RegisterJWTFeatureBuildable"
        keyPathToName[\MyAppsFeatureDependency.myAppToolsFeatureBuilder] = "myAppToolsFeatureBuilder-MyAppToolsFeatureBuildable"
    }
}
extension SettingFeatureBuilderComponent: Registration {
    public func registerItems() {
        keyPathToName[\SettingFeatureDependency.registerJWTFeatureBuilder] = "registerJWTFeatureBuilder-RegisterJWTFeatureBuildable"
    }
}
extension AppIntroductionFeatureBuilderComponent: Registration {
    public func registerItems() {
        keyPathToName[\AppIntroductionFeatureDependency.myAppsFeatureBuilder] = "myAppsFeatureBuilder-MyAppsFeatureBuildable"
        keyPathToName[\AppIntroductionFeatureDependency.settingFeatureBuilder] = "settingFeatureBuilder-SettingFeatureBuildable"
        keyPathToName[\AppIntroductionFeatureDependency.homeFeatureBuilder] = "homeFeatureBuilder-HomeFeatureBuildable"
    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

@inline(never) private func register1() {
    registerProviderFactory("^->DevRootComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->DevRootComponent->HomeFeatureBuilderComponent", factory61c9a65d91c54126627be3b0c44298fc1c149afb)
    registerProviderFactory("^->DevRootComponent->MyAppToolsFeatureComponent", factory1cd9013174eed344cbd4295202051d8ff8d8a13a)
    registerProviderFactory("^->DevRootComponent->RegisterJWTFeatureBuilderComponent", factory3027719ba7197de4dae7e3b0c44298fc1c149afb)
    registerProviderFactory("^->DevRootComponent->MyAppsFeatureBuilderComponent", factory7c6a8079ee013eb6ac6c295202051d8ff8d8a13a)
    registerProviderFactory("^->DevRootComponent->SettingFeatureBuilderComponent", factory5d4e408a43798995182c295202051d8ff8d8a13a)
    registerProviderFactory("^->DevRootComponent->AppIntroductionFeatureBuilderComponent", factorya635079052b624173c15295202051d8ff8d8a13a)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}