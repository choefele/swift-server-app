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

struct EndPoint<Item> {
    let collection: MongoKitten.Collection
    var generateDocument: ([String: String]) -> Document
//    var generateQuery: ([String: String]) -> Query
    var generateItem: (Document) -> Item
    var generateJsonDictionary: (Item) -> [String: AnyType]
}

let dbUrl = Env["DB_URL"] ?? "mongodb://localhost"
do {
    let mongoServer = try Server(dbUrl)
    try mongoServer.connect()
    Log.info("Connected to Mongo DB \(dbUrl)")
    
    let router = Router()
    
    let itemEndpoint = EndPoint<Data>(collection: mongoServer["db"]["items"], generateDocument: DataEndpoint.generateDocument, generateItem: DataEndpoint.generateItem, generateJsonDictionary: DataEndpoint.generateJsonDictionary)
    let itemHandler = CRUDHandlerV3(endpoint: itemEndpoint)
    router.all("/items", handler: itemHandler.handleItems)
    router.all("/items/:id", handler: itemHandler.handleItem)
    
    let itemEndpoint2 = EndPoint<Data2>(collection: mongoServer["db"]["items"], generateDocument: Data2Endpoint.generateDocument, generateItem: Data2Endpoint.generateItem, generateJsonDictionary: Data2Endpoint.generateJsonDictionary)
    let itemHandler2 = CRUDHandlerV3(endpoint: itemEndpoint2)
    
    let handlers: [CRUDHandlerType] = [itemHandler, itemHandler2]
    for handler in handlers {
        router.all("", handler: handler.handleItems)
    }
    
//    let itemsDatabaseProviderV2 = CRUDMongoDatabaseProviderV2<Item>(collection: mongoServer["db"]["items"])
//    let itemsCRUDHandlerV2 = CRUDHandlerV2(databaseProvider: itemsDatabaseProviderV2)

//    let mongoDatabaseProvider = CRUDMongoDatabaseProvider(collection: mongoServer["db"]["items"])
//    let itemsCRUDHandler = CRUDHandler<Item>(databaseProvider: mongoDatabaseProvider)
//    router.all("/items", handler: itemsCRUDHandler.handleItems)
//    router.all("/items/:id", handler: itemsCRUDHandler.handleItem)
    
    router.get("/ping") { request, response, next in
        response.send("pong")
        next()
    }
    
    Kitura.addHTTPServer(onPort: 8090, with: router)
    Kitura.run()
} catch {
    Log.error("Cannot connect to Mongo DB \(dbUrl)")
}
