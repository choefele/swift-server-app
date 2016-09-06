# SlackApp
App for Slack with Swift and Docker

Swift:
- [DEVELOPMENT-SNAPSHOT-2016-07-25-a](https://swift.org/builds/development/xcode/swift-DEVELOPMENT-SNAPSHOT-2016-07-25-a/swift-DEVELOPMENT-SNAPSHOT-2016-07-25-a-osx.pkg)
- Xcode: [Xcode 8b6](https://developer.apple.com/download/) with DEVELOPMENT-SNAPSHOT-2016-07-25-a as toolchain
- Select Xcode 8 as default `sudo xcode-select -s /Applications/Xcode-beta.app/Contents/Developer/`
- Swift toolchain in `PATH`, e.g. `export PATH=/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:$PATH`

## Build & run with Swift Package Manager
- Run `swift build` in root folder, wait until dependencies have been downloaded and server has been built
- Run dependent services `docker-compose -f docker-compose-dev.yml up`
- Run server `./.build/debug/SlackApp`
- Test server by executing `curl http://localhost:8090/ping`

## Build & run with Xcode 8
- Run `swift package fetch` in root folder to update dependencies
- Generate Xcode project with `swift package generate-xcodeproj`
- Run dependent services `docker-compose -f docker-compose-dev.yml up`
- Open `SlackApp.xcodeproj` in Xcode and Run `SlackApp` scheme
- Test server by executing `curl http://localhost:8090/ping`

## Build & run in Docker
- Build image with `docker-compose build`
- Run with `docker-compose up [-d]` (stop: `docker-compose down [-v]`, logs: `docker-compose logs -f`)
- Test server by executing `curl http://localhost:8090/ping`

## Connect `mongo` to database server
- `docker-compose run --rm db mongo mongodb://db` to connect to database
-- `use test`, `db.test.insert({})`, `db.test.find()` to create sample data
- Restart db instance to see that data persists in volume container

Managed volumes:
- `docker inspect -f "{{json .Mounts}}" slackapp_db_1` to find out mount point
- `docker volume ls -f dangling=true` to find orphaned managed volumes
- `docker volume rm $(docker volume ls -qf dangling=true)` to remove orphaned volumes