//
//  Uno
//
//  Created by Gaetano Matonti on 06/09/21.
//

import Foundation

public extension OneTimePassword {
  /// The possible OTP codes length expressed in digits.
  enum Length {
    /// A six digits code.
    case six
    
    /// A seven digits code.
    case seven
    
    /// A eight digits code.
    case eight
    
    // MARK: - Computed Properties
    
    /// The value representing the number of digits of the OTP code.
    var rawValue: Int {
      switch self {
        case .six:
          return 6
          
        case .seven:
          return 7
          
        case .eight:
          return 8
      }
    }
  }
}

// MARK: - Helpers

extension OneTimePassword.Length {
  /// Gets the `Length` of an OTP from its integer value.
  /// - Parameter value: The `Int` value of the OTP's length in digits.
  /// - Returns: The `Length` representing the number of digits forming the OTP code.
  public static func from(_ rawValue: Int) throws -> OneTimePassword.Length {
    switch rawValue {
      case 6:
        return .six
        
      case 7:
        return .seven
        
      case 8:
        return .eight
        
      case 9...12:
        throw Error.codeLengthNotSupported
        
      default:
        throw Error.invalidCodeLength
    }
  }
}

// MARK: - Errors

public extension OneTimePassword.Length {
  /// The possible errors of `Length`.
  enum Error: Swift.Error, LocalizedError {
    /// The code length is not supported.
    case codeLengthNotSupported
    
    /// The code length is not valid and does not meet the specifications' requirements.
    case invalidCodeLength
    
    public var errorDescription: String? {
      switch self {
        case .codeLengthNotSupported:
          return "The code length is not supported."
          
        case .invalidCodeLength:
          return "The code length is not valid and does not meet the specifications' requirements."
      }
    }
  }
}
