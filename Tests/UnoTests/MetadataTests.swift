//
//  Uno
//
//  Created by Gaetano Matonti on 25/09/21.
//

import XCTest
@testable import Uno

final class MetadataTests: XCTestCase {
  func testURIShouldBeCorrect() throws {
    let metadata = try OneTimePassword.Metadata(
      issuer: "Uno",
      account: "john@example.com",
      secret: OneTimePassword.Secret(ascii: "HelloWorld"),
      codeLength: .eight,
      algorithm: .sha256,
      kind: .timeBased(timestep: 10)
    )
    
    let uri = try XCTUnwrap(metadata.uri)
    let sut = try XCTUnwrap(URLComponents(string: uri.absoluteString))
    
    let expectedResult = try XCTUnwrap(
      URLComponents(string: "otpauth://totp/Uno:john@example.com?issuer=Uno&secret=HelloWorld&digits=8&algorithm=SHA256&period=10")
    )
    
    XCTAssertEqual(sut.scheme, expectedResult.scheme)
    XCTAssertEqual(sut.host, expectedResult.host)
    XCTAssertEqual(sut.path, expectedResult.path)
    XCTAssertEqual(sut.queryItems?.sorted, expectedResult.queryItems?.sorted)
  }
  
  func testURIWithoutLabelShouldBeCorrect() throws {
    let metadata = try OneTimePassword.Metadata(
      secret: OneTimePassword.Secret(ascii: "HelloWorld"),
      codeLength: .eight,
      algorithm: .sha256,
      kind: .timeBased(timestep: 10)
    )
    
    let uri = try XCTUnwrap(metadata.uri)
    let sut = try XCTUnwrap(URLComponents(string: uri.absoluteString))
    
    let expectedResult = try XCTUnwrap(
      URLComponents(string: "otpauth://totp?secret=HelloWorld&digits=8&algorithm=SHA256&period=10")
    )
    
    XCTAssertEqual(sut.scheme, expectedResult.scheme)
    XCTAssertEqual(sut.host, expectedResult.host)
    XCTAssertEqual(sut.path, expectedResult.path)    
    XCTAssertEqual(sut.queryItems?.sorted, expectedResult.queryItems?.sorted)
  }
}
