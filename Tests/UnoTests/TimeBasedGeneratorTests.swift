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
  
  /// The secret to use for SHA1 tests.
  private var secretSHA1: Secret!
  
  /// The secret to use for SHA256 tests.
  private var secretSHA256: Secret!
  
  /// The secret to use for SHA512 tests.
  private var secretSHA512: Secret!

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
    secretSHA1 = try Secret(ascii: "12345678901234567890")
    secretSHA256 = try Secret(ascii: "12345678901234567890123456789012")
    secretSHA512 = try Secret(ascii: "1234567890123456789012345678901234567890123456789012345678901234")
  }
  
  // MARK: - Tests
  
  func testCounterConversionShouldBeCorrect() throws {
    let sut = TimeBasedGenerator(secret: secretSHA1, codeLength: 8, timestep: 30)
    
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
  
  func testGeneratedOTPsSHA1ShouldBeCorrect() throws {
    let sut = TimeBasedGenerator(secret: secretSHA1, codeLength: 8, timestep: 30)

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
    
  func testGeneratedOTPsSHA256ShouldBeCorrect() throws {
    let sut = TimeBasedGenerator(secret: secretSHA256, codeLength: 8, algorithm: .sha256, timestep: 30)

    let expectedResults = [
      "46119246",
      "68084774",
      "67062674",
      "91819424",
      "90698825",
      "77737706"
    ]
    
    for index in testSeconds.indices {
      let counter = try sut.generate(from: testSeconds[index])
      XCTAssertEqual(counter, expectedResults[index])
    }
  }
  
  func testGeneratedOTPsSHA512ShouldBeCorrect() throws {
    let sut = TimeBasedGenerator(secret: secretSHA512, codeLength: 8, algorithm: .sha512, timestep: 30)

    let expectedResults = [
      "90693936",
      "25091201",
      "99943326",
      "93441116",
      "38618901",
      "47863826"
    ]
    
    for index in testSeconds.indices {
      let counter = try sut.generate(from: testSeconds[index])
      XCTAssertEqual(counter, expectedResults[index])
    }
  }
}
