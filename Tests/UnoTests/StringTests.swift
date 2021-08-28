//
//  Uno
//
//  Created by Gaetano Matonti on 27/08/21.
//

import XCTest
@testable import Uno

/// Test case for the `String` type extensions.
final class StringTests: XCTestCase {
  
  // MARK: - Tests
  
  func testAuthenticationCodeShouldBeFormattedCorrectly() {
    let testNumbers = [
      0,
      1,
      12,
      123,
      1234,
      12345,
      123456
    ]
    
    let expectedResults = [
      "000000",
      "000001",
      "000012",
      "000123",
      "001234",
      "012345",
      "123456"
    ]
    
    for index in testNumbers.indices {
      let code = testNumbers[index]
      let formattedCode = String.formatAuthenticationCode(UInt64(code), numberOfDigits: 6)
      XCTAssertEqual(formattedCode, expectedResults[index])
    }
  }
}
