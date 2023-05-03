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

let firebaseFirestoreDependencies: [Target.Dependency] = [
    "BoringSSL-GRPC",
    "FirebaseCoreExtension",
    "FirebaseFirestore",
    "FirebaseFirestoreSwift",
    "FirebaseSharedSwift",
    "Libuv-gRPC",
    "abseil",
    "gRPC-C++",
    "gRPC-Core",
    "leveldb-library",
]

let unittestDependencies: [Target.Dependency] = [
    .product(name: "Quick", package: "Quick"),
    .product(name: "Nimble", package: "Nimble")
]

let package = Package(
    name: "MutaroModule",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "Features",
            targets: ["Features"]
        ),
        .library(
            name: "FirebaseSetup",
            targets: ["FirebaseSetup"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", exact: "6.6.2"),
        .package(url: "https://github.com/realm/SwiftLint", from: "0.51.0"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.51.8"),
        .package(url: "https://github.com/Kitura/Swift-JWT", from: "4.0.1"),
        .package(url: "https://github.com/Quick/Quick", from: "6.1.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "12.0.0")
    ],
    targets: [
        .target(
            name: "Features",
            dependencies: ["ImageLoader", "Core", "AppResource", "Client"],
            swiftSettings: [
                .define("DEV", .when(configuration: .debug))
            ],
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
        ),
        .target(
            name: "Core",
            dependencies: ["ImageLoader"]
        ),
        .target(
            name: "Client",
            dependencies: []
        ),
        .target(
            name: "JWTGenerator",
            dependencies: [
                .product(name: "SwiftJWT", package: "Swift-JWT")
            ]
        ),
        .testTarget(
            name: "JWTGeneratorTests",
            dependencies: [
                "JWTGenerator"
            ] + unittestDependencies
        ),
        .target(
            name: "FirebaseSetup",
            dependencies: firebaseCrashlyticsDependencies + firebaseAnalyticsDependencies,
            linkerSettings: [
                .unsafeFlags(["-ObjC"])
            ]
        ),
        .target(
            name: "AppResource",
            dependencies: [],
            exclude: [
                "swiftgen.yml"
            ],
            plugins: [
                .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
            ]
        ),
        .target(
            name: "ImageLoader",
            dependencies: []
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
            path:
                "XCFrameworks/Firebase/FirebaseAnalytics/GoogleAppMeasurementIdentitySupport.xcframework"
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
            name: "BoringSSL-GRPC",
            path: "XCFrameworks/Firebase/FirebaseFirestore/BoringSSL-GRPC.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseCoreExtension",
            path: "XCFrameworks/Firebase/FirebaseFirestore/FirebaseCoreExtension.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseFirestore",
            path: "XCFrameworks/Firebase/FirebaseFirestore/FirebaseFirestore.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseFirestoreSwift",
            path: "XCFrameworks/Firebase/FirebaseFirestore/FirebaseFirestoreSwift.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseSharedSwift",
            path: "XCFrameworks/Firebase/FirebaseFirestore/FirebaseSharedSwift.xcframework"
        ),
        .binaryTarget(
            name: "Libuv-gRPC",
            path: "XCFrameworks/Firebase/FirebaseFirestore/Libuv-gRPC.xcframework"
        ),
        .binaryTarget(
            name: "abseil",
            path: "XCFrameworks/Firebase/FirebaseFirestore/abseil.xcframework"
        ),
        .binaryTarget(
            name: "gRPC-C++",
            path: "XCFrameworks/Firebase/FirebaseFirestore/gRPC-C++.xcframework"
        ),
        .binaryTarget(
            name: "gRPC-Core",
            path: "XCFrameworks/Firebase/FirebaseFirestore/gRPC-Core.xcframework"
        ),
        .binaryTarget(
            name: "leveldb-library",
            path: "XCFrameworks/Firebase/FirebaseFirestore/leveldb-library.xcframework"
        )
    ]
)
