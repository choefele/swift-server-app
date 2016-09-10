@testable import SlackAppLibrary
import Kitura
import XCTest

class ItemTests: XCTestCase {

    //let client = GetClient()
//    let provider = CRUDMongoProvider()

    func testGetRequestStatusCode() {
        let e = expectation(description: "test")
        e.fulfill()
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(40, 40)
    }
}
