// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "Flex",
  platforms: [
    .iOS(.v10)
  ],
  products: [
    .library(name: "Flex", targets: ["Flex"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.6.0"),
  ],
  targets: [
    .target(
      name: "Flex",
      dependencies: ["Yoga", "YogaDebug"]
    ),
    .target(
      name: "Yoga"
    ),
    .target(
      name: "YogaDebug",
      dependencies: ["Yoga"]
    ),
    .testTarget(name: "FlexTests", dependencies: ["Flex", "SnapshotTesting"])
  ],
  cLanguageStandard: .gnu11,
  cxxLanguageStandard: .gnucxx14
)
