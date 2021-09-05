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
  
  public let secret: OneTimePassword.Secret

  public let codeLength: Int
  
  public let algorithm: OneTimePassword.Algorithm

  // MARK: - Init
  
  public init(secret: OneTimePassword.Secret, codeLength: Int = 6, algorithm: OneTimePassword.Algorithm = .sha1) {
    self.secret = secret
    self.codeLength = codeLength
    self.algorithm = algorithm
  }
}

// MARK: - OTP Functions

extension CounterBasedGenerator {
  /// Generates a HMAC-based One-Time Password (HOTP) from a secret and moving factor.
  /// - Parameters:
  ///   - counter: A variable number that acts as a seed for the generator.
  /// - Returns: A `String` representing the generated one-time password.
  public func generate(from counter: UInt64) throws -> String {
    let hmac = try generateHMAC(from: counter)
    let code = hmac.dynamicallyTrimmed(numberOfDigits: codeLength)
    return code
  }
  
  /// Generates the HMAC hash from a secret payload and a moving factor.
  /// - Parameters:
  ///   - counter: A variable number that acts as a seed for the generator.
  /// - Returns: A `Data` payload representing a HMAC.
  func generateHMAC(from counter: UInt64) throws -> Data {
    guard isCodeLengthValid else {
      throw Error.codeLengthNotSupported
    }
    
    guard secret.isValid(for: algorithm) else {
      throw OneTimePassword.Algorithm.Error.invalidMinimumKeySize
    }

    var counter = counter.bigEndian
    let counterData = Data(bytes: &counter, count: MemoryLayout<UInt64>.size)
        
    return generateHMAC(from: secret.symmetricKey, data: counterData)
  }
  
  /// Generates the HMAC from a secret key and data payload.
  /// - Note: Implementation works around a limitation for protocols with associated types
  /// by returning a `Data` object instead of a more specific `MessageAuthenticationCode`.
  /// This issue might be fixed in future implementations.
  /// - Parameters:
  ///   - key: The symmetric cryptographic key to use as seed.
  ///   - data: The data payload to use as seed.
  /// - Returns: A `Data` payload representing a HMAC.
  func generateHMAC(from key: SymmetricKey, data: Data) -> Data {
    switch algorithm {
      case .sha1:
        return Data(HMAC<Insecure.SHA1>.authenticationCode(for: data, using: key))
        
      case .sha256:
        return Data(HMAC<SHA256>.authenticationCode(for: data, using: key))

      case .sha512:
        return Data(HMAC<SHA512>.authenticationCode(for: data, using: key))
    }
  }
}
