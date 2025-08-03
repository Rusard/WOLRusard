// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "WakeOnLine",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .library(name: "WakeOnLineCore", targets: ["WakeOnLineCore"]),
        .executable(name: "wakeonlan-cli", targets: ["WakeOnLineCLI"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WakeOnLineCore",
            path: "WakeOnLine/Networking"
        ),
        .executableTarget(
            name: "WakeOnLineCLI",
            dependencies: ["WakeOnLineCore"],
            path: "CLI"
        )
    ]
)
