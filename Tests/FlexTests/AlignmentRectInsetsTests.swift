//
//  AlignmentRectInsetsTests.swift
//  FlexTests
//
//  Created by Marc Bauer on 14.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

import Flex
import SnapshotTesting
import UIKit
import XCTest

fileprivate class TestLabel: UILabel {
  public override var alignmentRectInsets: UIEdgeInsets {
    return UIEdgeInsets(
      top: self.font.ascender - self.font.capHeight,
      left: 0,
      bottom: -self.font.descender,
      right: 0
    )
  }
}

final class AlignmentRectInsetsTests: XCTestCase {
  func testAlignmentRectsInsets() {
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    container.flex.enabled = true

    let view = TestView(alignmentInsets: UIEdgeInsets(top: 2, left: 5, bottom: 7, right: 11))
    view.flex.enabled = true
    view.flex.grow(1)
    container.addSubview(view)

    container.flex.layoutSubviews()

    XCTAssertEqual(view.frame, CGRect(x: -5, y: -2, width: 316, height: 309))
  }

  func testAlignmentRectInsetsWithLabel() {
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    container.flex
      .enable()
      .justify(content: .center)
      .align(items: .center)

    let labelContainer = UIView()
    labelContainer.flex.enable()
    labelContainer.layer.borderColor = UIColor.red.cgColor
    labelContainer.layer.borderWidth = 1
    container.addSubview(labelContainer)

    let label = TestLabel()
    label.flex.enable()
    label.text = "Flex Layout"
    label.font = UIFont.systemFont(ofSize: 24)
    label.layer.borderColor = UIColor.green.cgColor
    label.layer.borderWidth = 1
    labelContainer.addSubview(label)

    container.flex.layoutSubviews()

    assertSnapshot(matching: container, as: .image)
  }
}
