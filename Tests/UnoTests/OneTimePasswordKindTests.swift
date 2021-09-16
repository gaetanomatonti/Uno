//
//  Uno
//
//  Created by Gaetano Matonti on 06/09/21.
//

import XCTest
@testable import Uno

final class OneTimePasswordKindTests: XCTestCase {
  func testCounterShouldBeEqual() {
    XCTAssertEqual(OneTimePassword.Kind.counterBased(counter: 0), OneTimePassword.Kind.counterBased(counter: 0))
  }
  
  func testCounterShouldNotBeEqual() {
    XCTAssertNotEqual(OneTimePassword.Kind.counterBased(counter: 0), OneTimePassword.Kind.counterBased(counter: 10))
  }
  
  func testTimestepShouldBeEqual() {
    XCTAssertEqual(OneTimePassword.Kind.timeBased(timestep: 30), OneTimePassword.Kind.timeBased(timestep: 30))
  }

  func testTimestepShouldNotBeEqual() {
    XCTAssertNotEqual(OneTimePassword.Kind.timeBased(timestep: 30), OneTimePassword.Kind.timeBased(timestep: 60))
  }
  
  func testKindsShouldNotBeEqual() {
    XCTAssertNotEqual(OneTimePassword.Kind.counterBased(counter: 0), OneTimePassword.Kind.timeBased(timestep: 60))
  }
}
