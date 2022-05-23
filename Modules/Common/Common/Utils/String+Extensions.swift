//
//  String+Extensions.swift
//  Common
//
//  Created by Enygma System on 23/05/22.
//

import Foundation

public extension String {
  func localized(identifier: String) -> String {
    let bundle = Bundle(identifier: identifier) ?? .main
    return bundle.localizedString(forKey: self, value: nil, table: nil)
  }
}
