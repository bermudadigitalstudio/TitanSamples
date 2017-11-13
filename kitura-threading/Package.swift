// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "kitura-threading",
    products: [
        .executable(name: "kitura-threading", targets: ["kitura-threading"]),
    ],
    dependencies: [
        .package(url: "https://github.com/bermudadigitalstudio/TitanKituraAdapter.git", from: "0.0.0"),
        .package(url: "https://github.com/bermudadigitalstudio/Titan", from: "0.0.0")
    ],
    targets: [
        .target(
            name: "kitura-threading",
            dependencies: [
                "TitanKituraAdapter",
                "Titan"
            ]),
    ]
)
