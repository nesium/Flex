//
//  UIView+Flex.swift
//  Flex
//
//  Created by Marc Bauer on 13.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

import UIKit

extension UIView {
  private struct AssociatedKeys {
    static var flex = "flex"
  }

  public var flex: FlexLayout {
    if let layout = objc_getAssociatedObject(self, &AssociatedKeys.flex) as? FlexLayout {
      return layout
    }

    let layout = FlexLayout(owner: self)
    objc_setAssociatedObject(
      self,
      &AssociatedKeys.flex,
      layout,
      .OBJC_ASSOCIATION_RETAIN_NONATOMIC
    )
    return layout
  }
}
