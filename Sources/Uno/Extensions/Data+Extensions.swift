//
//  Uno
//
//  Created by Gaetano Matonti on 27/08/21.
//

import Foundation

extension Data {
  
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

  /// An hexadecimal representation of the bytes.
  /// - Parameter forcingZeroPadding: Whether or not leading zeroes should be added to the string.
  /// - Returns: A `String` representing the bytes sequence in hexadecimal format.
  func hexString(forcingZeroPadding shouldForcePadding: Bool = true) -> String {
    let hexDigitFormat = shouldForcePadding ? "02" : ""
    return map { String(format: "%\(hexDigitFormat)hhx", $0) }.joined()
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
