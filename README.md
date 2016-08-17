# SlackApp
App for Slack with Swift and Docker

Swift:
- [DEVELOPMENT-SNAPSHOT-2016-07-25-a](https://swift.org/builds/development/xcode/swift-DEVELOPMENT-SNAPSHOT-2016-07-25-a/swift-DEVELOPMENT-SNAPSHOT-2016-07-25-a-osx.pkg)
- Xcode: [Xcode 8b6](https://developer.apple.com/download/) with DEVELOPMENT-SNAPSHOT-2016-07-25-a as toolchain
- Select Xcode 8 as default `sudo xcode-select -s /Applications/Xcode-beta.app/Contents/Developer/`
- Swift toolchain in `PATH`, e.g. `export PATH=/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:$PATH`

## Build & run with Swift Package Manager
- Run `swift build` in root folder, wait until dependencies have been downloaded and server has been built
- Run server `./.build/debug/SlackApp`
- Test server by executing `curl http://localhost:8090/ping`

## Build & run with Xcode 8
- Generate Xcode project with `swift package generate-xcodeproj`
- Run `swift package fetch` in root folder to update dependencies
- Open `SlackApp.xcodeproj` in Xcode and Run `SlackApp` scheme
- Test server by executing `curl http://localhost:8090/ping`

## Build & run in Docker
- Build image with `docker build -t slackapp .`
- Run with `docker run -it --rm -p 8090:8090 slackapp`
- Test server by executing `curl http://localhost:8090/ping`