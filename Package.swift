// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FontAwesome.swift",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "FontAwesome.swift", targets: ["Core", "FA+UIKit"]),
        
        .library(name: "FontAwesome.UIKit.swift", targets: ["FA+UIKit"]),
        .library(name: "FontAwesome.SwiftUI.swift", targets: ["FA+SwiftUI"]),
        
        .executable(name: "tools", targets: ["Tools"])
    ],
    dependencies: [
        .package(url: "https://github.com/stencilproject/Stencil", from: "0.14.0"),
        .package(url: "https://github.com/jakeheis/SwiftCLI", from: "6.0.0"),
    ],
    targets: [
        .target(name: "Core", dependencies: [], resources: [
            .copy("Resources/")
        ]),
        
        .target(name: "FA+UIKit", dependencies: ["Core"]),
        .target(name: "FA+SwiftUI", dependencies: ["Core"]),
        
        .target(name: "Tools", dependencies: ["Stencil", "SwiftCLI"], exclude: ["stencils/"]),
        
        .testTarget(name: "FontAwesome.swiftTests", dependencies: ["Core", "FA+UIKit", "FA+SwiftUI"]),
    ]
)
