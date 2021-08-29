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

/// The hash function used to generate the HMAC.
public enum Algorithm {
  /// The SHA1 hash function. This is the most frequently used aslthough quite insecure.
  case sha1
  
  /// The SHA256 hash function.
  case sha256
  
  /// The SHA512 hash function.
  case sha512
}
