import Foundation

extension String {
  static func formatCode(code: UInt64, numberOfDigits: Int) -> String {
    let digitFormat = "0\(numberOfDigits)"
    return String(format: "%\(digitFormat)d", code)
  }
}
