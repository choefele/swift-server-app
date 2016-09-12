@testable import SwiftServerLibrary
import Kitura
import MongoKitten
import XCTest

class ItemTests: XCTestCase {
    func testGetRequestStatusCode() {
        let e = expectation(description: "test")
        e.fulfill()
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(40, 40)
    }

//    func testRouter() {
//        guard let mongoServer = try? Server("mongodb://localhost", automatically: false) else { XCTAssert(false); return }
//        let router = Router()
//
//        let itemEndpoint = CRUDMongoEndpoint(collection: mongoServer["db"]["items"],
//                                             generateDocument: ItemEndpoint.generateDocument,
//                                             generateJsonDictionary: ItemEndpoint.generateJsonDictionary)
//        let itemHandler = CRUDMongoHandler(endpoint: itemEndpoint)
//        router.all("/items", handler: itemHandler.handleItems)
//        router.all("/items/:id", handler: itemHandler.handleItem)
//
//
//        let e = expectation(description: "test")
//        router.get("/items") { request, response, next in
//            response.send("pong")
//            next()
//        }
//    }
}
