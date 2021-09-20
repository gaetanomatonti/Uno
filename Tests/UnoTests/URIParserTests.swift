//
//  Uno
//
//  Created by Gaetano Matonti on 06/09/21.
//

import XCTest
@testable import Uno

final class URIParserTests: XCTestCase {  
  func testMissingSchemeShouldThrow() {
    let sut = "randomstring"
    XCTAssertThrowsError(try URIParser(uri: sut)) { error in
      XCTAssertEqual(error as! URIParser.Error, URIParser.Error.missingScheme)
    }
  }
  
  func testInvalidSchemeShouldThrow() {
    let sut = "https:"
    XCTAssertThrowsError(try URIParser(uri: sut)) { error in
      XCTAssertEqual(error as! URIParser.Error, URIParser.Error.invalidScheme)
    }
  }
  
  func testMissingQueryItemsShouldThrow() {
    let sut = "otpauth://totp/Uno:john.doe@email.com"
    XCTAssertThrowsError(try URIParser(uri: sut)) { error in
      XCTAssertEqual(error as! URIParser.Error, URIParser.Error.missingQueryItems)
    }
  }
  
  func testInvalidOTPTypeShouldThrow() {
    let sut = "otpauth://otp/Uno:john.doe@email.com?issuer=Uno"
    XCTAssertThrowsError(try URIParser(uri: sut)) { error in
      XCTAssertEqual(error as! URIParser.Error, URIParser.Error.invalidOTPType)
    }
  }
  
  func testMissingPeriodShouldParseWithDefaultValue() throws {
    let sut = "otpauth://totp/Uno:john.doe@email.com?secret=JBSWY3DPEHPK3PXP&issuer=Uno"
    let parser = try URIParser(uri: sut)
    XCTAssertEqual(parser.kind, .defaultTimeBased)
  }
  
  func testMissingCounterShouldParseWithDefaultValue() throws {
    let sut = "otpauth://hotp/Uno:john.doe@email.com?secret=JBSWY3DPEHPK3PXP&issuer=Uno"
    let parser = try URIParser(uri: sut)
    XCTAssertEqual(parser.kind, .defaultCounterBased)
  }
  
  func testHOTPTypeShouldBeCorrect() throws {
    let sut = "otpauth://hotp/Uno:john.doe@email.com?issuer=Uno&secret=JBSWY3DPEHPK3PXP&counter=0"
    let parser = try URIParser(uri: sut)
    XCTAssertEqual(parser.kind, .counterBased(counter: 0))
  }
  
  func testTOTPTypeShouldBeCorrect() throws {
    let sut = "otpauth://totp/Uno:john.doe@email.com?issuer=Uno&secret=JBSWY3DPEHPK3PXP&period=30"
    let parser = try URIParser(uri: sut)
    XCTAssertEqual(parser.kind, .timeBased(timestep: 30))
  }
    
  func testSecretShouldBeCorrect() throws {
    let sut = "otpauth://totp/Uno:john.doe@email.com?issuer=Uno&secret=JBSWY3DPEHPK3PXP&period=30"
    let parser = try URIParser(uri: sut)
    let expectedResult = Data([0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x21, 0xDE, 0xAD, 0xBE, 0xEF])
    XCTAssertEqual(parser.secret.data, expectedResult)
  }
  
  func testAlgorithmShouldBeCorrect() throws {
    let sut = "otpauth://totp/Uno:john.doe@email.com?issuer=Uno&secret=JBSWY3DPEHPK3PXP&period=30&algorithm=SHA1"
    let parser = try URIParser(uri: sut)
    XCTAssertEqual(parser.algorithm, .sha1)
  }
  
  func testCodeLengthShouldBeCorrect() throws {
    let sut = "otpauth://totp/Uno:john.doe@email.com?issuer=Uno&secret=JBSWY3DPEHPK3PXP&period=30&algorithm=SHA1&digits=8"
    let parser = try URIParser(uri: sut)
    XCTAssertEqual(parser.codeLength, .eight)
  }
}
