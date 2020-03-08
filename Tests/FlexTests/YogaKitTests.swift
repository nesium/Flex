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
    view.flex.enable().size(width: 25)

    XCTAssertTrue(view.flex.isEnabled)
    XCTAssertEqual(view.flex.width, .point(25))
  }

  func testNodesAreDeallocedWithSingleView() {
    weak var layout: FlexLayout?

    autoreleasepool {
      let view = UIView()
      view.flex.basis(1)
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
      view.flex.enable()
      topLayout = view.flex

      let subview = UIView()
      subview.flex.enable().size(height: 50)
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
    XCTAssertFalse(view.flex.isEnabled)

    view.flex.isEnabled = true
    XCTAssertTrue(view.flex.isEnabled)

    view.flex.isEnabled = false
    XCTAssertFalse(view.flex.isEnabled)
  }

  func testSizeThatFitsSmoke() {
    let container = UIView()
    container.flex
      .enable()
      .row()
      .align(items: .start)

    let label = UILabel()
    label.text = "This is a very very very very very very very very long piece of text."
    label.lineBreakMode = .byTruncatingTail
    label.numberOfLines = 0
    label.flex
      .enable()
      .shrink(1)
    container.addSubview(label)

    let badgeView = UIView()
    badgeView.flex
      .enable()
      .size(width: 10, height: 10)
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
    view.flex.isEnabled = true

    XCTAssertEqual(view.flex.intrinsicSize, CGSize(width: 0, height: 0))
  }

  func testPreservingOrigin() {
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 75))
    container.flex.isEnabled = true

    let view = UIView()
    view.flex
      .enable()
      .grow(1)
    container.addSubview(view)

    let view2 = UIView()
    view2.flex
      .enable()
      .margin(top: 25)
      .grow(1)
    container.addSubview(view2)

    container.flex.layoutSubviews()
    XCTAssertEqual(view2.frame.minY, 50)

    view2.flex.layoutSubviews()
    XCTAssertEqual(view2.frame.minY, 50)
  }

  func testDirtyingOnlyWorksOnLeafNodes() {
    let container = UIView()
    container.flex.isEnabled = true

    let view = UIView()
    view.flex.isEnabled = true
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
    container.flex
      .enable()
      .row()
      .align(items: .start)
    let label = UILabel()
    label.text = "This is a short text."
    label.numberOfLines = 1
    label.flex.isEnabled = true
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

    view.flex.isEnabled = true
    XCTAssertTrue(view.flex.isLeaf)

    view.subviews.last!.flex.isEnabled = true
    XCTAssertFalse(view.flex.isLeaf)
  }

  func testFrameAndOriginPlacement() {
    let containerSize = CGSize(width: 320, height: 50)

    let container = UIView(frame: CGRect(origin: .zero, size: containerSize))
    container.flex.enable().row()

    container.flex
      .addChild(UIView())
      .grow(1)
    container.flex
      .addChild(UIView())
      .grow(1)
    container.flex
      .addChild(UIView())
      .grow(1)

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
    container.flex.enable().row()

    container.flex
      .addChild(UIView())
      .grow(1)
    let subview2 = UIView()
    container.flex
      .addChild(subview2)
      .grow(1)
    container.flex
      .addChild(UIView())
      .grow(1)

    container.flex.layoutSubviews()

    assertSnapshot(matching: container, as: .recursiveDescription)

    container.exchangeSubview(at: 2, withSubviewAt: 0)
    subview2.flex.isIncludedInLayout = false
    container.flex.layoutSubviews()

    assertSnapshot(matching: container, as: .recursiveDescription)
  }

  func testThatWeRespectIncludeInLayoutFlag() {
    let containerSize = CGSize(width: 300, height: 50)

    let container = UIView(frame: CGRect(origin: .zero, size: containerSize))
    container.flex.enable().row()

    container.flex
      .addChild(UIView())
      .grow(1)
    container.flex
      .addChild(UIView())
      .grow(1)
    let subview3 = UIView()
    container.flex
      .addChild(subview3)
      .grow(1)

    container.flex.layoutSubviews()

    assertSnapshot(matching: container, as: .recursiveDescription)

    subview3.flex.excludeFromLayout()
    container.flex.layoutSubviews()

    assertSnapshot(matching: container, as: .recursiveDescription)

    subview3.flex.includeInLayout()
    container.flex.layoutSubviews()

    assertSnapshot(matching: container, as: .recursiveDescription)
  }

  func testThatNumberOfChildrenIsCorrectWhenWeIgnoreSubviews() {
    let container = UIView()
    container.flex.enable().row()

    container.flex
      .addChild(UIView())
      .excludeFromLayout()
    let subview2 = UIView()
    container.flex
      .addChild(subview2)
      .excludeFromLayout()
      .grow(1)
    container.flex
      .addChild(UIView())

    container.flex.layoutSubviews()
    XCTAssertEqual(container.flex.numberOfChildren, 1)

    subview2.flex.includeInLayout()

    container.flex.layoutSubviews()
    XCTAssertEqual(container.flex.numberOfChildren, 2)
  }

  func testThatWeCorrectlyAttachNestedViews() {
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
    container.flex.isEnabled = true
    container.flex.direction = .column

    FlexLayoutConfiguration.shared.screenScale = 2

    let subview1 = UIView()
    subview1.flex
      .enable()
      .size(width: 100)
      .grow(1)
      .column()
    container.addSubview(subview1)

    let subview2 = UIView()
    subview2.flex
      .enable()
      .size(width: 150)
      .grow(1)
      .column()
    container.addSubview(subview2)

    [subview1, subview2].forEach {
      let view = UIView()
      view.flex
        .enable()
        .grow(1)
      $0.addSubview(view)
    }

    container.flex.layoutSubviews()

    // Add the same amount of new views, reapply layout.
    [subview1, subview2].forEach {
      let view = UIView()
      view.flex
        .enable()
        .grow(1)
      $0.addSubview(view)
    }

    container.flex.layoutSubviews()

    assertSnapshot(matching: container, as: .recursiveDescription)
  }

  func testThatANonLeafNodeCanBecomeALeafNode() {
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
    container.flex.enable()

    let subview1 = UIView()
    subview1.flex.enable()
    container.addSubview(subview1)

    container.flex.layoutSubviews()
    XCTAssertFalse(container.flex.isLeaf)

    subview1.removeFromSuperview()

    container.flex.layoutSubviews()
    XCTAssertTrue(container.flex.isLeaf)
  }
}
