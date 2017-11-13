// swift-tools-version:3.1
import PackageDescription

let package = Package(
  name: "kitura-threading",
  dependencies: [
    .Package(url: "https://github.com/bermudadigitalstudio/TitanKituraAdapter.git", majorVersion: 0),
    .Package(url: "https://github.com/bermudadigitalstudio/Titan", majorVersion: 0)
  ]
)
