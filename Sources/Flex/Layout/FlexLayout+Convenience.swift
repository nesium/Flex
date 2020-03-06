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
