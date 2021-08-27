#if canImport(CryptoKit)
import CryptoKit
#else
import Crypto
#endif

import Foundation

extension MessageAuthenticationCode {
  /// The dynamically trimmed hash in decimal format.
  var dynamicallyTrimmedDecimals: UInt64 {
    UInt64(dynamicallyTrimmedHexadecimals, radix: 16) ?? 0
  }
  
  /// The dynamically trimmed hash in hexadecimal format.
  var dynamicallyTrimmedHexadecimals: String {
    dynamicallyTrimmedHash.hexString(forcingZeroPadding: false)
  }

  /// The dynamically trimmed hash bytes.
  var dynamicallyTrimmedHash: Data {
    let data = Data(self)
    let lastByte = data.last ?? 0x00
    // Get the last 4 bit of the packet.
    let startIndex = Int(lastByte & 0x0f)
    // Get the end index needed for a 32 bit stride.
    let endIndex = startIndex + 3
    // Create a new `Data` object to prevent "offset index" errors.
    var trimmedPacket = Data(data[startIndex...endIndex])
    // Truncate the first bit (the packet should contain 31 bits).
    trimmedPacket[0] &= 0x7f
    return trimmedPacket
  }
  
  /// An hexadecimal representation of the code hash.
  var hexString: String {
    Data(self).hexString()
  }
      
  // MARK: - Functions
  
  /// Trims the authentication code using *dynamic truncation*.
  /// - Parameter numberOfDigits: The amount of digits the truncated authentication code should be composed of.
  /// - Returns: A `String` representing the truncated authentication code suitable for user authentication.
  func dynamicallyTrimmed(numberOfDigits: Int) -> String {
    let decimalPosition = UInt64(pow(10, Double(numberOfDigits)))
    let code = dynamicallyTrimmedDecimals % decimalPosition
    
    return String.formatAuthenticationCode(code, numberOfDigits: numberOfDigits)
  }
}
