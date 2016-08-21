import Kitura
import HeliumLogger
import LoggerAPI
import MongoKitten

HeliumLogger.use()

do {
    let mongoServer = try Server("mongodb://db")
    try mongoServer.connect()
} catch {
    Log.error("Cannot connect to Mongo DB")
}

let router = Router()

router.get("/ping") { request, response, next in
  response.send("pong")
  next()
}

Kitura.addHTTPServer(onPort: 8090, with: router)
Kitura.run()
