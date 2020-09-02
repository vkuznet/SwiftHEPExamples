// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftHEPExamples",
    platforms: [
        .macOS(.v10_15),
    ],
   targets: [
        .target(name: "SwiftHEPExamples", dependencies: []),
        .testTarget(name: "SwiftHEPExamplesTests", dependencies: ["SwiftHEPExamples"]),
    ]
)
