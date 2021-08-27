#if canImport(CryptoKit)
import CryptoKit
#else
import Crypto
#endif

import Foundation

public struct Generator {
  /// Generates a one-time password (OTP) from a secret payload and counter.
  /// - Parameters:
  ///   - secret: The secret to feed into the generator.
  ///   - counter: The counter to feed into the generator.
  ///   - numberOfDigits: The number of digits composing the one-time password.
  /// - Returns: A `String` representing the generated one-time password.
  public static func generateOTP(secret: Data, counter: UInt64, numberOfDigits: Int) -> String {
    let hash = generateHMACHash(secret: secret, counter: counter)
    let code = hash.dynamicallyTrimmed(numberOfDigits: numberOfDigits)
    return code
  }
  
  /// Generates the HMAC hash from a secret payload and a counter.
  /// - Parameters:
  ///   - secret: The secret to feed into the hasher.
  ///   - counter: The counter to feed into the hasher.
  /// - Returns: A `MessageAuthenticationCode` representing the generated hash.
  static func generateHMACHash(secret: Data, counter: UInt64) -> some MessageAuthenticationCode {
    var counter = counter.bigEndian
    let counterData = Data(bytes: &counter, count: MemoryLayout<UInt64>.size)
    
    return HMAC<Insecure.SHA1>.authenticationCode(for: counterData, using: SymmetricKey(data: secret))
  }
}
