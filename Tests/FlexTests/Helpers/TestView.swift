//
//  TestView.swift
//  FlexTests
//
//  Created by Marc Bauer on 13.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

import Flex
import UIKit

final class TestView: UIView {
  var intrinsicSize: CGSize?
  var alignmentInsets: UIEdgeInsets?

  init(intrinsicSize: CGSize? = nil, alignmentInsets: UIEdgeInsets? = nil) {
    self.intrinsicSize = intrinsicSize
    self.alignmentInsets = alignmentInsets

    super.init(frame: .zero)

    self.flex.enabled = true
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    guard let intrinsicSize = self.intrinsicSize else {
      return super.sizeThatFits(size)
    }
    return intrinsicSize
  }

  override var alignmentRectInsets: UIEdgeInsets {
    return self.alignmentInsets ?? .zero
  }
}
