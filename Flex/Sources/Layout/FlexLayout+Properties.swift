//
//  FlexLayout+Properties.swift
//  Flex
//
//  Created by Marc Bauer on 13.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

import Foundation
import Yoga

extension FlexLayout {
  public var direction: Direction {
    set { YGNodeStyleSetFlexDirection(self.node, YGFlexDirection(newValue.rawValue)) }
    get { return Direction(rawValue: YGNodeStyleGetFlexDirection(self.node).rawValue)! }
  }

  public var justifyContent: Justify {
    set { YGNodeStyleSetJustifyContent(self.node, YGJustify(newValue.rawValue)) }
    get { return Justify(rawValue: YGNodeStyleGetJustifyContent(self.node).rawValue)! }
  }

  public var alignContent: Align {
    set { YGNodeStyleSetAlignContent(self.node, YGAlign(newValue.rawValue)) }
    get { return Align(rawValue: YGNodeStyleGetAlignContent(self.node).rawValue)! }
  }

  public var alignItems: Align {
    set { YGNodeStyleSetAlignItems(self.node, YGAlign(newValue.rawValue)) }
    get { return Align(rawValue: YGNodeStyleGetAlignItems(self.node).rawValue)! }
  }

  public var alignSelf: Align {
    set { YGNodeStyleSetAlignSelf(self.node, YGAlign(newValue.rawValue)) }
    get { return Align(rawValue: YGNodeStyleGetAlignSelf(self.node).rawValue)! }
  }

  public var position: Position {
    set { YGNodeStyleSetPositionType(self.node, YGPositionType(newValue.rawValue)) }
    get { return Position(rawValue: YGNodeStyleGetPositionType(self.node).rawValue)! }
  }

  public var wrap: Wrap {
    set { YGNodeStyleSetFlexWrap(self.node, YGWrap(newValue.rawValue)) }
    get { return Wrap(rawValue: YGNodeStyleGetFlexWrap(self.node).rawValue)! }
  }

  public var overflow: Overflow {
    set { YGNodeStyleSetOverflow(self.node, YGOverflow(newValue.rawValue)) }
    get { return Overflow(rawValue: YGNodeStyleGetOverflow(self.node).rawValue)! }
  }

  public var display: Display {
    set { YGNodeStyleSetDisplay(self.node, YGDisplay(newValue.rawValue)) }
    get { return Display(rawValue: YGNodeStyleGetDisplay(self.node).rawValue)! }
  }

  public var grow: CGFloat {
    set { YGNodeStyleSetFlexGrow(self.node, Float(newValue)) }
    get { return CGFloat(YGNodeStyleGetFlexGrow(self.node)) }
  }

  public var shrink: CGFloat {
    set { YGNodeStyleSetFlexShrink(self.node, Float(newValue)) }
    get { return CGFloat(YGNodeStyleGetFlexShrink(self.node)) }
  }

  public var basis: AutoValue {
    set {
      switch newValue {
        case .auto:
          YGNodeStyleSetFlexBasisAuto(self.node)
        case let .percent(percent):
          YGNodeStyleSetFlexBasisPercent(self.node, Float(percent))
        case let .point(point):
          YGNodeStyleSetFlexBasis(self.node, Float(point))
      }
    }
    get {
      return AutoValue(value: YGNodeStyleGetFlexBasis(self.node))!
    }
  }

  public var top: Value? {
    set { self.setPosition(newValue, at: YGEdgeTop) }
    get { return self.position(at: YGEdgeTop) }
  }

  public var left: Value? {
    set { self.setPosition(newValue, at: YGEdgeLeft) }
    get { return self.position(at: YGEdgeLeft) }
  }

  public var bottom: Value? {
    set { self.setPosition(newValue, at: YGEdgeBottom) }
    get { return self.position(at: YGEdgeBottom) }
  }

  public var right: Value? {
    set { self.setPosition(newValue, at: YGEdgeRight) }
    get { return self.position(at: YGEdgeRight) }
  }

  public var start: Value? {
    set { self.setPosition(newValue, at: YGEdgeStart) }
    get { return self.position(at: YGEdgeStart) }
  }

  public var end: Value? {
    set { self.setPosition(newValue, at: YGEdgeEnd) }
    get { return self.position(at: YGEdgeEnd) }
  }

  public var marginTop: AutoValue? {
    set { self.setMargin(newValue, at: YGEdgeTop) }
    get { return self.margin(at: YGEdgeTop) }
  }

  public var marginLeft: AutoValue? {
    set { self.setMargin(newValue, at: YGEdgeLeft) }
    get { return self.margin(at: YGEdgeLeft) }
  }

  public var marginBottom: AutoValue? {
    set { self.setMargin(newValue, at: YGEdgeBottom) }
    get { return self.margin(at: YGEdgeBottom) }
  }

  public var marginRight: AutoValue? {
    set { self.setMargin(newValue, at: YGEdgeRight) }
    get { return self.margin(at: YGEdgeRight) }
  }

  public var marginStart: AutoValue? {
    set { self.setMargin(newValue, at: YGEdgeStart) }
    get { return self.margin(at: YGEdgeStart) }
  }

  public var marginEnd: AutoValue? {
    set { self.setMargin(newValue, at: YGEdgeEnd) }
    get { return self.margin(at: YGEdgeEnd) }
  }

  public var marginHorizontal: AutoValue? {
    set { self.setMargin(newValue, at: YGEdgeHorizontal) }
    get { return self.margin(at: YGEdgeHorizontal) }
  }

  public var marginVertical: AutoValue? {
    set { self.setMargin(newValue, at: YGEdgeVertical) }
    get { return self.margin(at: YGEdgeVertical) }
  }

  public var margin: Margin {
    set {
      self.marginTop = newValue.0
      self.marginLeft = newValue.1
      self.marginBottom = newValue.2
      self.marginRight = newValue.3
    }
    get { return (self.marginTop, self.marginLeft, self.marginBottom, self.marginRight) }
  }

  public var paddingTop: Value? {
    set { self.setPadding(newValue, at: YGEdgeTop) }
    get { return self.padding(at: YGEdgeTop) }
  }

  public var paddingLeft: Value? {
    set { self.setPadding(newValue, at: YGEdgeLeft) }
    get { return self.padding(at: YGEdgeLeft) }
  }

  public var paddingBottom: Value? {
    set { self.setPadding(newValue, at: YGEdgeBottom) }
    get { return self.padding(at: YGEdgeBottom) }
  }

  public var paddingRight: Value? {
    set { self.setPadding(newValue, at: YGEdgeRight) }
    get { return self.padding(at: YGEdgeRight) }
  }

  public var paddingStart: Value? {
    set { self.setPadding(newValue, at: YGEdgeStart) }
    get { return self.padding(at: YGEdgeStart) }
  }

  public var paddingEnd: Value? {
    set { self.setPadding(newValue, at: YGEdgeEnd) }
    get { return self.padding(at: YGEdgeEnd) }
  }

  public var paddingHorizontal: Value? {
    set { self.setPadding(newValue, at: YGEdgeHorizontal) }
    get { return self.padding(at: YGEdgeHorizontal) }
  }

  public var paddingVertical: Value? {
    set { self.setPadding(newValue, at: YGEdgeVertical) }
    get { return self.padding(at: YGEdgeVertical) }
  }

  public var borderWidthTop: CGFloat? {
    set { self.setBorderWidth(newValue, at: YGEdgeTop) }
    get { return self.borderWidth(at: YGEdgeTop) }
  }

  public var borderWidthLeft: CGFloat? {
    set { self.setBorderWidth(newValue, at: YGEdgeLeft) }
    get { return self.borderWidth(at: YGEdgeLeft) }
  }

  public var borderWidthBottom: CGFloat? {
    set { self.setBorderWidth(newValue, at: YGEdgeBottom) }
    get { return self.borderWidth(at: YGEdgeBottom) }
  }

  public var borderWidthRight: CGFloat? {
    set { self.setBorderWidth(newValue, at: YGEdgeRight) }
    get { return self.borderWidth(at: YGEdgeRight) }
  }

  public var borderWidthStart: CGFloat? {
    set { self.setBorderWidth(newValue, at: YGEdgeStart) }
    get { return self.borderWidth(at: YGEdgeStart) }
  }

  public var borderWidthEnd: CGFloat? {
    set { self.setBorderWidth(newValue, at: YGEdgeEnd) }
    get { return self.borderWidth(at: YGEdgeEnd) }
  }

  public var width: AutoValue {
    set {
      switch newValue {
        case .auto:
          YGNodeStyleSetWidthAuto(self.node)
        case let .percent(percent):
          YGNodeStyleSetWidthPercent(self.node, Float(percent))
        case let .point(point):
          YGNodeStyleSetWidth(self.node, Float(point))
      }
    }
    get {
      return AutoValue(value: YGNodeStyleGetWidth(self.node))!
    }
  }

  public var height: AutoValue {
    set {
      switch newValue {
        case .auto:
          YGNodeStyleSetHeightAuto(self.node)
        case let .percent(percent):
          YGNodeStyleSetHeightPercent(self.node, Float(percent))
        case let .point(point):
          YGNodeStyleSetHeight(self.node, Float(point))
      }
    }
    get {
      return AutoValue(value: YGNodeStyleGetHeight(self.node))!
    }
  }

  public var minWidth: Value? {
    set {
      switch newValue {
        case .none:
          YGNodeStyleSetMinWidth(self.node, YGValueUndefined.value)
        case let .some(.percent(percent)):
          YGNodeStyleSetMinWidthPercent(self.node, Float(percent))
        case let .some(.point(point)):
          YGNodeStyleSetMinWidth(self.node, Float(point))
      }
    }
    get {
      return Value(value: YGNodeStyleGetMinWidth(self.node))
    }
  }

  public var minHeight: Value? {
    set {
      switch newValue {
        case .none:
          YGNodeStyleSetMinHeight(self.node, YGValueUndefined.value)
        case let .some(.percent(percent)):
          YGNodeStyleSetMinHeightPercent(self.node, Float(percent))
        case let .some(.point(point)):
          YGNodeStyleSetMinHeight(self.node, Float(point))
      }
    }
    get {
      return Value(value: YGNodeStyleGetMinHeight(self.node))
    }
  }

  public var maxWidth: Value? {
    set {
      switch newValue {
        case .none:
          YGNodeStyleSetMaxWidth(self.node, YGValueUndefined.value)
        case let .some(.percent(percent)):
          YGNodeStyleSetMaxWidthPercent(self.node, Float(percent))
        case let .some(.point(point)):
          YGNodeStyleSetMaxWidth(self.node, Float(point))
      }
    }
    get {
      return Value(value: YGNodeStyleGetMaxWidth(self.node))
    }
  }

  public var maxHeight: Value? {
    set {
      switch newValue {
        case .none:
          YGNodeStyleSetMaxHeight(self.node, YGValueUndefined.value)
        case let .some(.percent(percent)):
          YGNodeStyleSetMaxHeightPercent(self.node, Float(percent))
        case let .some(.point(point)):
          YGNodeStyleSetMaxHeight(self.node, Float(point))
      }
    }
    get {
      return Value(value: YGNodeStyleGetMaxHeight(self.node))
    }
  }
}

extension FlexLayout {
  public func setSize(_ size: CGSize) {
    self.width = .point(size.width)
    self.height = .point(size.height)
  }
}

extension FlexLayout {
  private func setPosition(_ position: Value?, at edge: YGEdge) {
    switch position {
      case .none:
        YGNodeStyleSetPosition(self.node, edge, YGValueUndefined.value)
      case let .some(.percent(percent)):
        YGNodeStyleSetPositionPercent(self.node, edge, Float(percent))
      case let .some(.point(point)):
        YGNodeStyleSetPosition(self.node, edge, Float(point))
    }
  }

  private func position(at edge: YGEdge) -> Value? {
    return Value(value: YGNodeStyleGetPosition(self.node, edge))
  }

  private func setMargin(_ margin: AutoValue?, at edge: YGEdge) {
    switch margin {
      case .none:
        YGNodeStyleSetMargin(self.node, edge, YGValueUndefined.value)
      case .some(.auto):
        YGNodeStyleSetMarginAuto(self.node, edge)
      case let .some(.percent(percent)):
        YGNodeStyleSetMarginPercent(self.node, edge, Float(percent))
      case let .some(.point(point)):
        YGNodeStyleSetMargin(self.node, edge, Float(point))
    }
  }

  private func margin(at edge: YGEdge) -> AutoValue? {
    return AutoValue(value: YGNodeStyleGetMargin(self.node, edge))
  }

  private func setPadding(_ padding: Value?, at edge: YGEdge) {
    switch padding {
      case .none:
        YGNodeStyleSetPadding(self.node, edge, YGValueUndefined.value)
      case let .some(.percent(percent)):
        YGNodeStyleSetPaddingPercent(self.node, edge, Float(percent))
      case let .some(.point(point)):
        YGNodeStyleSetPadding(self.node, edge, Float(point))
    }
  }

  private func padding(at edge: YGEdge) -> Value? {
    return Value(value: YGNodeStyleGetPadding(self.node, edge))
  }

  private func setBorderWidth(_ width: CGFloat?, at edge: YGEdge) {
    YGNodeStyleSetBorder(self.node, edge, width.map(Float.init) ?? YGValueUndefined.value)
  }

  private func borderWidth(at edge: YGEdge) -> CGFloat? {
    let value = YGNodeStyleGetBorder(self.node, edge)
    guard !YGFloatIsUndefined(value) else {
      return nil
    }
    return CGFloat(value)
  }
}
