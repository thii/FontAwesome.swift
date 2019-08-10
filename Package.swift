// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "FontAwesome",
    products: [
        .library(name: "FontAwesome", targets: ["FontAwesome"]),
    ],
    targets: [
        .target(
            name: "FontAwesome",
            path: "FontAwesome"
        ),
    ]
)
