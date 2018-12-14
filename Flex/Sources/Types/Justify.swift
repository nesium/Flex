//
//  Justify.swift
//  Flex
//
//  Created by Marc Bauer on 13.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

import Foundation
import Yoga

extension FlexLayout.Justify: RawRepresentable {
  public var rawValue: UInt32 {
    switch self {
      case .start:
        return YGJustifyFlexStart.rawValue
      case .center:
        return YGJustifyCenter.rawValue
      case .end:
        return YGJustifyFlexEnd.rawValue
      case .spaceBetween:
        return YGJustifySpaceBetween.rawValue
      case .spaceAround:
        return YGJustifySpaceAround.rawValue
      case .spaceEvenly:
        return YGJustifySpaceEvenly.rawValue
    }
  }

  public init?(rawValue: UInt32) {
    switch rawValue {
      case YGJustifyFlexStart.rawValue:
        self = .start
      case YGJustifyCenter.rawValue:
        self = .center
      case YGJustifyFlexEnd.rawValue:
        self = .end
      case YGJustifySpaceBetween.rawValue:
        self = .spaceBetween
      case YGJustifySpaceAround.rawValue:
        self = .spaceAround
      case YGJustifySpaceEvenly.rawValue:
        self = .spaceEvenly
      default:
        return nil
    }
  }
}
