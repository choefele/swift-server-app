import PackageDescription

let package = Package(
    name: "SlackApp",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 0, minor: 26),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger", majorVersion: 0, minor: 14),
    ])