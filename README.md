# SlackApp
App for Slack with Swift and Docker

Swift: [DEVELOPMENT-SNAPSHOT-2016-07-25-a](https://swift.org/builds/development/xcode/swift-DEVELOPMENT-SNAPSHOT-2016-07-25-a/swift-DEVELOPMENT-SNAPSHOT-2016-07-25-a-osx.pkg)
Xcode: [Xcode 8b6](https://developer.apple.com/download/) with DEVELOPMENT-SNAPSHOT-2016-07-25-a as toolchain

## Build with Swift Package Manager
- Run `swift build` in root folder, wait until dependencies have been downloaded and server has been built
- Run server `./.build/debug/SlackApp`
- Test server by executing `curl http://localhost:8090/ping`

## Build with Xcode 8
- Generate Xcode project with `swift package generate-xcodeproj`
- Open `SlackApp.xcodeproj` in Xcode and Run `SlackApp` scheme
