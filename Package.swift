// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TooltipKit",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "TooltipKit",
            targets: ["TooltipKit"]
        )
    ],
    targets: [
        .target(
            name: "TooltipKit",
            path: "Sources/TooltipKit"
        )
    ]
)
