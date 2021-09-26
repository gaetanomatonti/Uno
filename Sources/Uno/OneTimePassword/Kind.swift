//
//  Uno
//
//  Created by Gaetano Matonti on 05/09/21.
//

import Foundation

extension OneTimePassword {
  /// The supported types of One Time Passwords.
  public enum Kind {
    /// The key of the OTP type.
    public enum Key: String {
      /// The key for the HOTP.
      case hotp
      
      /// The key for the TOTP.
      case totp
    }
    
    /// An OTP generated from a counter-based generator (HOTP).
    case counterBased(counter: UInt64)
    
    /// An OTP generated from a time-based generator (TOTP).
    case timeBased(timestep: TimeInterval)
    
    // MARK: - Constants
    
    /// The default counter value for counter-based generators.
    public static let defaultCounter: UInt64 = 0
    
    /// The default kind for counter-based generators.
    public static let defaultCounterBased: Self = .counterBased(counter: defaultCounter)
    
    /// The default timestep value for time-based generators.
    public static let defaultTimestep: TimeInterval = 30
    
    /// The default kind for time-based generators.
    public static let defaultTimeBased: Self = .timeBased(timestep: defaultTimestep)
    
    // MARK: - Computed Properties
    
    /// The key of the OTP kind.
    public var key: Key {
      switch self {
        case .counterBased:
          return .hotp
          
        case .timeBased:
          return .totp
      }
    }
    
    /// The value of the counter. `nil` if the kind is not `.counterBased`.
    public var counter: UInt64? {
      if case let .counterBased(counter) = self {
        return counter
      }
      
      return nil
    }
    
    /// The value of the timestep. `nil` if the kind is not `.timeBased`.
    public var timestep: TimeInterval? {
      if case let .timeBased(timestep) = self {
        return timestep
      }
      
      return nil
    }
  }
}

// MARK: - Helper Functions

extension OneTimePassword.Kind {
  /// Creates an instance of `Kind` from a raw string, timestep and counter parameters.
  /// - Parameters:
  ///   - string: The raw string representing the `Kind.Key`.
  ///   - timestep: The timestep for the time-based generator. `nil` if the kind should not be time based.
  ///   - counter: The counter for the counter-based generator. `nil` if the kind should not be counter based.
  /// - Returns: The `Kind` of the generator.
  public static func from(_ string: String, timestep: TimeInterval? = nil, counter: UInt64? = nil) throws -> OneTimePassword.Kind {
    guard let key = Key(rawValue: string) else {
      throw Error.invalidKey
    }
    
    switch key {
      case .hotp:
        guard let counter = counter else {
          throw Error.missingCounter
        }
        
        return .counterBased(counter: counter)
        
      case .totp:
        guard let timestep = timestep else {
          throw Error.missingTimestep
        }
        
        return .timeBased(timestep: timestep)
    }
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

// MARK: - Error

extension OneTimePassword.Kind {
  /// The possible errors for the `Kind` type.
  enum Error: Swift.Error {
    /// The provideded kind key is invalid.
    case invalidKey
    
    /// The counter is missing for the counter-based kind.
    case missingCounter
    
    /// The timestep is missing for the time-based kind.
    case missingTimestep
  }
}
