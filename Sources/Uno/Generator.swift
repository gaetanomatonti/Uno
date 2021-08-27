#if canImport(CryptoKit)
import CryptoKit
#else
import Crypto
#endif

import Foundation

public struct Generator {  
  public static func generateOTP(secret: Data, digitsCount: Int, counter: UInt64) -> String {
    let hash = generateHMACHash(secret: secret, counter: counter)
    let code = hash.dynamicallyTrimmed(digitsCount: digitsCount)
    return code
  }
  
  /// Generates the HMAC hash from a secret payload and a counter.
  /// - Parameters:
  ///   - secret: The secret to feed into the hash generator.
  ///   - counter: The counter to feed into the hash generator.
  /// - Returns: A `MessageAuthenticationCode` representing the generated hash.
  static func generateHMACHash(secret: Data, counter: UInt64) -> some MessageAuthenticationCode {
    var counter = counter.bigEndian
    let counterData = Data(bytes: &counter, count: MemoryLayout<UInt64>.size)
    
    return HMAC<Insecure.SHA1>.authenticationCode(for: counterData, using: SymmetricKey(data: secret))
  }
}
