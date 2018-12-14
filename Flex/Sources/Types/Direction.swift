//
//  Direction.swift
//  Flex
//
//  Created by Marc Bauer on 13.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

import Foundation
import Yoga

extension FlexLayout.Direction: RawRepresentable {
  public var rawValue: UInt32 {
    switch self {
      case .column:
        return YGFlexDirectionColumn.rawValue
      case .columnReverse:
        return YGFlexDirectionColumnReverse.rawValue
      case .row:
        return YGFlexDirectionRow.rawValue
      case .rowReverse:
        return YGFlexDirectionRowReverse.rawValue
    }
  }

  public init?(rawValue: UInt32) {
    switch rawValue {
      case YGFlexDirectionColumn.rawValue:
        self = .column
      case YGFlexDirectionColumnReverse.rawValue:
        self = .columnReverse
      case YGFlexDirectionRow.rawValue:
        self = .row
      case YGFlexDirectionRowReverse.rawValue:
        self = .rowReverse
      default:
        return nil
    }
  }
}
