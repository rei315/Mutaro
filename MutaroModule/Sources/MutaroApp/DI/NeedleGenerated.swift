

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

private class HomeFeatureDependency8a76a83d24651fa35706Provider: HomeFeatureDependency {


    init() {

    }
}
/// ^->RootComponent->HomeFeatureBuilderComponent
private func factory3efbd8a11f8c0b786572e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return HomeFeatureDependency8a76a83d24651fa35706Provider()
}
private class MyAppToolsFeatureDependency808dcb776fac4cff0658Provider: MyAppToolsFeatureDependency {
    var client: Providable {
        return rootComponent.client
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->MyAppToolsFeatureComponent
private func factory8f024357306342a865feb3a8f24c1d289f2c0f2e(_ component: NeedleFoundation.Scope) -> AnyObject {
    return MyAppToolsFeatureDependency808dcb776fac4cff0658Provider(rootComponent: parent1(component) as! RootComponent)
}
private class RegisterJWTFeatureDependencyafcbabee5908dec1a2f7Provider: RegisterJWTFeatureDependency {


    init() {

    }
}
/// ^->RootComponent->RegisterJWTFeatureBuilderComponent
private func factorya0afd58e4976bcfb953ee3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return RegisterJWTFeatureDependencyafcbabee5908dec1a2f7Provider()
}
private class MyAppsFeatureDependencye7eedfbcc966a0098ee9Provider: MyAppsFeatureDependency {
    var client: Providable {
        return rootComponent.client
    }
    var imageDownloadService: ImageDownloadService {
        return rootComponent.imageDownloadService
    }
    var registerJWTFeatureBuilder: RegisterJWTFeatureBuildable {
        return rootComponent.registerJWTFeatureBuilder
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->MyAppsFeatureBuilderComponent
private func factorybea64e632592e689d959b3a8f24c1d289f2c0f2e(_ component: NeedleFoundation.Scope) -> AnyObject {
    return MyAppsFeatureDependencye7eedfbcc966a0098ee9Provider(rootComponent: parent1(component) as! RootComponent)
}
private class SettingFeatureDependencybb7d9caeeb950cbc5892Provider: SettingFeatureDependency {
    var registerJWTFeatureBuilder: RegisterJWTFeatureBuildable {
        return rootComponent.registerJWTFeatureBuilder
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->SettingFeatureBuilderComponent
private func factory78443b45858507b98a9db3a8f24c1d289f2c0f2e(_ component: NeedleFoundation.Scope) -> AnyObject {
    return SettingFeatureDependencybb7d9caeeb950cbc5892Provider(rootComponent: parent1(component) as! RootComponent)
}
private class AppIntroductionFeatureDependency28a2d19e67af53b93df4Provider: AppIntroductionFeatureDependency {
    var myAppsFeatureBuilder: MyAppsFeatureBuildable {
        return rootComponent.myAppsFeatureBuilder
    }
    var settingFeatureBuilder: SettingFeatureBuildable {
        return rootComponent.settingFeatureBuilder
    }
    var homeFeatureBuilder: HomeFeatureBuildable {
        return rootComponent.homeFeatureBuilder
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->AppIntroductionFeatureBuilderComponent
private func factory9fdb332e057827d6b3d2b3a8f24c1d289f2c0f2e(_ component: NeedleFoundation.Scope) -> AnyObject {
    return AppIntroductionFeatureDependency28a2d19e67af53b93df4Provider(rootComponent: parent1(component) as! RootComponent)
}

#else
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
extension RootComponent: Registration {
    public func registerItems() {


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
    registerProviderFactory("^->RootComponent->HomeFeatureBuilderComponent", factory3efbd8a11f8c0b786572e3b0c44298fc1c149afb)
    registerProviderFactory("^->RootComponent->MyAppToolsFeatureComponent", factory8f024357306342a865feb3a8f24c1d289f2c0f2e)
    registerProviderFactory("^->RootComponent->RegisterJWTFeatureBuilderComponent", factorya0afd58e4976bcfb953ee3b0c44298fc1c149afb)
    registerProviderFactory("^->RootComponent->MyAppsFeatureBuilderComponent", factorybea64e632592e689d959b3a8f24c1d289f2c0f2e)
    registerProviderFactory("^->RootComponent->SettingFeatureBuilderComponent", factory78443b45858507b98a9db3a8f24c1d289f2c0f2e)
    registerProviderFactory("^->RootComponent->AppIntroductionFeatureBuilderComponent", factory9fdb332e057827d6b3d2b3a8f24c1d289f2c0f2e)
    registerProviderFactory("^->RootComponent", factoryEmptyDependencyProvider)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
