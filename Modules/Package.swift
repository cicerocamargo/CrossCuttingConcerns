// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Modules",
            targets: ["BankSelection", "Networking"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "BankSelection-API",
            dependencies: []
        ),
        .target(
            name: "BankSelection",
            dependencies: ["BankSelection-API"]
        ),
        .testTarget(
            name: "BankSelectionTests",
            dependencies: ["BankSelection"]
        ),
        
        .target(
            name: "Networking",
            dependencies: ["BankSelection-API"]
        )
    ]
)
