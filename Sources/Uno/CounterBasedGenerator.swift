//
//  Uno
//
//  Created by Gaetano Matonti on 27/08/21.
//

#if canImport(CryptoKit)
import CryptoKit
#else
import Crypto
#endif

import Foundation

/// A type that represents an HMAC-based one-time password.
public struct CounterBasedGenerator: AuthenticationCodeGenerator {
  /// The possible errors thrown in `CounterBasedGenerator`.
  public enum Error: Swift.Error {
    /// The length of the authentication code is not supported.
    case codeLengthNotSupported
  }
  
  // MARK: - Stored Properties
  
  public let secret: Secret

  public let codeLength: Int

  // MARK: - Init
  
  public init(secret: Secret, codeLength: Int = 6) {
    self.secret = secret
    self.codeLength = codeLength
  }
}

// MARK: - OTP Functions

extension CounterBasedGenerator {
  /// Generates a HMAC-based One-Time Password (HOTP) from a secret and moving factor.
  /// - Parameters:
  ///   - counter: A variable number that acts as a seed for the generator.
  /// - Returns: A `String` representing the generated one-time password.
  public func generate(from counter: UInt64) throws -> String {
    let hash = try generateHMACHash(from: counter)
    let code = hash.dynamicallyTrimmed(numberOfDigits: codeLength)
    return code
  }
  
  /// Generates the HMAC hash from a secret payload and a moving factor.
  /// - Parameters:
  ///   - counter: A variable number that acts as a seed for the generator.
  /// - Returns: A `MessageAuthenticationCode` representing the generated hash.
  func generateHMACHash(from counter: UInt64) throws -> some MessageAuthenticationCode {
    guard isCodeLengthValid else {
      throw Error.codeLengthNotSupported
    }
    
    var counter = counter.bigEndian
    let counterData = Data(bytes: &counter, count: MemoryLayout<UInt64>.size)
    
    return HMAC<Insecure.SHA1>.authenticationCode(for: counterData, using: secret.symmetricKey)
  }
}
