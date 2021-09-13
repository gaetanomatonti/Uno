//
//  Uno
//
//  Created by Gaetano Matonti on 05/09/21.
//

import Foundation

public extension OneTimePassword {
  /// The supported types of One Time Passwords.
  enum Kind {
    /// The key of the OTP type.
    enum Key: String {
      /// The key for the HOTP.
      case hotp
      
      /// The key for the TOTP.
      case totp
    }
    
    /// An OTP generated from a counter-based generator (HOTP).
    case counterBased(counter: UInt64)
    
    /// An OTP generated from a time-based generator (TOTP).
    case timeBased(timestep: TimeInterval)
  }
}

extension OneTimePassword.Kind: Equatable {
  public static func ==(lhs: OneTimePassword.Kind, rhs: OneTimePassword.Kind) -> Bool {
    switch (lhs, rhs) {
      case let (.counterBased(lhsCounter), .counterBased(rhsCounter)):
        return lhsCounter == rhsCounter
        
      case let (.timeBased(lhsTimestep), .timeBased(rhsTimestep)):
        return lhsTimestep == rhsTimestep
        
      case (_, _):
        return false
    }
  }
}
