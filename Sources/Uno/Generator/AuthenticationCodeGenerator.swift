//
//  Uno
//
//  Created by Gaetano Matonti on 28/08/21.
//

import Foundation

/// A protocol the represents the requirements for a one-time password generator.
public protocol AuthenticationCodeGenerator {
  /// The secret to seed into the generator.
  var secret: OneTimePassword.Secret { get }
  
  /// The amount of digits composing the authentication code.
  var codeLength: OneTimePassword.Length { get }
  
  /// The hash function used to generate the authentication code's hash.
  var algorithm: OneTimePassword.Algorithm { get }
}
