//
//  File.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import AppIntroductionFeature
import Core
import HomeViewFeature
import NeedleFoundation
import SettingFeature

final class RootComponent: BootstrapComponent {
    var appIntroduction: AppIntroductionFeatureBuilderComponent {
        .init(parent: self)
    }
    
    var setting: SettingFeatureBuilderComponent {
        .init(parent: self)
    }
    
    var home: HomeFeatureBuilderComponent {
        .init(parent: self)
    }
    
    var myApps: MyAppsFeatureBuilderComponent {
        .init(parent: self)
    }
    
    var registerJWT: RegisterJWTFeatureBuilderComponent {
        .init(parent: self)
    }
    
    var appIntroductionBuilder: AppIntroductionFeatureBuildable {
        appIntroduction.appIntroductionBuilder()
    }
    
    var settingBuilder: SettingFeatureBuildable {
        setting.settingFeatureBuilder()
    }
    
    var homeBuilder: HomeViewFeatureBuildable {
        home.homeViewFeatureBuilder()
    }
    
    var myAppsBuilder: MyAppsFeatureBuildable {
        myApps.myAppsFeatureBuilder()
    }
    
    var registerJWTBuilder: RegisterJWTFeatureBuildable {
        registerJWT.registerJWTFeatureBuilder()
    }
}
