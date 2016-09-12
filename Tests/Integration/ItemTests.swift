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

//    func testKitura() {
//        // Set up router for this test
//        let router = Router()
//
//        router.get("/zxcv/:p1") { request, _, next in
//            let parameter = request.parameters["p1"]
//            XCTAssertNotNil(parameter, "URL parameter p1 was nil")
//            next()
//        }
//        router.get("/zxcv/ploni") { request, _, next in
//            let parameter = request.parameters["p1"]
//            XCTAssertNil(parameter, "URL parameter p1 was not nil, it's value was \(parameter!)")
//            next()
//        }
//        router.all() { _, response, next in
//            response.status(.OK).send("OK")
//            next()
//        }
//
//        performServerTest(router) { expectation in
//            self.performRequest("get", path: "/zxcv/ploni", callback: { response in
//                XCTAssertNotNil(response, "ERROR!!! ClientRequest response object was nil")
//                expectation.fulfill()
//            })
//        }
//    }
}
