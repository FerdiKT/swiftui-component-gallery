// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SwiftUIComponentGallery",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "SwiftUIComponentGallery",
            targets: ["SwiftUIComponentGallery"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftUIComponentGallery",
            dependencies: []),
        .testTarget(
            name: "SwiftUIComponentGalleryTests",
            dependencies: ["SwiftUIComponentGallery"]),
    ]
)