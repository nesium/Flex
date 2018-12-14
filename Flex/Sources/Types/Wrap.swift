//
//  Wrap.swift
//  Flex
//
//  Created by Marc Bauer on 14.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

import Foundation
import Yoga

extension FlexLayout.Wrap: RawRepresentable {
  public var rawValue: UInt32 {
    switch self {
      case .noWrap:
        return YGWrapNoWrap.rawValue
      case .wrap:
        return YGWrapWrap.rawValue
      case .wrapReverse:
        return YGWrapWrapReverse.rawValue
    }
  }

  public init?(rawValue: UInt32) {
    switch rawValue {
      case YGWrapNoWrap.rawValue:
        self = .noWrap
      case YGWrapWrap.rawValue:
        self = .wrap
      case YGWrapWrapReverse.rawValue:
        self = .wrapReverse
      default:
        return nil
    }
  }
}
