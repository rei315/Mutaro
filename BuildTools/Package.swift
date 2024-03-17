// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BuildTools",
    products: [
        .plugin(
            name: "LicensePlistPlugin",
            targets: ["LicensePlistPlugin"]
        ),
    ],
    targets: [
        .plugin(
            name: "LicensePlistPlugin",
            capability: .buildTool(),
            dependencies: [
                "LicensePlistBinary"
            ]
        ),
        .binaryTarget(
            name: "LicensePlistBinary",
            url: "https://github.com/mono0926/LicensePlist/releases/download/3.25.1/LicensePlistBinary-macos.artifactbundle.zip",
            checksum: "a80181eeed49396dae5d3ce6fc339f33a510299b068fd6b4f507483db78f7f30"
        )
    ]
)
