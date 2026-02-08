// swift-tools-version: 5.9
import PackageDescription

let package = Package(
  name: "MelApp",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .executable(name: "MelApp", targets: ["MelApp"])
  ],
  targets: [
    .executableTarget(
      name: "MelApp",
      path: "Sources/MelApp"
    )
  ]
)
