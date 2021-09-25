//
//  Uno
//
//  Created by Gaetano Matonti on 06/09/21.
//

import Foundation

extension URLQueryItem {
  /// Creates an instance of `URLQueryItem`.
  /// - Parameters:
  ///   - key: The `URIParser.ItemKey` representing the name of the query item.
  ///   - value: The value of the query item.
  init(_ key: URIParser.ItemKey, value: String?) {
    self.init(name: key.rawValue, value: value)
  }
}

extension Array where Element == URLQueryItem {
  
  // MARK: - Computed Properties
  
  var sorted: Self {
    sorted(by: { $0.name < $1.name })
  }
  
  // MARK: - Functions
  
  /// Accesses the value of the `URLQueryItem` for the specified `URIParser.ItemKey`.
  /// - Parameter key: The `URIParser.ItemKey` representing the name of the `URLQueryItem`.
  /// - Returns: An optional `String` representing the value of the query item. `nil` if a value couldn't be found for the specified key.
  subscript(_ key: URIParser.ItemKey) -> String? {
    value(for: key)
  }
  
  /// Gets the value of a `URLQueryItem` from its key.
  /// - Parameter key: The `ItemKey`  representing the name of the query item.
  /// - Returns: An optional `String` representing the value of the query item. `nil` if a value couldn't be found for the specified key.
  func value(for key: URIParser.ItemKey) -> String? {
    first {
      $0.name == key.rawValue
    }?.value
  }
}
