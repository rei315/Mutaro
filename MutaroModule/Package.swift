// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

extension PackageDescription.SwiftSetting {
    static let forwardTrailingClosures: Self = .enableUpcomingFeature("ForwardTrailingClosures")              // SE-0286, Swift 5.3,  SwiftPM 5.8+
    static let existentialAny: Self = .enableUpcomingFeature("ExistentialAny")                                // SE-0335, Swift 5.6,  SwiftPM 5.8+
    static let bareSlashRegexLiterals: Self = .enableUpcomingFeature("BareSlashRegexLiterals")                // SE-0354, Swift 5.7,  SwiftPM 5.8+
    static let conciseMagicFile: Self = .enableUpcomingFeature("ConciseMagicFile")                            // SE-0274, Swift 5.8,  SwiftPM 5.8+
    static let importObjcForwardDeclarations: Self = .enableUpcomingFeature("ImportObjcForwardDeclarations")  // SE-0384, Swift 5.9,  SwiftPM 5.9+
    static let disableOutwardActorInference: Self = .enableUpcomingFeature("DisableOutwardActorInference")    // SE-0401, Swift 5.9,  SwiftPM 5.9+
    static let deprecateApplicationMain: Self = .enableUpcomingFeature("DeprecateApplicationMain")            // SE-0383, Swift 5.10, SwiftPM 5.10+
    static let isolatedDefaultValues: Self = .enableUpcomingFeature("IsolatedDefaultValues")                  // SE-0411, Swift 5.10, SwiftPM 5.10+
    static let globalConcurrency: Self = .enableUpcomingFeature("GlobalConcurrency")                          // SE-0412, Swift 5.10, SwiftPM 5.10+
}

let firebaseCrashlyticsDependencies: [Target.Dependency] = [
    "FirebaseCoreExtension",
    "FirebaseCrashlytics",
    "FirebaseSessions",
    "GoogleDataTransport",
    "Promises"
]

let firebaseAnalyticsDependencies: [Target.Dependency] = [
    "FBLPromises",
    "FirebaseAnalytics",
    "FirebaseCore",
    "FirebaseCoreInternal",
    "FirebaseInstallations",
    "GoogleAppMeasurement",
    "GoogleAppMeasurementIdentitySupport",
    "GoogleUtilities",
    "nanopb"
]

let debugSwiftSettings: [PackageDescription.SwiftSetting] = [
    .define("DEV", .when(configuration: .debug)),
    .unsafeFlags(["-strict-concurrency=complete", "-warn-concurrency", "-enable-actor-data-race-checks"]),
    .forwardTrailingClosures,
    .existentialAny,
    .bareSlashRegexLiterals,
    .conciseMagicFile,
    .importObjcForwardDeclarations,
    .disableOutwardActorInference,
    .deprecateApplicationMain,
    .isolatedDefaultValues,
    .globalConcurrency
]

let productionFeatures: [PackageDescription.Target.Dependency] = [
    .appIntroductionFeature,
    .homeFeature,
    .myAppsFeature,
    .registerJWTFeature,
    .settingFeature,
    .myAppToolsFeature,
    
    .firebaseSetup,    
    .client,
]

// MARK: - UnitTest Dependencies

let unittestDependencies: [Target.Dependency] = [
    .product(name: "Quick", package: "Quick"),
    .product(name: "Nimble", package: "Nimble")
]

let snapshotDependencies: [Target.Dependency] = [
    .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
]

// MARK: - Dependencies

private extension PackageDescription.Target.Dependency {
    static let needle: Self = .product(name: "NeedleFoundation", package: "needle")
    
    static let kingfisher: Self = .product(name: "Kingfisher", package: "Kingfisher")
    static let swiftJWT: Self = .product(name: "SwiftJWT", package: "Swift-JWT")
}

// MARK: - Custom Modules

private extension PackageDescription.Target.Dependency {
    static let core: Self = .target(name: "Core")
    static let imageLoader: Self = .target(name: "ImageLoader")
    static let jwtGenerator: Self = .target(name: "JWTGenerator")
    static let keychainStore: Self = .target(name: "KeychainStore")
    static let firebaseSetup: Self = .target(name: "FirebaseSetup")
    static let client: Self = .target(name: "Client")
}

// MARK: - Feature

private extension PackageDescription.Target.Dependency {
    static let appIntroductionFeature: Self = .target(name: "AppIntroductionFeature")
    static let homeFeature: Self = .target(name: "HomeFeature")
    static let myAppsFeature: Self = .target(name: "MyAppsFeature")
    static let registerJWTFeature: Self = .target(name: "RegisterJWTFeature")
    static let settingFeature: Self = .target(name: "SettingFeature")
    static let myAppToolsFeature: Self = .target(name: "MyAppToolsFeature")
}

private extension PackageDescription.Target.PluginUsage {
    static let lintPlugin: Self = .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
}

private let developmentPlugins: [PackageDescription.Target.PluginUsage]
if ProcessInfo.processInfo.environment["CI"] == "TRUE" {
    developmentPlugins = []
} else {
    developmentPlugins = [.lintPlugin]
}

let package = Package(
    name: "MutaroModule",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "Development", targets: ["Development"]),
        .library(name: "Production", targets: ["Production"]),
        
        .library(name: "AppIntroductionFeature", targets: ["AppIntroductionFeature"]),
        .library(name: "HomeFeature", targets: ["HomeFeature"]),
        .library(name: "MyAppsFeature", targets: ["MyAppsFeature"]),
        .library(name: "RegisterJWTFeature", targets: ["RegisterJWTFeature"]),
        .library(name: "SettingFeature", targets: ["SettingFeature"]),
        .library(name: "MyAppToolsFeature", targets: ["MyAppToolsFeature"])
    ],
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint", from: "0.54.0"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.53.2"),
        .package(url: "https://github.com/Kitura/Swift-JWT", from: "4.0.1"),
        .package(url: "https://github.com/Quick/Quick", from: "7.4.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "12.3.0"),
        .package(url: "https://github.com/onevcat/Kingfisher", from: "7.11.0"),
        .package(url: "https://github.com/uber/needle.git", from: "0.24.0"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", exact: "1.15.3")
    ],
    targets: [
        .target(
            name: "Development",
            dependencies: productionFeatures,
            path: "./Sources/App/Development",
            plugins: developmentPlugins
        ),
        .testTarget(
            name: "AppSnapshotTests",
            dependencies: ["Development"] + snapshotDependencies,
            path: "./Tests/App/AppSnapshotTests",
            resources: [
                .process("__Snapshots__")
            ]
        ),
        .target(
            name: "Production",
            dependencies: productionFeatures,
            path: "./Sources/App/Production"
        ),
        .target(
            name: "AppIntroductionFeature",
            dependencies: [
                .core
            ],
            path: "./Sources/Features/AppIntroduction",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "HomeFeature",
            dependencies: [
                .core
            ],
            path: "./Sources/Features/Home",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "MyAppsFeature",
            dependencies: [
                .core,
                .imageLoader,
                .jwtGenerator,
                .keychainStore,
                .client
            ],
            path: "./Sources/Features/MyApps",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "MyAppToolsFeature",
            dependencies: [
                .core,
                .jwtGenerator,
                .keychainStore,
                .client
            ],
            path: "./Sources/Features/MyAppTools",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "RegisterJWTFeature",
            dependencies: [
                .jwtGenerator,
                .keychainStore,
                .core
            ],
            path: "./Sources/Features/RegisterJWT",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "SettingFeature",
            dependencies: [
                .core
            ],
            path: "./Sources/Features/Setting",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "Core",
            dependencies: [
                .needle,
                .kingfisher
            ]
        ),
        .target(
            name: "Client",
            dependencies: [
                .core
            ]
        ),
        .target(
            name: "JWTGenerator",
            dependencies: [
                .swiftJWT
            ],
            path: "./Sources/Modules/JWTGenerator"
        ),
        .testTarget(
            name: "JWTGeneratorTests",
            dependencies: [
                .jwtGenerator
            ] + unittestDependencies
        ),
        .target(
            name: "KeychainStore",
            dependencies: [
                .core
            ],
            path: "./Sources/Modules/KeychainStore"
        ),
        .target(
            name: "FirebaseSetup",
            dependencies: firebaseCrashlyticsDependencies + firebaseAnalyticsDependencies,
            path: "./Sources/Modules/FirebaseSetup",
            linkerSettings: [
                .unsafeFlags(["-ObjC"])
            ]
        ),
        .target(
            name: "ImageLoader",
            dependencies: [
                .kingfisher,
                .core
            ],
            path: "./Sources/Modules/ImageLoader"
        ),
        .binaryTarget(
            name: "FirebaseCoreExtension",
            path: "XCFrameworks/Firebase/FirebaseCrashlytics/FirebaseCoreExtension.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseCrashlytics",
            path: "XCFrameworks/Firebase/FirebaseCrashlytics/FirebaseCrashlytics.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseSessions",
            path: "XCFrameworks/Firebase/FirebaseCrashlytics/FirebaseSessions.xcframework"
        ),
        .binaryTarget(
            name: "GoogleDataTransport",
            path: "XCFrameworks/Firebase/FirebaseCrashlytics/GoogleDataTransport.xcframework"
        ),
        .binaryTarget(
            name: "Promises",
            path: "XCFrameworks/Firebase/FirebaseCrashlytics/Promises.xcframework"
        ),
        .binaryTarget(
            name: "FBLPromises",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/FBLPromises.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseAnalytics",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/FirebaseAnalytics.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseCore",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/FirebaseCore.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseCoreInternal",
            path:
                "XCFrameworks/Firebase/FirebaseAnalytics/FirebaseCoreInternal.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseInstallations",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/FirebaseInstallations.xcframework"
        ),
        .binaryTarget(
            name: "GoogleAppMeasurement",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/GoogleAppMeasurement.xcframework"
        ),
        .binaryTarget(
            name: "GoogleAppMeasurementIdentitySupport",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/GoogleAppMeasurementIdentitySupport.xcframework"
        ),
        .binaryTarget(
            name: "GoogleUtilities",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/GoogleUtilities.xcframework"
        ),
        .binaryTarget(
            name: "nanopb",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/nanopb.xcframework"
        )
    ]
)
