import PackageDescription

let package = Package(
  name: "passing-cached-values",
  dependencies: [
    .Package(url: "https://github.com/bermudadigitalstudio/TitanKituraAdapter.git", majorVersion: 0),
    .Package(url: "https://github.com/bermudadigitalstudio/Titan", majorVersion: 0)
  ]
)
