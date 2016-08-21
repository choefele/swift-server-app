import PackageDescription

let package = Package(
    name: "SlackApp",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura.git", majorVersion: 0, minor: 26),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", majorVersion: 0, minor: 14),
        .Package(url: "https://github.com/PlanTeam/MongoKitten.git", majorVersion: 1, minor: 4),
        .Package(url: "https://github.com/czechboy0/Environment.git", majorVersion: 0, minor: 5)
    ])
