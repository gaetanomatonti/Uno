//
//  Secret.swift
//  Uno
//
//  Created by Gaetano Matonti on 28/08/21.
//

import Foundation

/// An object containing information for a one-time password hash secret.
public struct Secret {
  
  // MARK: - Stored Properties
  
  /// The bytes of the secret.
  let data: Data
  
  // MARK: - Init
  
  /// Creates an instance of `Secret` from an ASCII encoded String.
  /// - Parameter ascii: The ASCII encoded String.
  init(ascii string: String) throws {
    guard let data = string.data(using: .ascii) else {
      throw Error.asciiConversionToDataFailed
    }
    
    self.data = data
  }
}

// MARK: - Errors

public extension Secret {
  /// The possible errors regarding a `Secret`.
  enum Error: Swift.Error, LocalizedError {
    /// The conversion from ASCII to data bytes failed.
    case asciiConversionToDataFailed
    
    public var errorDescription: String? {
      switch self {
        case .asciiConversionToDataFailed:
          return "The conversion from ASCII to data bytes failed."
      }
    }
  }
}
