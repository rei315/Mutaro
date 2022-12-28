// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let firebaseCrashlyticsDependencies: [Target.Dependency] = [
    "GoogleDataTransport",
    "FirebaseCrashlytics",
]

let firebaseAnalyticsDependencies: [Target.Dependency] = [
    "FBLPromises",
    "FirebaseAnalytics",
    "FirebaseAnalyticsSwift",
    "FirebaseCore",
    "FirebaseCoreInternal",
    "FirebaseInstallations",
    "GoogleAppMeasurement",
    "GoogleAppMeasurementIdentitySupport",
    "GoogleUtilities",
    "nanopb",
]

let rxSwiftDependencies: [Target.Dependency] = [
    "RxBlocking",
    "RxCocoa",
    "RxRelay",
    "RxSwift",
]

let package = Package(
    name: "MutaroModule",
    platforms: [
        .iOS(.v15),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "AppModule",
            targets: ["AppModule"]),
        .library(
            name: "BuildModule",
            targets: ["BuildModule"]),
        .library(
            name: "FirebaseSetupModule",
            targets: ["FirebaseSetupModule"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-format", branch: "main")
    ],
    targets: [
        .target(
            name: "AppModule",
            dependencies: rxSwiftDependencies
        ),
        .target(
            name: "BuildModule",
            dependencies: ["swift-format"]
        ),
        .target(
            name: "FirebaseSetupModule",
            dependencies: firebaseCrashlyticsDependencies + firebaseAnalyticsDependencies,
            linkerSettings: [
                .unsafeFlags(["-ObjC"]),
            ]
        ),
        .binaryTarget(
            name: "FirebaseCrashlytics",
            path: "XCFrameworks/Firebase/FirebaseCrashlytics/FirebaseCrashlytics.xcframework"
        ),
        .binaryTarget(
            name: "GoogleDataTransport",
            path: "XCFrameworks/Firebase/FirebaseCrashlytics/GoogleDataTransport.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseAnalytics",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/FirebaseAnalytics.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseAnalyticsSwift",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/FirebaseAnalyticsSwift.xcframework"
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
            name: "FirebaseCore",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/FirebaseCore.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseCoreInternal",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/FirebaseCoreInternal.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseInstallations",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/FirebaseInstallations.xcframework"
        ),
        .binaryTarget(
            name: "GoogleUtilities",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/GoogleUtilities.xcframework"
        ),
        .binaryTarget(
            name: "FBLPromises",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/FBLPromises.xcframework"
        ),
        .binaryTarget(
            name: "nanopb",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/nanopb.xcframework"
        ),                
        .binaryTarget(
            name: "RxSwift",
            path: "XCFrameworks/RxSwift/RxSwift.xcframework"
        ),
        .binaryTarget(
            name: "RxCocoa",
            path: "XCFrameworks/RxSwift/RxCocoa.xcframework"
        ),
        .binaryTarget(
            name: "RxRelay",
            path: "XCFrameworks/RxSwift/RxRelay.xcframework"
        ),
        .binaryTarget(
            name: "RxBlocking",
            path: "XCFrameworks/RxSwift/RxBlocking.xcframework"
        ),        
    ]
)
