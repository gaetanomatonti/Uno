import Foundation

public extension Data {
  /// An hexadecimal representation of the bytes.
  /// - Parameter forcingZeroPadding: Whether or not leading zeroes should be added to the string.
  /// - Returns: A `String` representing the bytes sequence in hexadecimal format.
  func hexString(forcingZeroPadding shouldForcePadding: Bool = true) -> String {
    let hexDigitFormat = shouldForcePadding ? "02" : ""
    return map { String(format: "%\(hexDigitFormat)hhx", $0) }.joined()
  }
}
