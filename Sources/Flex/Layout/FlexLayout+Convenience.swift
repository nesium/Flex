//
//  File.swift
//  
//
//  Created by Marc Bauer on 05.03.20.
//

import CoreGraphics

extension FlexLayout {
  @discardableResult
  public func size(_ size: CGSize) -> FlexLayout {
    self.size(width: .point(size.width), height: .point(size.height))
  }

  @discardableResult
  public func position(_ topLeft: CGPoint) -> FlexLayout {
    self.position(top: .point(topLeft.y), left: .point(topLeft.x))
  }

  @discardableResult
  public func minSize(_ size: CGSize) -> FlexLayout {
    self.minSize(width: .point(size.width), height: .point(size.height))
  }

  @discardableResult
  public func maxSize(_ size: CGSize) -> FlexLayout {
    self.maxSize(width: .point(size.width), height: .point(size.height))
  }

  @discardableResult
  public func top(_ top: Value?) -> FlexLayout {
    self.position(top: top)
  }

  @discardableResult
  public func left(_ left: Value?) -> FlexLayout {
    self.position(left: left)
  }

  @discardableResult
  public func bottom(_ bottom: Value?) -> FlexLayout {
    self.position(bottom: bottom)
  }

  @discardableResult
  public func right(_ right: Value?) -> FlexLayout {
    self.position(right: right)
  }

  @discardableResult
  public func width(_ width: AutoValue?) -> FlexLayout {
    self.size(width: width)
  }

  @discardableResult
  public func height(_ height: AutoValue?) -> FlexLayout {
    self.size(height: height)
  }

  @discardableResult
  public func margin(
    _ val1: AutoValue?,
    _ val2: AutoValue? = nil,
    _ val3: AutoValue? = nil,
    _ val4: AutoValue? = nil
  ) -> FlexLayout {
    switch (val1, val2, val3, val4) {
      case (.none, .none, .none, .none):
        return self.margin(top: nil, left: nil, bottom: nil, right: nil)
      case let (all, .none, .none, .none):
        return self.margin(top: all, left: all, bottom: all, right: all)
      case let (topBottom, rightLeft, .none, .none):
        return self.margin(top: topBottom, left: rightLeft, bottom: topBottom, right: rightLeft)
      case let (top, rightLeft, bottom, .none):
        return self.margin(top: top, left: rightLeft, bottom: bottom, right: rightLeft)
      case let (top, right, bottom, left):
        return self.margin(top: top, left: left, bottom: bottom, right: right)
    }
  }

  @discardableResult
  public func padding(
    _ val1: Value?,
    _ val2: Value? = nil,
    _ val3: Value? = nil,
    _ val4: Value? = nil
  ) -> FlexLayout {
    switch (val1, val2, val3, val4) {
      case (.none, .none, .none, .none):
        return self.padding(top: nil, left: nil, bottom: nil, right: nil)
      case let (all, .none, .none, .none):
        return self.padding(top: all, left: all, bottom: all, right: all)
      case let (topBottom, rightLeft, .none, .none):
        return self.padding(top: topBottom, left: rightLeft, bottom: topBottom, right: rightLeft)
      case let (top, rightLeft, bottom, .none):
        return self.padding(top: top, left: rightLeft, bottom: bottom, right: rightLeft)
      case let (top, right, bottom, left):
        return self.padding(top: top, left: left, bottom: bottom, right: right)
    }
  }
}

#if canImport(UIKit)
  import UIKit

  extension FlexLayout {
    @discardableResult
    public func margin(_ margin: UIEdgeInsets) -> FlexLayout {
      self.margin(
        top: .point(margin.top),
        left: .point(margin.left),
        bottom: .point(margin.bottom),
        right: .point(margin.right)
      )
    }

    @discardableResult
    public func padding(_ padding: UIEdgeInsets) -> FlexLayout {
      self.padding(
        top: .point(padding.top),
        left: .point(padding.left),
        bottom: .point(padding.bottom),
        right: .point(padding.right)
      )
    }
  }
#endif
