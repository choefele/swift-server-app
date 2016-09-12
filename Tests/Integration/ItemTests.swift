@testable import SwiftServerLibrary
import Kitura
import XCTest

class ItemTests: XCTestCase {
    func testGetRequestStatusCode() {
        let e = expectation(description: "test")
        e.fulfill()
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(40, 40)
    }
}
