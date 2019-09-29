//
//  YogaKitTests.swift
//  FlexTests
//
//  Created by Marc Bauer on 14.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

import SnapshotTesting
import UIKit
import XCTest

@testable import Flex

final class YogaKitTests: XCTestCase {
  func testStyleBlock() {
    let view = UIView()

    view.flex.style {
      $0.enabled = true
      $0.width = 25
    }

    XCTAssertTrue(view.flex.enabled)
    XCTAssertEqual(view.flex.width, .point(25))
  }

  func testNodesAreDeallocedWithSingleView() {
    weak var layout: FlexLayout?

    autoreleasepool {
      let view = UIView()
      view.flex.basis = 1
      layout = view.flex
      XCTAssertNotNil(layout)
    }

    XCTAssertNil(layout)
  }

  func testNodesAreDeallocedCascade() {
    weak var topLayout: FlexLayout?
    weak var subviewLayout: FlexLayout?

    autoreleasepool {
      let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
      view.flex.enabled = true
      topLayout = view.flex

      let subview = UIView()
      subview.flex.style {
        $0.enabled = true
        $0.height = 50
      }
      subviewLayout = subview.flex

      view.addSubview(subview)

      view.flex.layoutSubviews()

      XCTAssertFalse(subview.frame.isEmpty)

      XCTAssertNotNil(topLayout)
      XCTAssertNotNil(subviewLayout)
    }

    XCTAssertNil(topLayout)
    XCTAssertNil(subviewLayout)
  }

  func testEnabled() {
    let view = UIView()
    XCTAssertFalse(view.flex.enabled)

    view.flex.enabled = true
    XCTAssertTrue(view.flex.enabled)

    view.flex.enabled = false
    XCTAssertFalse(view.flex.enabled)
  }

  func testSizeThatFitsSmoke() {
    let container = UIView()
    container.flex.style {
      $0.enabled = true
      $0.direction = .row
      $0.alignItems = .start
    }

    let label = UILabel()
    label.text = "This is a very very very very very very very very long piece of text."
    label.lineBreakMode = .byTruncatingTail
    label.numberOfLines = 0
    label.flex.style {
      $0.enabled = true
      $0.shrink = 1
    }
    container.addSubview(label)

    let badgeView = UIView()
    badgeView.flex.style {
      $0.enabled = true
      $0.width = 10
      $0.height = 10
    }
    container.addSubview(badgeView)

    let badgeViewSize = badgeView.flex.intrinsicSize
    XCTAssertEqual(badgeViewSize, CGSize(width: 10, height: 10))

    let containerSize = container.flex.intrinsicSize
    let labelSize = label.flex.intrinsicSize

    XCTAssertEqual(labelSize.height, containerSize.height)
    XCTAssertEqual(labelSize.width + badgeViewSize.width, containerSize.width)
  }

  func testSizeThatFitsEmptyView() {
    let view = UIView(frame: CGRect(x: 10, y: 10, width: 200, height: 200))
    view.flex.enabled = true

    XCTAssertEqual(view.flex.intrinsicSize, CGSize(width: 0, height: 0))
  }

  func testPreservingOrigin() {
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 75))
    container.flex.enabled = true

    let view = UIView()
    view.flex.style {
      $0.enabled = true
      $0.grow = 1
    }
    container.addSubview(view)

    let view2 = UIView()
    view2.flex.style {
      $0.enabled = true
      $0.marginTop = 25
      $0.grow = 1
    }
    container.addSubview(view2)

    container.flex.layoutSubviews()
    XCTAssertEqual(view2.frame.minY, 50)

    view2.flex.layoutSubviews()
    XCTAssertEqual(view2.frame.minY, 50)
  }

  func testDirtyingOnlyWorksOnLeafNodes() {
    let container = UIView()
    container.flex.enabled = true

    let view = UIView()
    view.flex.enabled = true
    container.addSubview(view)

    XCTAssertFalse(container.flex.isDirty)
    container.flex.setIsDirty()
    XCTAssertFalse(container.flex.isDirty)

    XCTAssertFalse(view.flex.isDirty)
    view.flex.setIsDirty()
    XCTAssertTrue(view.flex.isDirty)
  }

  func testDirtyingLeafsWillTriggerSizeRecalculation() {
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 50))
    container.flex.style {
      $0.enabled = true
      $0.direction = .row
      $0.alignItems = .start
    }

    let label = UILabel()
    label.text = "This is a short text."
    label.numberOfLines = 1
    label.flex.enabled = true
    container.addSubview(label)

    container.flex.layoutSubviews()

    let labelSizeAfterFirstPass = label.frame.size

    label.text = "This is a slightly longer text."

    container.flex.layoutSubviews()
    XCTAssertEqual(label.frame.size, labelSizeAfterFirstPass)

    label.flex.setIsDirty()
    container.flex.layoutSubviews()

    XCTAssertNotEqual(label.frame.size, labelSizeAfterFirstPass)
  }

  func testIsLeafFlag() {
    let view = UIView()
    XCTAssertTrue(view.flex.isLeaf)

    view.addSubview(UIView())
    view.addSubview(UIView())

    XCTAssertTrue(view.flex.isLeaf)

    view.flex.enabled = true
    XCTAssertTrue(view.flex.isLeaf)

    view.subviews.last!.flex.enabled = true
    XCTAssertFalse(view.flex.isLeaf)
  }

  func testFrameAndOriginPlacement() {
    let containerSize = CGSize(width: 320, height: 50)

    let container = UIView(frame: CGRect(origin: .zero, size: containerSize))
    container.flex.style {
      $0.enabled = true
      $0.direction = .row
    }

    let style = { (flex: FlexLayout) in
      flex.enabled = true
      flex.grow = 1
    }

    let subview1 = UIView()
    subview1.flex.style(with: style)
    container.addSubview(subview1)

    let subview2 = UIView()
    subview2.flex.style(with: style)
    container.addSubview(subview2)

    let subview3 = UIView()
    subview3.flex.style(with: style)
    container.addSubview(subview3)

    FlexLayoutConfiguration.shared.screenScale = 3
    container.flex.layoutSubviews()
    assertSnapshot(matching: container, as: .recursiveDescription)

    FlexLayoutConfiguration.shared.screenScale = 2
    container.flex.layoutSubviews()
    assertSnapshot(matching: container, as: .recursiveDescription)

    FlexLayoutConfiguration.shared.screenScale = 1
    container.flex.layoutSubviews()
    assertSnapshot(matching: container, as: .recursiveDescription)
  }

  func testThatLayoutIsCorrectWhenWeSwapViewOrder() {
    let containerSize = CGSize(width: 300, height: 50)

    let container = UIView(frame: CGRect(origin: .zero, size: containerSize))
    container.flex.style {
      $0.enabled = true
      $0.direction = .row
    }

    let style = { (flex: FlexLayout) in
      flex.enabled = true
      flex.grow = 1
    }

    let subview1 = UIView()
    subview1.flex.style(with: style)
    container.addSubview(subview1)

    let subview2 = UIView()
    subview2.flex.style(with: style)
    container.addSubview(subview2)

    let subview3 = UIView()
    subview3.flex.style(with: style)
    container.addSubview(subview3)

    container.flex.layoutSubviews()

    assertSnapshot(matching: container, as: .recursiveDescription)

    container.exchangeSubview(at: 2, withSubviewAt: 0)
    subview2.flex.includedInLayout = false
    container.flex.layoutSubviews()

    assertSnapshot(matching: container, as: .recursiveDescription)
  }

  func testThatWeRespectIncludeInLayoutFlag() {
    let containerSize = CGSize(width: 300, height: 50)

    let container = UIView(frame: CGRect(origin: .zero, size: containerSize))
    container.flex.style {
      $0.enabled = true
      $0.direction = .row
    }

    let style = { (flex: FlexLayout) in
      flex.enabled = true
      flex.grow = 1
    }

    let subview1 = UIView()
    subview1.flex.style(with: style)
    container.addSubview(subview1)

    let subview2 = UIView()
    subview2.flex.style(with: style)
    container.addSubview(subview2)

    let subview3 = UIView()
    subview3.flex.style(with: style)
    container.addSubview(subview3)

    container.flex.layoutSubviews()

    assertSnapshot(matching: container, as: .recursiveDescription)

    subview3.flex.includedInLayout = false
    container.flex.layoutSubviews()

    assertSnapshot(matching: container, as: .recursiveDescription)

    subview3.flex.includedInLayout = true
    container.flex.layoutSubviews()

    assertSnapshot(matching: container, as: .recursiveDescription)
  }

  func testThatNumberOfChildrenIsCorrectWhenWeIgnoreSubviews() {
    let container = UIView()
    container.flex.style {
      $0.enabled = true
      $0.direction = .row
    }

    let subview1 = UIView()
    subview1.flex.style {
      $0.enabled = true
      $0.includedInLayout = false
    }
    container.addSubview(subview1)

    let subview2 = UIView()
    subview2.flex.style {
      $0.enabled = true
      $0.includedInLayout = false
    }
    container.addSubview(subview2)

    let subview3 = UIView()
    subview3.flex.style {
      $0.enabled = true
      $0.includedInLayout = true
    }
    container.addSubview(subview3)

    container.flex.layoutSubviews()
    XCTAssertEqual(container.flex.numberOfChildren, 1)

    subview2.flex.includedInLayout = true

    container.flex.layoutSubviews()
    XCTAssertEqual(container.flex.numberOfChildren, 2)
  }

  func testThatWeCorrectlyAttachNestedViews() {
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
    container.flex.enabled = true
    container.flex.direction = .column

    FlexLayoutConfiguration.shared.screenScale = 2

    let subview1 = UIView()
    subview1.flex.style {
      $0.enabled = true
      $0.width = 100
      $0.grow = 1
      $0.direction = .column
    }
    container.addSubview(subview1)

    let subview2 = UIView()
    subview2.flex.style {
      $0.enabled = true
      $0.width = 150
      $0.grow = 1
      $0.direction = .column
    }
    container.addSubview(subview2)

    [subview1, subview2].forEach {
      let view = UIView()
      view.flex.style {
        $0.enabled = true
        $0.grow = 1
      }
      $0.addSubview(view)
    }

    container.flex.layoutSubviews()

    // Add the same amount of new views, reapply layout.
    [subview1, subview2].forEach {
      let view = UIView()
      view.flex.style {
        $0.enabled = true
        $0.grow = 1
      }
      $0.addSubview(view)
    }

    container.flex.layoutSubviews()

    assertSnapshot(matching: container, as: .recursiveDescription)
  }

  func testThatANonLeafNodeCanBecomeALeafNode() {
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
    container.flex.enabled = true

    let subview1 = UIView()
    subview1.flex.enabled = true
    container.addSubview(subview1)

    container.flex.layoutSubviews()
    XCTAssertFalse(container.flex.isLeaf)

    subview1.removeFromSuperview()

    container.flex.layoutSubviews()
    XCTAssertTrue(container.flex.isLeaf)
  }

  func testPositionalPropertiesWork() {
    let view = UIView()

    view.flex.top = 1
    XCTAssertEqual(view.flex.top, .point(1))
    view.flex.top = 2%
    XCTAssertEqual(view.flex.top, .percent(2))
    view.flex.top = nil
    XCTAssertNil(view.flex.top)

    view.flex.left = 3
    XCTAssertEqual(view.flex.left, .point(3))
    view.flex.left = 4%
    XCTAssertEqual(view.flex.left, .percent(4))
    view.flex.left = nil
    XCTAssertNil(view.flex.left)

    view.flex.bottom = 5
    XCTAssertEqual(view.flex.bottom, .point(5))
    view.flex.bottom = 6%
    XCTAssertEqual(view.flex.bottom, .percent(6))
    view.flex.bottom = nil
    XCTAssertNil(view.flex.bottom)

    view.flex.bottom = 7
    XCTAssertEqual(view.flex.bottom, .point(7))
    view.flex.bottom = 8%
    XCTAssertEqual(view.flex.bottom, .percent(8))
    view.flex.bottom = nil
    XCTAssertNil(view.flex.bottom)

    view.flex.start = 9
    XCTAssertEqual(view.flex.start, .point(9))
    view.flex.start = 10%
    XCTAssertEqual(view.flex.start, .percent(10))
    view.flex.start = nil
    XCTAssertNil(view.flex.start)

    view.flex.end = 11
    XCTAssertEqual(view.flex.end, .point(11))
    view.flex.end = 12%
    XCTAssertEqual(view.flex.end, .percent(12))
    view.flex.end = nil
    XCTAssertNil(view.flex.end)
  }

  func testMarginPropertiesWork() {
    let view = UIView()

    view.flex.marginTop = 1
    XCTAssertEqual(view.flex.marginTop, .point(1))
    view.flex.marginTop = 2%
    XCTAssertEqual(view.flex.marginTop, .percent(2))
    view.flex.marginTop = .auto
    XCTAssertEqual(view.flex.marginTop, .auto)
    view.flex.marginTop = nil
    XCTAssertNil(view.flex.marginTop)

    view.flex.marginLeft = 3
    XCTAssertEqual(view.flex.marginLeft, .point(3))
    view.flex.marginLeft = 4%
    XCTAssertEqual(view.flex.marginLeft, .percent(4))
    view.flex.marginLeft = .auto
    XCTAssertEqual(view.flex.marginLeft, .auto)
    view.flex.marginLeft = nil
    XCTAssertNil(view.flex.marginLeft)

    view.flex.marginBottom = 5
    XCTAssertEqual(view.flex.marginBottom, .point(5))
    view.flex.marginBottom = 6%
    XCTAssertEqual(view.flex.marginBottom, .percent(6))
    view.flex.marginBottom = .auto
    XCTAssertEqual(view.flex.marginBottom, .auto)
    view.flex.marginBottom = nil
    XCTAssertNil(view.flex.marginBottom)

    view.flex.marginRight = 7
    XCTAssertEqual(view.flex.marginRight, .point(7))
    view.flex.marginRight = 8%
    XCTAssertEqual(view.flex.marginRight, .percent(8))
    view.flex.marginRight = .auto
    XCTAssertEqual(view.flex.marginRight, .auto)
    view.flex.marginRight = nil
    XCTAssertNil(view.flex.marginRight)

    view.flex.marginStart = 9
    XCTAssertEqual(view.flex.marginStart, .point(9))
    view.flex.marginStart = 10%
    XCTAssertEqual(view.flex.marginStart, .percent(10))
    view.flex.marginStart = .auto
    XCTAssertEqual(view.flex.marginStart, .auto)
    view.flex.marginStart = nil
    XCTAssertNil(view.flex.marginStart)

    view.flex.marginEnd = 11
    XCTAssertEqual(view.flex.marginEnd, .point(11))
    view.flex.marginEnd = 12%
    XCTAssertEqual(view.flex.marginEnd, .percent(12))
    view.flex.marginEnd = .auto
    XCTAssertEqual(view.flex.marginEnd, .auto)
    view.flex.marginEnd = nil
    XCTAssertNil(view.flex.marginEnd)

    view.flex.marginHorizontal = 13
    XCTAssertEqual(view.flex.marginHorizontal, .point(13))
    view.flex.marginHorizontal = 14%
    XCTAssertEqual(view.flex.marginHorizontal, .percent(14))
    view.flex.marginHorizontal = .auto
    XCTAssertEqual(view.flex.marginHorizontal, .auto)
    view.flex.marginHorizontal = nil
    XCTAssertNil(view.flex.marginHorizontal)

    view.flex.marginVertical = 15
    XCTAssertEqual(view.flex.marginVertical, .point(15))
    view.flex.marginVertical = 16%
    XCTAssertEqual(view.flex.marginVertical, .percent(16))
    view.flex.marginVertical = .auto
    XCTAssertEqual(view.flex.marginVertical, .auto)
    view.flex.marginVertical = nil
    XCTAssertNil(view.flex.marginVertical)

    view.flex.margin = (1, 2, 3, 4)
    XCTAssertEqual(view.flex.marginTop, 1)
    XCTAssertEqual(view.flex.marginLeft, 2)
    XCTAssertEqual(view.flex.marginBottom, 3)
    XCTAssertEqual(view.flex.marginRight, 4)
  }

  func testPaddingPropertiesWork() {
    let view = UIView()

    view.flex.paddingTop = 1
    XCTAssertEqual(view.flex.paddingTop, .point(1))
    view.flex.paddingTop = 2%
    XCTAssertEqual(view.flex.paddingTop, .percent(2))
    view.flex.paddingTop = nil
    XCTAssertNil(view.flex.paddingTop)

    view.flex.paddingLeft = 3
    XCTAssertEqual(view.flex.paddingLeft, .point(3))
    view.flex.paddingLeft = 4%
    XCTAssertEqual(view.flex.paddingLeft, .percent(4))
    view.flex.paddingLeft = nil
    XCTAssertNil(view.flex.paddingLeft)

    view.flex.paddingBottom = 5
    XCTAssertEqual(view.flex.paddingBottom, .point(5))
    view.flex.paddingBottom = 6%
    XCTAssertEqual(view.flex.paddingBottom, .percent(6))
    view.flex.paddingBottom = nil
    XCTAssertNil(view.flex.paddingBottom)

    view.flex.paddingRight = 7
    XCTAssertEqual(view.flex.paddingRight, .point(7))
    view.flex.paddingRight = 8%
    XCTAssertEqual(view.flex.paddingRight, .percent(8))
    view.flex.paddingRight = nil
    XCTAssertNil(view.flex.paddingRight)

    view.flex.paddingStart = 9
    XCTAssertEqual(view.flex.paddingStart, .point(9))
    view.flex.paddingStart = 10%
    XCTAssertEqual(view.flex.paddingStart, .percent(10))
    view.flex.paddingStart = nil
    XCTAssertNil(view.flex.paddingStart)

    view.flex.paddingEnd = 11
    XCTAssertEqual(view.flex.paddingEnd, .point(11))
    view.flex.paddingEnd = 12%
    XCTAssertEqual(view.flex.paddingEnd, .percent(12))
    view.flex.paddingEnd = nil
    XCTAssertNil(view.flex.paddingEnd)
  }

  func testBorderWidthPropertiesWork() {
    let view = UIView()

    view.flex.borderWidthTop = 1
    XCTAssertEqual(view.flex.borderWidthTop, 1)
    view.flex.borderWidthTop = nil
    XCTAssertNil(view.flex.borderWidthTop)

    view.flex.borderWidthLeft = 2
    XCTAssertEqual(view.flex.borderWidthLeft, 2)
    view.flex.borderWidthLeft = nil
    XCTAssertNil(view.flex.borderWidthLeft)

    view.flex.borderWidthBottom = 3
    XCTAssertEqual(view.flex.borderWidthBottom, 3)
    view.flex.borderWidthBottom = nil
    XCTAssertNil(view.flex.borderWidthBottom)

    view.flex.borderWidthRight = 4
    XCTAssertEqual(view.flex.borderWidthRight, 4)
    view.flex.borderWidthRight = nil
    XCTAssertNil(view.flex.borderWidthRight)

    view.flex.borderWidthStart = 5
    XCTAssertEqual(view.flex.borderWidthStart, 5)
    view.flex.borderWidthStart = nil
    XCTAssertNil(view.flex.borderWidthStart)

    view.flex.borderWidthEnd = 6
    XCTAssertEqual(view.flex.borderWidthEnd, 6)
    view.flex.borderWidthEnd = nil
    XCTAssertNil(view.flex.borderWidthEnd)
  }
}
