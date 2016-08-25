import XCTest
import MongoKitten
import Foundation

class CRUDHandlerTests: XCTestCase {
    static var allTests: [(String, (CRUDHandlerTests) -> () throws -> Void)] {
        return [
            ("testSetup", testSetup),
        ]
    }

    func testSetup() {
        XCTAssertEqual(49, 49)
    }
}