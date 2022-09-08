// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Eazyshow",
    platforms: [
        SupportedPlatform.iOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Eazyshow",
            targets: ["Eazyshow"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(name: "Eazyshow", url: "https://https://mustdev.ru/v2/1.100.1/Eazyshow.xcframework.zip", checksum: "28997950c8f345946f2975d5534bee231ba12a0f1526512c7a4d7dcfb9bb0fc7")
    ]
)
