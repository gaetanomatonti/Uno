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
}
