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
    
    let itemsDatabaseProviderV2 = CRUDMongoDatabaseProviderV2<Item>(collection: mongoServer["db"]["items"])
    let itemsCRUDHandlerV2 = CRUDHandlerV2(databaseProvider: itemsDatabaseProviderV2)
//    let item = try mongoDatabaseProviderV2.readItems()

    let mongoDatabaseProvider = CRUDMongoDatabaseProvider(collection: mongoServer["db"]["items"])
    let itemsCRUDHandler = CRUDHandler<Item>(databaseProvider: mongoDatabaseProvider)
    router.all("/items", handler: itemsCRUDHandler.handleItems)
    router.all("/items/:id", handler: itemsCRUDHandler.handleItem)
    
    router.get("/ping") { request, response, next in
        response.send("pong")
        next()
    }
    
    Kitura.addHTTPServer(onPort: 8090, with: router)
    Kitura.run()
} catch {
    Log.error("Cannot connect to Mongo DB \(dbUrl)")
}
