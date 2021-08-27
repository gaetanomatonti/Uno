import XCTest
@testable import Uno

/// Test case for the OTP `Generator` object.
/// - Note: Test data set from [RFC-4226](https://datatracker.ietf.org/doc/html/rfc4226) specifications.
final class GeneratorTests: XCTestCase {
  private let secret = "12345678901234567890".data(using: .ascii)!
  
  func testHMAC_SHA1_Hashes() {
    let testHashes = [
      "cc93cf18508d94934c64b65d8ba7667fb7cde4b0",
      "75a48a19d4cbe100644e8ac1397eea747a2d33ab",
      "0bacb7fa082fef30782211938bc1c5e70416ff44",
      "66c28227d03a2d5529262ff016a1e6ef76557ece",
      "a904c900a64b35909874b33e61c5938a8e15ed1c",
      "a37e783d7b7233c083d4f62926c7a25f238d0316",
      "bc9cd28561042c83f219324d3c607256c03272ae",
      "a4fb960c0bc06e1eabb804e5b397cdc4b45596fa",
      "1b3c89f65e6c9e883012052823443f048b4332db",
      "1637409809a679dc698207310c8c7fc07290d9e5"
    ]
    
    for index in testHashes.indices {
      let generatedHash = Generator.generateHMACHash(secret: secret, counter: UInt64(index))
      XCTAssertEqual(generatedHash.hexString, testHashes[index])
    }
  }
  
  func testHMAC_SHA1_TrimmedHashes() {
    let trimmedHashes = [
      "4c93cf18",
      "41397eea",
      "82fef30",
      "66ef7655",
      "61c5938a",
      "33c083d4",
      "7256c032",
      "4e5b397",
      "2823443f",
      "2679dc69"
    ]
    
    for index in trimmedHashes.indices {
      let generatedHash = Generator.generateHMACHash(secret: secret, counter: UInt64(index))
      XCTAssertEqual(generatedHash.dynamicallyTrimmedHash.hexString(enablePadding: false), trimmedHashes[index])
    }
  }
  
  func testHMAC_SHA1_TrimmedDecimals() {
    let trimmedDecimals: [UInt64] = [
      1284755224,
      1094287082,
      137359152,
      1726969429,
      1640338314,
      868254676,
      1918287922,
      82162583,
      673399871,
      645520489
    ]

    for index in trimmedDecimals.indices {
      let generatedHash = Generator.generateHMACHash(secret: secret, counter: UInt64(index))
      XCTAssertEqual(generatedHash.trimmedDecimals, trimmedDecimals[index])
    }
  }
  
  func testHMAC_SHA1_OTPs() {
    let otps = [
      "755224",
      "287082",
      "359152",
      "969429",
      "338314",
      "254676",
      "287922",
      "162583",
      "399871",
      "520489"
    ]
    
    for index in otps.indices {
      let generatedOTP = Generator.generateOTP(secret: secret, digitsCount: 6, counter: UInt64(index))
      XCTAssertEqual(generatedOTP, otps[index])
    }
  }
}
