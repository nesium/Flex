//
//  Align.swift
//  Flex
//
//  Created by Marc Bauer on 13.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

import Foundation
import Yoga

extension FlexLayout.Align: RawRepresentable {
  public var rawValue: UInt32 {
    switch self {
      case .auto:
        return YGAlignAuto.rawValue
      case .start:
        return YGAlignFlexStart.rawValue
      case .center:
        return YGAlignCenter.rawValue
      case .end:
        return YGAlignFlexEnd.rawValue
      case .stretch:
        return YGAlignStretch.rawValue
      case .baseline:
        return YGAlignBaseline.rawValue
      case .spaceBetween:
        return YGAlignSpaceBetween.rawValue
      case .spaceAround:
        return YGAlignSpaceAround.rawValue
    }
  }

  public init?(rawValue: UInt32) {
    switch rawValue {
      case YGAlignAuto.rawValue:
        self = .auto
      case YGAlignFlexStart.rawValue:
        self = .start
      case YGAlignCenter.rawValue:
        self = .center
      case YGAlignFlexEnd.rawValue:
        self = .end
      case YGAlignStretch.rawValue:
        self = .stretch
      case YGAlignBaseline.rawValue:
        self = .baseline
      case YGAlignSpaceBetween.rawValue:
        self = .spaceBetween
      case YGAlignSpaceAround.rawValue:
        self = .spaceAround
      default:
        return nil
    }
  }
}
