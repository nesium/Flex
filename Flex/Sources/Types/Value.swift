//
//  Value.swift
//  Flex
//
//  Created by Marc Bauer on 13.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

import CoreGraphics
import Foundation
import Yoga

extension FlexLayout.Value: ExpressibleByFloatLiteral {
  public typealias FloatLiteralType = Double

  public init(floatLiteral value: Double) {
    self = .point(CGFloat(value))
  }
}

extension FlexLayout.Value: ExpressibleByIntegerLiteral {
  public typealias IntergerLiteralType = Int

  public init(integerLiteral value: Int) {
    self = .point(CGFloat(value))
  }
}


extension FlexLayout.Value {
  internal init?(value: YGValue) {
    switch value.unit.rawValue {
      case YGUnitPoint.rawValue:
        self = .point(CGFloat(value.value))
      case YGUnitPercent.rawValue:
        self = .percent(CGFloat(value.value))
      case YGUnitUndefined.rawValue:
        fallthrough
      default:
        return nil
    }
  }
}

extension FlexLayout.Value: Equatable {
  public static func ==(lhs: FlexLayout.Value, rhs: FlexLayout.Value) -> Bool {
    switch (lhs, rhs) {
      case let (.point(l), .point(r)):
        return l == r
      case let (.percent(l), .percent(r)):
        return l == r
      case (.point, _), (.percent, _):
        return false
    }
  }
}

postfix operator %
prefix operator -

public postfix func %(value: CGFloat) -> FlexLayout.Value {
  return .percent(value)
}

public postfix func %(value: Int) -> FlexLayout.Value {
  return .percent(CGFloat(value))
}

public prefix func -(value: FlexLayout.Value) -> FlexLayout.Value {
  switch value {
    case let .percent(percent):
      return .percent(-percent)
    case let .point(point):
      return .point(-point)
  }
}
