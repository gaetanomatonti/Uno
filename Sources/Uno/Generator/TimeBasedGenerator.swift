//
//  Uno
//
//  Created by Gaetano Matonti on 28/08/21.
//

#if canImport(CryptoKit)
import CryptoKit
#else
import Crypto
#endif

import Foundation

/// A type that represents a Time-based one-time password.
public struct TimeBasedGenerator: AuthenticationCodeGenerator {

  // MARK: - Stored Properties
  
  public let secret: OneTimePassword.Secret
  
  public let codeLength: OneTimePassword.Length
  
  public let algorithm: OneTimePassword.Algorithm
  
  /// The period of validity of the authentication code expressed in seconds.
  public let timestep: TimeInterval
  
  /// The underlying code-based generator to generate an HOTP.
  private let counterBasedGenerator: CounterBasedGenerator
  
  // MARK: - Init
  
  public init(
    secret: OneTimePassword.Secret,
    codeLength: OneTimePassword.Length = .six,
    algorithm: OneTimePassword.Algorithm = .sha1,
    timestep: TimeInterval
  ) {
    self.secret = secret
    self.codeLength = codeLength
    self.algorithm = algorithm
    self.timestep = timestep
    self.counterBasedGenerator = CounterBasedGenerator(secret: secret, codeLength: codeLength, algorithm: algorithm)
  }
}

// MARK: - Functions

extension TimeBasedGenerator {
  /// Generates a time-based OTP from the seconds interval.
  /// - Parameter time: The `Date` representing the time to use for generation.
  /// - Returns: A `String` representing the generated one-time password.
  public func generate(from time: Date) throws -> String {
    try generate(from: time.timeIntervalSince1970)
  }
  
  /// Generates a time-based OTP from the seconds interval.
  /// - Parameter secondsSince1970: The Unix epoch to use for generation.
  /// - Returns: A `String` representing the generated one-time password.
  public func generate(from secondsSince1970: TimeInterval) throws -> String {
    guard secondsSince1970 >= 0 else {
      throw Error.invalidTime
    }
    
    let counterFromSeconds = try counter(from: secondsSince1970)
    return try counterBasedGenerator.generate(from: counterFromSeconds)
  }
  
  /// Computes the counter factor from the seconds interval.
  /// - Parameter secondsSince1970: The Unix epoch to use for generation.
  /// - Returns: A `UInt64` representing the counter factor for HOTP generation.
  func counter(from secondsSince1970: TimeInterval) throws -> UInt64 {
    guard timestep >= 0 else {
      throw Error.invalidTimestep
    }
    
    // Round down and remove the fractional part.
    let secondsSince1970 = floor(secondsSince1970)
    let counter = floor(secondsSince1970 / timestep)
    return UInt64(counter)
  }
}

// MARK: - Errors

public extension TimeBasedGenerator {
  /// The possible errors thrown in the `TimeBasedGenerator`.
  enum Error: Swift.Error, LocalizedError {
    /// The provided timestep for OTP generation is not valid.
    case invalidTimestep
    
    /// The time for counter computation is invalid.
    case invalidTime
    
    public var errorDescription: String? {
      switch self {
        case .invalidTimestep:
          return "The provided timestep for OTP generation is not valid."
          
        case .invalidTime:
          return "The time for counter computation is invalid."
      }
    }
  }
}
