// swift-tools-version:5.3
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
            path: "FontAwesome",
            exclude: [
            	"Info.plist"
            ],
            resources: [
            	.copy("Font Awesome 5 Brands-Regular-400.otf"),
             	.copy("Font Awesome 5 Free-Regular-400.otf"),
            	.copy("Font Awesome 5 Free-Solid-900.otf")
            ]
        ),
        .target(
            name: "tools",
            path: "tools"
        )
    ]
)
