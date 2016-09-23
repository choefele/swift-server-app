@testable import SwiftServerLibrary
//import Kitura
//import MongoKitten
import XCTest
import SwiftyJSON
//
class ItemTests: XCTestCase {
//    func testGetRequestStatusCode() {
//        let e = expectation(description: "test")
//        e.fulfill()
//        waitForExpectations(timeout: 1)
//        
//        XCTAssertEqual(40, 40)
//    }
//
//    func testGenerateJsonDictionary() {
//        let id = ObjectId()
//        let name = "name"
//        var document = Document()
//        document["_id"] = .objectId(id)
//        document["name"] = .string(name)
//
//        let jsonDictionary = ItemEndpoint.generateJsonDictionary(document: document)
//        XCTAssertEqual(jsonDictionary["id"] as? String, id.hexString)
//        XCTAssertEqual(jsonDictionary["name"] as? String, name)
//    }
//    
    func testJenkinsResponseWithInsufficientParams() {
        let json: JSON = [
            "lastCompleteBuild": ["number": 10],
            "lastSuccessBuild": ["number": 2],
            ]
        
        let parseResult = JenkinsService.parseAllBuildsResult(json)
        
        XCTAssertNil(parseResult)
    }

    func testJenkinsResponseWithSimpleValues() {
        let json: JSON = [
            "lastCompletedBuild": ["number": 10],
            "lastStableBuild": ["number": 2],
            "lastFailedBuild": ["number": 10],
            ]

        let parseResult = JenkinsService.parseAllBuildsResult(json)

        XCTAssertEqual(parseResult?.completed, 10)
        XCTAssertEqual(parseResult?.stable, 2)
        XCTAssertEqual(parseResult?.failed, 10)
    }
//
////    func testRouter() {
////        guard let mongoServer = try? Server("mongodb://localhost", automatically: false) else { XCTAssert(false); return }
////        let router = Router()
////
////        let itemEndpoint = CRUDMongoEndpoint(collection: mongoServer["db"]["items"],
////                                             generateDocument: ItemEndpoint.generateDocument,
////                                             generateJsonDictionary: ItemEndpoint.generateJsonDictionary)
////        let itemHandler = CRUDMongoHandler(endpoint: itemEndpoint)
////        router.all("/items", handler: itemHandler.handleItems)
////        router.all("/items/:id", handler: itemHandler.handleItem)
////
////
////        let e = expectation(description: "test")
////        router.get("/items") { request, response, next in
////            response.send("pong")
////            next()
////        }
////    }
//
////    func testKitura() {
////        // Set up router for this test
////        let router = Router()
////
////        router.get("/zxcv/:p1") { request, _, next in
////            let parameter = request.parameters["p1"]
////            XCTAssertNotNil(parameter, "URL parameter p1 was nil")
////            next()
////        }
////        router.get("/zxcv/ploni") { request, _, next in
////            let parameter = request.parameters["p1"]
////            XCTAssertNil(parameter, "URL parameter p1 was not nil, it's value was \(parameter!)")
////            next()
////        }
////        router.all() { _, response, next in
////            response.status(.OK).send("OK")
////            next()
////        }
////
////        performServerTest(router) { expectation in
////            self.performRequest("get", path: "/zxcv/ploni", callback: { response in
////                XCTAssertNotNil(response, "ERROR!!! ClientRequest response object was nil")
////                expectation.fulfill()
////            })
////        }
////    }
}
