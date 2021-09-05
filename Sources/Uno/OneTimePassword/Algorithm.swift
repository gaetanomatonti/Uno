//
//  Uno
//
//  Created by Gaetano Matonti on 29/08/21.
//

#if canImport(CryptoKit)
import CryptoKit
#else
import Crypto
#endif

public extension OneTimePassword {
  /// The hash function used to generate the HMAC.
  enum Algorithm {
    /// The SHA1 hash function. This is the most frequently used albeit insecure.
    case sha1
    
    /// The SHA256 hash function.
    case sha256
    
    /// The SHA512 hash function.
    case sha512
    
    // MARK: - Computed Properties
    
    /// The minimum size of the symmetric key in bytes.
    var minimumKeySize: Int {
      switch self {
        case .sha1:
          return 20
          
        case .sha256:
          return 32
          
        case .sha512:
          return 64
      }
    }
  }
}

// MARK: - Errors

public extension OneTimePassword.Algorithm {
  /// The possible errors regarding the hash functions.
  enum Error: Swift.Error {
    /// The minimum size of the symmetric key does not match the requirement.
    case invalidMinimumKeySize
  }
}
