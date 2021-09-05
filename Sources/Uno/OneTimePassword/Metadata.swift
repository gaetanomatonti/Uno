//
//  Uno
//
//  Created by Gaetano Matonti on 05/09/21.
//

public extension OneTimePassword {
  /// An object containing the information necessary to generate an OTP to authenticate to a service.
  struct Metadata {    
    /// The secret to seed into the generator.
    let secret: Secret
    
    /// The amount of digits composing the authentication code.
    let codeLength: Int
    
    /// The hash function used to generate the authentication code's hash.
    let algorithm: Algorithm
    
    /// The kind of One Time Password.
    let kind: Kind
    
    // MARK: - Init
    
    /// Creates an instance of the `Metadata` object
    /// - Parameters:
    ///   - secret: The secret to seed into the generator.
    ///   - codeLength: The amount of digits composing the authentication code.
    ///   - algorithm: The hash function used to generate the authentication code's hash.
    ///   - kind: The kind of One Time Password.
    public init(secret: Secret, codeLength: Int, algorithm: Algorithm, kind: Kind) {
      self.secret = secret
      self.codeLength = codeLength
      self.algorithm = algorithm
      self.kind = kind
    }
  }
}
