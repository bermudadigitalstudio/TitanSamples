import PackageDescription

let package = Package(
    name: "authentication",  dependencies: [
    .Package(url: "https://github.com/bermudadigitalstudio/TitanKituraAdapter.git", majorVersion: 0),
    .Package(url: "https://github.com/bermudadigitalstudio/Titan", majorVersion: 0)
  ]
)
