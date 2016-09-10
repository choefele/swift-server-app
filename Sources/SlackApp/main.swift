import Kitura
import HeliumLogger
import LoggerAPI
import MongoKitten
import Environment
import SlackAppLibrary

HeliumLogger.use()

for e in Env.all() {
    Log.info("\(e.key) = \(e.value)")
}

let dbUrl = Env["DB_URL"] ?? "mongodb://localhost"
do {
    let mongoServer = try Server(dbUrl)
    try mongoServer.connect()
    Log.info("Connected to Mongo DB \(dbUrl)")

    let router = Router()

    let itemEndpoint = CRUDMongoEndpoint(collection: mongoServer["db"]["items"],
                                         generateDocument: ItemEndpoint.generateDocument,
                                         generateJsonDictionary: ItemEndpoint.generateJsonDictionary)
    let itemHandler = CRUDMongoHandler(endpoint: itemEndpoint)
    router.all("/items", handler: itemHandler.handleItems)
    router.all("/items/:id", handler: itemHandler.handleItem)

    router.get("/ping") { request, response, next in
        response.send("pong")
        next()
    }

    Kitura.addHTTPServer(onPort: 8090, with: router)
    Kitura.run()
} catch {
    Log.error("Cannot connect to Mongo DB \(dbUrl)")
}
