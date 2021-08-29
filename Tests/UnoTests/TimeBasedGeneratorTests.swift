//
//  Uno
//
//  Created by Gaetano Matonti on 27/08/21.
//

import XCTest
@testable import Uno

/// Test case for the `TimeBasedGenerator`.
/// - Note: Test data set from [page 14](https://datatracker.ietf.org/doc/html/rfc6238#page-14) of the
/// [RFC-6238](https://datatracker.ietf.org/doc/html/rfc6238) specifications.
final class TimerBasedGeneratorTests: XCTestCase {

  // MARK: - Stored Properties
  
  /// The secret to use for tests.
  private var secret: Secret!
  
  /// The `CounterBasedGenerator` under test.
  private var sut: TimeBasedGenerator!
  
  /// The seconds data set.
  private let testSeconds: [TimeInterval] = [
    59,
    1111111109,
    1111111111,
    1234567890,
    2000000000,
    20000000000
  ]

  // MARK: - Test Case Functions
  
  override func setUpWithError() throws {
    secret = try Secret(ascii: "12345678901234567890")
    sut = TimeBasedGenerator(secret: secret, codeLength: 8, timestep: 30)
  }
  
  // MARK: - Tests
  
  func testCounterConversionShouldBeCorrect() throws {
    let expectedResults: [UInt64] = [
      0x0000000000000001,
      0x00000000023523EC,
      0x00000000023523ED,
      0x000000000273EF07,
      0x0000000003F940AA,
      0x0000000027BC86AA
    ]
    
    for index in testSeconds.indices {
      let counter = try sut.counter(from: testSeconds[index])
      XCTAssertEqual(counter, expectedResults[index])
    }
  }
  
  func testGeneratedOTPsShouldBeCorrect() throws {
    let expectedResults = [
      "94287082",
      "07081804",
      "14050471",
      "89005924",
      "69279037",
      "65353130"
    ]
    
    for index in testSeconds.indices {
      let counter = try sut.generate(from: testSeconds[index])
      XCTAssertEqual(counter, expectedResults[index])
    }
  }
}
