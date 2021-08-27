#if canImport(CryptoKit)
import CryptoKit
#else
import Crypto
#endif

import Foundation

extension MessageAuthenticationCode {
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
  
  var trimmedDecimals: UInt64 {
    let trimmedHash = dynamicallyTrimmedHash.hexString(enablePadding: true)
    return UInt64(trimmedHash, radix: 16) ?? 0
  }
  
  /// An hexadecimal representation of the code.
  var hexString: String {
    Data(self).hexString()
  }
  
  func dynamicallyTrimmed(digitsCount: Int) -> String {
    let decimalPosition = UInt64(pow(10, Double(digitsCount)))
    let code = trimmedDecimals % decimalPosition
    
    return String.formatCode(code: code, numberOfDigits: digitsCount)
  }
}
