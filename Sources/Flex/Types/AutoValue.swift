//
//  AutoValue.swift
//  Flex
//
//  Created by Marc Bauer on 13.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

import CoreGraphics
import Foundation
import Yoga

extension FlexLayout.AutoValue: ExpressibleByFloatLiteral {
  public typealias FloatLiteralType = Double

  public init(floatLiteral value: Double) {
    self = .point(CGFloat(value))
  }
}

extension FlexLayout.AutoValue: ExpressibleByIntegerLiteral {
  public typealias IntegerLiteralType = Int

  public init(integerLiteral value: Int) {
    self = .point(CGFloat(value))
  }
}


extension FlexLayout.AutoValue {
  internal init?(value: YGValue) {
    switch value.unit.rawValue {
      case YGUnitPoint.rawValue:
        self = .point(CGFloat(value.value))
      case YGUnitPercent.rawValue:
        self = .percent(CGFloat(value.value))
      case YGUnitAuto.rawValue:
        self = .auto
      case YGUnitUndefined.rawValue:
        fallthrough
      default:
        return nil
    }
  }
}

extension FlexLayout.AutoValue: Equatable {
  public static func ==(lhs: FlexLayout.AutoValue, rhs: FlexLayout.AutoValue) -> Bool {
    switch (lhs, rhs) {
      case let (.point(l), .point(r)):
        return l == r
      case let (.percent(l), .percent(r)):
        return l == r
      case (.auto, .auto):
        return true
      case (.point, _), (.percent, _), (.auto, _):
        return false
    }
  }
}

postfix operator %
prefix operator -

public postfix func %(value: CGFloat) -> FlexLayout.AutoValue {
  return .percent(value)
}

public postfix func %(value: Int) -> FlexLayout.AutoValue {
  return .percent(CGFloat(value))
}

public prefix func -(value: FlexLayout.AutoValue) -> FlexLayout.AutoValue {
  switch value {
    case .auto:
      return value
    case let .percent(percent):
      return .percent(-percent)
    case let .point(point):
      return .point(-point)
  }
}
