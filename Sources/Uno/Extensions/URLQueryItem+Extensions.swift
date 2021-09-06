//
//  Uno
//
//  Created by Gaetano Matonti on 06/09/21.
//

import Foundation

extension Array where Element == URLQueryItem {
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
