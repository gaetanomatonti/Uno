//
//  Uno
//
//  Created by Gaetano Matonti on 28/08/21.
//

#if canImport(CryptoKit)
import CryptoKit
#else
import Crypto
#endif

import Foundation

public extension OneTimePassword {
  /// An object containing information for a one-time password hash secret.
  struct Secret {
    
    // MARK: - Stored Properties
    
    /// The bytes of the secret.
    let data: Data
    
    // MARK: - Computed Properties
    
    /// The symmetric cryptographic key enclosing the secret.
    var symmetricKey: SymmetricKey {
      SymmetricKey(data: data)
    }
    
    // MARK: - Init
    
    /// Creates an instance of `Secret` from an ASCII encoded String.
    /// - Parameter ascii: The ASCII encoded String.
    public init(ascii string: String) throws {
      guard let data = string.data(using: .ascii) else {
        throw Error.asciiConversionToDataFailed
      }
      
      self.data = data
    }
    
    /// Creates an instance of `Secret` from an ASCII encoded String.
    /// - Parameter string: The hexadecimal `String` representation of the secret.
    public init(hex string: String) throws {
      self.data = try Data(hex: string)
    }
  }
}

// MARK: - Helpers

extension OneTimePassword.Secret {
  /// Checks whether the secret is valid for use with the specified algorithm.
  /// - Parameter algorithm: The algorithm to check on.
  /// - Returns: A `Bool` indicating whether the secret is valid.
  func isValid(for algorithm: OneTimePassword.Algorithm) -> Bool {
    data.count >= algorithm.minimumKeySize
  }
}

// MARK: - Errors

public extension OneTimePassword.Secret {
  /// The possible errors regarding a `Secret`.
  enum Error: Swift.Error, LocalizedError {
    /// The conversion from ASCII to data bytes failed.
    case asciiConversionToDataFailed
    
    public var errorDescription: String? {
      switch self {
        case .asciiConversionToDataFailed:
          return "The conversion from ASCII to data bytes failed."
      }
    }
  }
}
