//
//  OneTimePasswordGenerator.swift
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

/// An object that handles the generation of One-Time Passwords.
/// - Note: This currently supports the generation of HOTPs (HMAC-based OTP) via SHA1.
struct OneTimePasswordGenerator {
  /// Generates a HMAC-based One-Time Password (HOTP) from a secret and moving factor.
  /// - Parameters:
  ///   - secret: A static value that acts as a seed for the generator.
  ///   - counter: A variable number that acts as a seed for the generator.
  ///   - numberOfDigits: The number of digits composing the one-time password.
  /// - Returns: A `String` representing the generated one-time password.
  static func generateHOTP(secret: Secret, counter: UInt64, numberOfDigits: Int) -> String {
    let hash = generateHMACHash(secret: secret, counter: counter)
    let code = hash.dynamicallyTrimmed(numberOfDigits: numberOfDigits)
    return code
  }
  
  /// Generates the HMAC hash from a secret payload and a moving factor.
  /// - Parameters:
  ///   - secret: A static value that acts as a seed for the generator.
  ///   - counter: A variable number that acts as a seed for the generator.
  /// - Returns: A `MessageAuthenticationCode` representing the generated hash.
  static func generateHMACHash(secret: Secret, counter: UInt64) -> some MessageAuthenticationCode {
    var counter = counter.bigEndian
    let counterData = Data(bytes: &counter, count: MemoryLayout<UInt64>.size)
    
    let key = SymmetricKey(data: secret.data)
    return HMAC<Insecure.SHA1>.authenticationCode(for: counterData, using: key)
  }
}
