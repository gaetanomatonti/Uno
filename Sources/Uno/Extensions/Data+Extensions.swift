import Foundation

public extension Data {
  /// An hexadecimal representation of the packet.
  func hexString(enablePadding: Bool = true) -> String {
    let hexDigitFormat = enablePadding ? "02" : ""
    return map { String(format: "%\(hexDigitFormat)hhx", $0) }.joined()
  }
}
