//
//  Overflow.swift
//  Flex
//
//  Created by Marc Bauer on 14.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

import Foundation
import Yoga

extension FlexLayout.Overflow: RawRepresentable {
  public var rawValue: UInt32 {
    switch self {
      case .visible:
        return YGOverflowVisible.rawValue
      case .hidden:
        return YGOverflowHidden.rawValue
      case .scroll:
        return YGOverflowScroll.rawValue
    }
  }

  public init?(rawValue: UInt32) {
    switch rawValue {
      case YGOverflowVisible.rawValue:
        self = .visible
      case YGOverflowHidden.rawValue:
        self = .hidden
      case YGOverflowScroll.rawValue:
        self = .scroll
      default:
        return nil
    }
  }
}
