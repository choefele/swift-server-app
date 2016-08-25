import Kitura
import HeliumLogger
import LoggerAPI
import MongoKitten
import Environment

#if os(Linux)
    public typealias AnyType = Any
#else
    public typealias AnyType = AnyObject
#endif

HeliumLogger.use()

let dbUrl = Env["DB_URL"] ?? "mongodb://localhost"
do {
    let mongoServer = try Server(dbUrl)
    try mongoServer.connect()
    Log.info("Connected to Mongo DB \(dbUrl)")
    
    let router = Router()
    
    let itemEndpoint = CRUDEndpoint<Item>(collection: mongoServer["db"]["items"],
                                          generateDocument: ItemEndpoint.generateDocument,
                                          generateItem: ItemEndpoint.generateItem,
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
