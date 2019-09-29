//
//  Display.swift
//  Flex
//
//  Created by Marc Bauer on 14.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

import Foundation
import Yoga

extension FlexLayout.Display: RawRepresentable {
  public var rawValue: UInt32 {
    switch self {
      case .flex:
        return YGDisplayFlex.rawValue
      case .none:
        return YGDisplayNone.rawValue
    }
  }

  public init?(rawValue: UInt32) {
    switch rawValue {
      case YGDisplayFlex.rawValue:
        self = .flex
      case YGDisplayNone.rawValue:
        self = .none
      default:
        return nil
    }
  }
}
