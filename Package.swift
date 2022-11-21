// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CowTransfer-Api",
    platforms: [
        .iOS(.v13),
        .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CowTransfer-Api",
            targets: ["CowTransfer-Api"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/muukii/JAYSON", from: "2.5.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CowTransfer-Api",
            dependencies: [
                .product(name: "JAYSON", package: "JAYSON"),
            ]),
        .testTarget(
            name: "CowTransfer-ApiTests",
            dependencies: ["CowTransfer-Api"]),
    ]
)
