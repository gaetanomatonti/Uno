//
//  Uno
//
//  Created by Gaetano Matonti on 28/08/21.
//

import Foundation

/// A protocol the represents the requirements for a one-time password.
public protocol OTP {
  /// The secret to seed into the authentication code generator.
  var secret: Secret { get }
  
  /// The amount of digits composing the authentication code.
  var codeLength: Int { get }
}

// MARK: - Helper Functions

public extension OTP {
  /// The range describing the supported length of the authentication code.
  /// - Note: As required by [RFC-4226](https://datatracker.ietf.org/doc/html/rfc4226)
  /// an authentication code should have a minimum length of 6 and a maximum of 8 digits.
  static var supportedCodeLengthRange: ClosedRange<Int> {
    6...8
  }
  
  /// Whether the specified length of the code is valid.
  var isCodeLengthValid: Bool {
    Self.supportedCodeLengthRange.contains(codeLength)
  }
}
