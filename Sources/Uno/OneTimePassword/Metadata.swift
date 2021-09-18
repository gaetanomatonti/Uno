//
//  Uno
//
//  Created by Gaetano Matonti on 05/09/21.
//

import Foundation

public extension OneTimePassword {
  /// An object containing the information necessary to generate an OTP to authenticate to a service.
  struct Metadata {    
    /// The secret to seed into the generator.
    public let secret: Secret
    
    /// The amount of digits composing the authentication code.
    public let codeLength: Length
    
    /// The hash function used to generate the authentication code's hash.
    public let algorithm: Algorithm
    
    /// The kind of One Time Password.
    public let kind: Kind
    
    // MARK: - Init
    
    /// Creates an instance of the `Metadata` object.
    /// - Parameters:
    ///   - secret: The secret to seed into the generator.
    ///   - codeLength: The amount of digits composing the authentication code.
    ///   - algorithm: The hash function used to generate the authentication code's hash.
    ///   - kind: The kind of One Time Password.
    public init(secret: Secret, codeLength: Length, algorithm: Algorithm, kind: Kind) {
      self.secret = secret
      self.codeLength = codeLength
      self.algorithm = algorithm
      self.kind = kind
    }
    
    /// Creates an instance of the `Metadata` object from a `otpauth` URI.
    /// - Parameter uri: The `String` of the `otpauth` URI.
    public init(uri: String) throws {
      let parser = try URIParser(uri: uri)
      
      secret = parser.secret
      codeLength = parser.codeLength
      algorithm = parser.algorithm
      kind = parser.kind
    }
  }
}
