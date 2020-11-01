//
//  Position.swift
//  Flex
//
//  Created by Marc Bauer on 13.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

import Foundation
import Yoga

extension FlexLayout.Position: RawRepresentable {
  public var rawValue: UInt32 {
    switch self {
      case .absolute:
        return YGPositionTypeAbsolute.rawValue
      case .relative:
        return YGPositionTypeRelative.rawValue
      case .static:
        return YGPositionTypeStatic.rawValue
    }
  }

  public init?(rawValue: UInt32) {
    switch rawValue {
      case YGPositionTypeAbsolute.rawValue:
        self = .absolute
      case YGPositionTypeRelative.rawValue:
        self = .relative
      case YGPositionTypeStatic.rawValue:
        self = .static
      default:
        return nil
    }
  }
}
