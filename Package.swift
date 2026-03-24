// swift-tools-version:5.3
import PackageDescription

let version = "0.12.2"
let xcframework_name = "pbkdf2"
let binary_target_url_github_owner = "swiyu-admin-ch"
let binary_target_url_github_repo = "pbkdf2-swift"
let checksum = "08a0d7690533da0d2e6be9d006ccc28a6b675e77a1da49d0003222ab016de139"

let package = Package(
    name: "Pbkdf2",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Pbkdf2",
            targets: ["Pbkdf2", "Pbkdf2RemoteBinaryPackage"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Pbkdf2"
        ),
        .binaryTarget(
            name: "Pbkdf2RemoteBinaryPackage",
            url: "https://github.com/\(binary_target_url_github_owner)/\(binary_target_url_github_repo)/releases/download/\(version)/\(xcframework_name)-\(version).xcframework.zip",
            checksum: "\(checksum)"
        )
    ]
)
