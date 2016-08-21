import Kitura
import HeliumLogger
import LoggerAPI
import MongoKitten
import Environment

HeliumLogger.use()

let dbUrl = Env["DB_URL"] ?? "mongodb://localhost"
do {
    let mongoServer = try Server(dbUrl)
    try mongoServer.connect()
    Log.info("Connected to Mongo DB \(dbUrl)")
} catch {
    Log.error("Cannot connect to Mongo DB \(dbUrl)")
}

let router = Router()

router.get("/ping") { request, response, next in
  response.send("pong")
  next()
}

Kitura.addHTTPServer(onPort: 8090, with: router)
Kitura.run()
