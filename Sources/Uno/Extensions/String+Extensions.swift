//
//  Uno
//
//  Created by Gaetano Matonti on 27/08/21.
//

import Foundation

extension String {
  /// Creates a `String` representing a formatted one-time password code.
  /// - Parameters:
  ///   - code: The one-time password in unsigned integer format.
  ///   - numberOfDigits: The number of digits composing the one-time password.
  /// - Returns: A `String` representing the formatted one-time password.
  static func formatAuthenticationCode(_ code: UInt64, numberOfDigits: Int) -> String {
    let digitFormat = "0\(numberOfDigits)"
    return String(format: "%\(digitFormat)d", code)
  }
  
  /// Adds a leading padding to match the specified length.
  /// - Parameters:
  ///   - length: The length the resulting string should match.
  ///   - character: The character to use as padding.
  /// - Returns: A `String` with leading character padding.
  func paddedToMatch(length: Int, with character: Character) -> String {
    guard count < length else {
      return self
    }
    
    let paddingCharactersCount = length - count
    
    var result = self
    for _ in 0..<paddingCharactersCount {
      result.insert(character, at: result.startIndex)
    }
    
    return result
  }
  
  /// Groups a `String` in an array of substrings of the same length.
  /// - Parameter numberOfCharacters: The length of the substrings.
  /// - Returns: An array of `String`.
  func groups(of numberOfCharacters: Int) -> [String] {
    var groups: [String] = []
    
    let numberOfGroups = Int(ceil(Double(count) / Double(numberOfCharacters)))
    
    for groupIndex in 0..<numberOfGroups {
      let offsetStartIndex = index(startIndex, offsetBy: groupIndex * numberOfCharacters)
      let offsetEndIndex = index(offsetStartIndex, offsetBy: numberOfCharacters, limitedBy: endIndex)
      
      if let offsetEndIndex = offsetEndIndex {
        let range = offsetStartIndex..<offsetEndIndex
        let substring = String(self[range])
        groups.append(substring)
      } else {
        let substring = String(self[offsetStartIndex...])
        groups.append(substring)
      }
    }
    
    return groups
  }
}
