// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "kitura-threading",
    products: [
        .executable(name: "kitura-threading", targets: ["kitura-threading"]),
    ],
    dependencies: [
        .package(url: "https://github.com/bermudadigitalstudio/TitanKituraAdapter.git", .branch("swift4")),
        .package(url: "https://github.com/bermudadigitalstudio/Titan.git", .branch("swift4"))
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
