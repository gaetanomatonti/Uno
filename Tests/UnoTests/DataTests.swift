//
//  Uno
//
//  Created by Gaetano Matonti on 29/08/21.
//

import XCTest
@testable import Uno

/// Test case for the `Data` type extensions.
final class DataTests: XCTestCase {
  
  // MARK: - Tests
  
  func testDataFromHexStringShouldBeCorrect() throws {
    let hex = "48656C6C6F21DEADBEEF"
    let data = try Data(hex: hex)
    let bytes = data.map { $0 }
    let expectedResults: [UInt8] = [0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x21, 0xDE, 0xAD, 0xBE, 0xEF]
    XCTAssertEqual(bytes, expectedResults)
  }
}
