// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "FontAwesome",
    products: [
        .library(name: "FontAwesome", targets: ["FontAwesome"]),
        .executable(name: "tools", targets: ["tools"])
    ],
    targets: [
        .target(
            name: "FontAwesome",
            path: "FontAwesome"
        ),
        .target(
            name: "tools",
            path: "tools"
        )
    ]
)
