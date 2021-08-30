//
//  Uno
//
//  Created by Gaetano Matonti on 27/08/21.
//

import Foundation

extension Data {
  /// The hexadecimal representation of the dynamically trimmed.
  var dynamicallyTrimmedHexadecimals: String {
    String(dynamicallyTrimmedHash, radix: 16)
  }

  /// The dynamically trimmed hash.
  var dynamicallyTrimmedHash: UInt64 {
    let lastByte = last ?? 0x00
    // Get the last 4 bits of the packet.
    let offset = Int(lastByte & 0x0f)

    var hash: UInt64 = 0
    hash |= UInt64(self[offset] & 0x7f) << 24
    hash |= UInt64(self[offset + 1] & 0xff) << 16
    hash |= UInt64(self[offset + 2] & 0xff) << 8
    hash |= UInt64(self[offset + 3] & 0xff)
    return hash
  }
  
  /// The hexadecimal representation of the data payload.
  var hexString: String {
    hexadecimals.joined()
  }
  
  /// The array of the hexadecimal representation of the bytes.
  var hexadecimals: [String] {
    map { String(format: "%02hhx", $0) }
  }
  
  // MARK: - Init
  
  /// Creates a data buffer from a hexadecimal string.
  /// - Parameter string: The hexadecimal `String` representation of the buffer.
  init(hex string: String) throws {
    let expectedBytesCount = string.count / 2
    let regex = try NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
    
    let range = NSRange(string.startIndex..., in: string)
    let hexString = NSString(string: string)
    
    var bytes: [UInt8] = []
    regex.enumerateMatches(in: string, range: range) { result, _, _ in
      guard let result = result else {
        return
      }
      
      let substring = hexString.substring(with: result.range)
      
      guard let byte = UInt8(substring, radix: 16) else {
        return
      }
      
      bytes.append(byte)
    }
    
    guard bytes.count == expectedBytesCount else {
      throw Error.bytesCountMismatch
    }
    
    self.init(bytes)
  }
      
  // MARK: - Functions
  
  /// Trims the authentication code using *dynamic truncation*.
  /// - Parameter numberOfDigits: The amount of digits the truncated authentication code should be composed of.
  /// - Returns: A `String` representing the truncated authentication code suitable for user authentication.
  func dynamicallyTrimmed(numberOfDigits: Int) -> String {
    let decimalPosition = UInt64(pow(10, Double(numberOfDigits)))
    let code = dynamicallyTrimmedHash % decimalPosition
    
    return String.formatAuthenticationCode(code, numberOfDigits: numberOfDigits)
  }
}

// MARK: - Errors

extension Data {
  /// The possible errors regarding the `Data` type.
  enum Error: Swift.Error {
    /// The count of the converted bytes doesn't match the expected byte count.
    case bytesCountMismatch
  }
}
