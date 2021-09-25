//
//  Uno
//
//  Created by Gaetano Matonti on 05/09/21.
//

import Foundation

public extension OneTimePassword {
  /// An object containing the information necessary to generate an OTP to authenticate to a service.
  struct Metadata: Identifiable {
    /// The identifier of the `Metadata` object.
    public let id = UUID()
    
    /// The issuer of the service authenticated through the OTP.
    public let issuer: String?
    
    /// The account secured with the OTP authentication.
    public let account: String?
    
    /// The secret to seed into the generator.
    public let secret: Secret
    
    /// The amount of digits composing the authentication code.
    public let codeLength: Length
    
    /// The hash function used to generate the authentication code's hash.
    public let algorithm: Algorithm
    
    /// The kind of One Time Password.
    public let kind: Kind
    
    // MARK: - Computed Properties
    
    var uri: URL? {
      var components = URLComponents()
      components.scheme = URIParser.scheme
      components.host = kind.key.rawValue
      
      let label = [issuer, account].compactMap { $0 }.joined(separator: ":")
      components.path = label.isEmpty ? "" : ("/" + label)
      
      components.queryItems = [
        URLQueryItem(.algorithm, value: algorithm.rawValue),
        URLQueryItem(.digits, value: codeLength.rawValue.description),
        URLQueryItem(.secret, value: secret.string)
      ]
      
      if let issuer = issuer {
        components.queryItems?.append(URLQueryItem(.issuer, value: issuer))
      }
      
      if let period = kind.period {
        components.queryItems?.append(URLQueryItem(.period, value: Int(period).description))
      }
      
      if let counter = kind.counter {
        components.queryItems?.append(URLQueryItem(.counter, value: counter.description))
      }
      
      return components.url
    }
    
    // MARK: - Init
    
    /// Creates an instance of the `Metadata` object.
    /// - Parameters:
    ///   - secret: The secret to seed into the generator.
    ///   - codeLength: The amount of digits composing the authentication code.
    ///   - algorithm: The hash function used to generate the authentication code's hash.
    ///   - kind: The kind of One Time Password.
    public init(
      issuer: String? = nil,
      account: String? = nil,
      secret: Secret,
      codeLength: Length,
      algorithm: Algorithm,
      kind: Kind
    ) {
      self.issuer = issuer
      self.account = account
      self.secret = secret
      self.codeLength = codeLength
      self.algorithm = algorithm
      self.kind = kind
    }
    
    /// Creates an instance of the `Metadata` object from a `otpauth` URI.
    /// - Parameter uri: The `String` of the `otpauth` URI.
    public init(uri: String) throws {
      let parser = try URIParser(uri: uri)
      
      issuer = parser.issuer
      account = parser.account
      secret = parser.secret
      codeLength = parser.codeLength
      algorithm = parser.algorithm
      kind = parser.kind
    }
  }
}
