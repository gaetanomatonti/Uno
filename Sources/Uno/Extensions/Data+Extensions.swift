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

extension String {
  private var alphabetTable: [UnicodeScalar: UInt8] {
    [
      "A": 0,
      "B": 1,
      "C": 2,
      "D": 3,
      "E": 4,
      "F": 5,
      "G": 6,
      "H": 7,
      "I": 8,
      "J": 9,
      "K": 10,
      "L": 11,
      "M": 12,
      "N": 13,
      "O": 14,
      "P": 15,
      "Q": 16,
      "R": 17,
      "S": 18,
      "T": 19,
      "U": 20,
      "V": 21,
      "W": 22,
      "X": 23,
      "Y": 24,
      "Z": 25,
      "2": 26,
      "3": 27,
      "4": 28,
      "5": 29,
      "6": 30,
      "7": 31
    ]
  }
  
  func base32Decoded() -> Data? {
    guard !isEmpty else {
      return Data()
    }
    
    let bytes = unicodeScalars.compactMap {
      alphabetTable[$0]
    }
    
    let binaryString = bytes.compactMap {
      String($0, radix: 2).paddedToMatch(length: 5, with: "0")
    }.joined()
    
    guard binaryString.count % 5 == 0 else {
      return nil
    }
    
    var octets = binaryString.groups(of: 8)
    
    let lastOctet = octets[octets.count - 1]
    let lastOctetByte = UInt8(lastOctet, radix: 2)
    
    if let lastOctetByte = lastOctetByte, lastOctetByte == 0 {
      octets.removeLast()
    }
    
    let octectBytes = octets.compactMap {
      UInt8($0, radix: 2)
    }
    
    return Data(octectBytes)
  }
}
