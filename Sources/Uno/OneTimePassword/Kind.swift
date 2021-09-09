//
//  Uno
//
//  Created by Gaetano Matonti on 05/09/21.
//

import Foundation

public extension OneTimePassword {
  /// The supported types of One Time Passwords.
  enum Kind {
    /// An OTP generated from a counter-based generator (HOTP).
    case counterBased(counter: UInt64)
    
    /// An OTP generated from a time-based generator (TOTP).
    case timeBased(timestep: TimeInterval)
  }
}
