//
//  BuilderTests.swift
//  FlexTests
//
//  Created by Marc Bauer on 23.02.20.
//

@testable import Flex
import UIKit
import XCTest

final class BuilderTests: XCTestCase {
  func testPaddingTop() {
    let view = UIView()
    view.flex.padding(top: 10)
    XCTAssertEqual(view.flex.paddingTop, 10)
    XCTAssertNil(view.flex.paddingLeft)
    XCTAssertNil(view.flex.paddingBottom)
    XCTAssertNil(view.flex.paddingRight)
  }

  func testPaddingLeft() {
    let view = UIView()
    view.flex.padding(left: 10)
    XCTAssertNil(view.flex.paddingTop)
    XCTAssertEqual(view.flex.paddingLeft, 10)
    XCTAssertNil(view.flex.paddingBottom)
    XCTAssertNil(view.flex.paddingRight)
  }

  func testPaddingBottom() {
    let view = UIView()
    view.flex.padding(bottom: 10)
    XCTAssertNil(view.flex.paddingTop)
    XCTAssertNil(view.flex.paddingLeft)
    XCTAssertEqual(view.flex.paddingBottom, 10)
    XCTAssertNil(view.flex.paddingRight)
  }

  func testPaddingRight() {
    let view = UIView()
    view.flex.padding(right: 10)
    XCTAssertNil(view.flex.paddingTop)
    XCTAssertNil(view.flex.paddingLeft)
    XCTAssertNil(view.flex.paddingBottom)
    XCTAssertEqual(view.flex.paddingRight, 10)
  }

  func testPaddingPoint() {
    let view = UIView()
    view.flex.padding(top: 10, left: 20, bottom: 30, right: 40)
    XCTAssertEqual(view.flex.paddingTop, 10)
    XCTAssertEqual(view.flex.paddingLeft, 20)
    XCTAssertEqual(view.flex.paddingBottom, 30)
    XCTAssertEqual(view.flex.paddingRight, 40)
  }

  func testPaddingPercent() {
    let view = UIView()
    view.flex.padding(top: 10%, left: 20%, bottom: 30%, right: 40%)
    XCTAssertEqual(view.flex.paddingTop, 10%)
    XCTAssertEqual(view.flex.paddingLeft, 20%)
    XCTAssertEqual(view.flex.paddingBottom, 30%)
    XCTAssertEqual(view.flex.paddingRight, 40%)
  }

  func testPaddingWithUIEdgeInsets() {
    let view = UIView()
    view.flex.padding(UIEdgeInsets(top: 44, left: 33, bottom: 22, right: 11))
    XCTAssertEqual(view.flex.paddingTop, 44)
    XCTAssertEqual(view.flex.paddingLeft, 33)
    XCTAssertEqual(view.flex.paddingBottom, 22)
    XCTAssertEqual(view.flex.paddingRight, 11)
  }

  func testPaddingShortHands() {
    let view = UIView()
    view.flex.padding(100, 200, 300, 400)
    XCTAssertEqual(view.flex.paddingTop, 100)
    XCTAssertEqual(view.flex.paddingRight, 200)
    XCTAssertEqual(view.flex.paddingBottom, 300)
    XCTAssertEqual(view.flex.paddingLeft, 400)

    view.flex.padding(25, 50, 75)
    XCTAssertEqual(view.flex.paddingTop, 25)
    XCTAssertEqual(view.flex.paddingRight, 50)
    XCTAssertEqual(view.flex.paddingBottom, 75)
    XCTAssertEqual(view.flex.paddingLeft, 50)

    view.flex.padding(100, 200)
    XCTAssertEqual(view.flex.paddingTop, 100)
    XCTAssertEqual(view.flex.paddingRight, 200)
    XCTAssertEqual(view.flex.paddingBottom, 100)
    XCTAssertEqual(view.flex.paddingLeft, 200)

    view.flex.padding(33)
    XCTAssertEqual(view.flex.paddingTop, 33)
    XCTAssertEqual(view.flex.paddingRight, 33)
    XCTAssertEqual(view.flex.paddingBottom, 33)
    XCTAssertEqual(view.flex.paddingLeft, 33)
  }

  func testMarginTop() {
    let view = UIView()
    view.flex.margin(top: 10)
    XCTAssertEqual(view.flex.marginTop, 10)
    XCTAssertNil(view.flex.marginLeft)
    XCTAssertNil(view.flex.marginBottom)
    XCTAssertNil(view.flex.marginRight)
  }

  func testMarginLeft() {
    let view = UIView()
    view.flex.margin(left: 10)
    XCTAssertNil(view.flex.marginTop)
    XCTAssertEqual(view.flex.marginLeft, 10)
    XCTAssertNil(view.flex.marginBottom)
    XCTAssertNil(view.flex.marginRight)
  }

  func testMarginBottom() {
    let view = UIView()
    view.flex.margin(bottom: 10)
    XCTAssertNil(view.flex.marginTop)
    XCTAssertNil(view.flex.marginLeft)
    XCTAssertEqual(view.flex.marginBottom, 10)
    XCTAssertNil(view.flex.marginRight)
  }

  func testMarginRight() {
    let view = UIView()
    view.flex.margin(right: 10)
    XCTAssertNil(view.flex.marginTop)
    XCTAssertNil(view.flex.marginLeft)
    XCTAssertNil(view.flex.marginBottom)
    XCTAssertEqual(view.flex.marginRight, 10)
  }

  func testMarginPoint() {
    let view = UIView()
    view.flex.margin(top: 10, left: 20, bottom: 30, right: 40)
    XCTAssertEqual(view.flex.marginTop, 10)
    XCTAssertEqual(view.flex.marginLeft, 20)
    XCTAssertEqual(view.flex.marginBottom, 30)
    XCTAssertEqual(view.flex.marginRight, 40)
  }

  func testMarginPercent() {
    let view = UIView()
    view.flex.margin(top: 10%, left: 20%, bottom: 30%, right: 40%)
    XCTAssertEqual(view.flex.marginTop, 10%)
    XCTAssertEqual(view.flex.marginLeft, 20%)
    XCTAssertEqual(view.flex.marginBottom, 30%)
    XCTAssertEqual(view.flex.marginRight, 40%)
  }

  func testMarginAuto() {
    let view = UIView()
    view.flex.margin(top: .auto, left: .auto, bottom: .auto, right: .auto)
    XCTAssertEqual(view.flex.marginTop, .auto)
    XCTAssertEqual(view.flex.marginLeft, .auto)
    XCTAssertEqual(view.flex.marginBottom, .auto)
    XCTAssertEqual(view.flex.marginRight, .auto)
  }

  func testMarginShortHands() {
    let view = UIView()
    view.flex.margin(100, 200, 300, 400)
    XCTAssertEqual(view.flex.marginTop, 100)
    XCTAssertEqual(view.flex.marginRight, 200)
    XCTAssertEqual(view.flex.marginBottom, 300)
    XCTAssertEqual(view.flex.marginLeft, 400)

    view.flex.margin(25, 50, 75)
    XCTAssertEqual(view.flex.marginTop, 25)
    XCTAssertEqual(view.flex.marginRight, 50)
    XCTAssertEqual(view.flex.marginBottom, 75)
    XCTAssertEqual(view.flex.marginLeft, 50)

    view.flex.margin(100, 200)
    XCTAssertEqual(view.flex.marginTop, 100)
    XCTAssertEqual(view.flex.marginRight, 200)
    XCTAssertEqual(view.flex.marginBottom, 100)
    XCTAssertEqual(view.flex.marginLeft, 200)

    view.flex.margin(33)
    XCTAssertEqual(view.flex.marginTop, 33)
    XCTAssertEqual(view.flex.marginRight, 33)
    XCTAssertEqual(view.flex.marginBottom, 33)
    XCTAssertEqual(view.flex.marginLeft, 33)
  }

  func testMarginWithUIEdgeInsets() {
    let view = UIView()
    view.flex.margin(UIEdgeInsets(top: 11, left: 22, bottom: 33, right: 44))
    XCTAssertEqual(view.flex.marginTop, 11)
    XCTAssertEqual(view.flex.marginLeft, 22)
    XCTAssertEqual(view.flex.marginBottom, 33)
    XCTAssertEqual(view.flex.marginRight, 44)
  }

  func testDirection() {
    let view = UIView()
    view.flex.row()
    XCTAssertEqual(view.flex.direction, .row)
    view.flex.row(reverse: true)
    XCTAssertEqual(view.flex.direction, .rowReverse)
    view.flex.column()
    XCTAssertEqual(view.flex.direction, .column)
    view.flex.column(reverse: true)
    XCTAssertEqual(view.flex.direction, .columnReverse)
  }

  func testPositioning() {
    let view = UIView()
    view.flex.position(.absolute)
    XCTAssertEqual(view.flex.position, .absolute)
    view.flex.position(.relative)
    XCTAssertEqual(view.flex.position, .relative)
  }

  func testJustifyContent() {
    let view = UIView()
    view.flex.justify(content: .spaceAround)
    XCTAssertEqual(view.flex.justifyContent, .spaceAround)
  }

  func testAlignContent() {
    let view = UIView()
    view.flex.align(content: .stretch)
    XCTAssertEqual(view.flex.alignContent, .stretch)
  }

  func testAlignItems() {
    let view = UIView()
    view.flex.align(items: .spaceBetween)
    XCTAssertEqual(view.flex.alignItems, .spaceBetween)
  }

  func testAlignSelf() {
    let view = UIView()
    view.flex.align(self: .end)
    XCTAssertEqual(view.flex.alignSelf, .end)
  }

  func testWrap() {
    let view = UIView()
    view.flex.wrap(.wrapReverse)
    XCTAssertEqual(view.flex.wrap, .wrapReverse)
  }

  func testOverflow() {
    let view = UIView()
    view.flex.overflow(.hidden)
    XCTAssertEqual(view.flex.overflow, .hidden)
  }

  func testDisplay() {
    let view = UIView()
    view.flex.display(.none)
    XCTAssertEqual(view.flex.display, .none)
  }

  func testGrow() {
    let view = UIView()
    view.flex.grow(4)
    XCTAssertEqual(view.flex.grow, 4)
  }

  func testShrink() {
    let view = UIView()
    view.flex.shrink(5)
    XCTAssertEqual(view.flex.shrink, 5)
  }

  func testBasis() {
    let view = UIView()
    view.flex.basis(6)
    XCTAssertEqual(view.flex.basis, 6)
  }

  func testPositionTop() {
    let view = UIView()
    view.flex.position(top: 10)
    XCTAssertEqual(view.flex.top, 10)
    XCTAssertNil(view.flex.left)
    XCTAssertNil(view.flex.bottom)
    XCTAssertNil(view.flex.right)
  }

  func testPositionTopOnly() {
    let view = UIView()
    view.flex.top(10)
    XCTAssertEqual(view.flex.top, 10)
    XCTAssertNil(view.flex.left)
    XCTAssertNil(view.flex.bottom)
    XCTAssertNil(view.flex.right)
  }

  func testPositionLeft() {
    let view = UIView()
    view.flex.position(left: 10)
    XCTAssertNil(view.flex.top)
    XCTAssertEqual(view.flex.left, 10)
    XCTAssertNil(view.flex.bottom)
    XCTAssertNil(view.flex.right)
  }

  func testPositionLeftOnly() {
    let view = UIView()
    view.flex.left(10)
    XCTAssertNil(view.flex.top)
    XCTAssertEqual(view.flex.left, 10)
    XCTAssertNil(view.flex.bottom)
    XCTAssertNil(view.flex.right)
  }

  func testPositionBottom() {
    let view = UIView()
    view.flex.position(bottom: 10)
    XCTAssertNil(view.flex.top)
    XCTAssertNil(view.flex.left)
    XCTAssertEqual(view.flex.bottom, 10)
    XCTAssertNil(view.flex.right)
  }

  func testPositionBottomOnly() {
    let view = UIView()
    view.flex.bottom(10)
    XCTAssertNil(view.flex.top)
    XCTAssertNil(view.flex.left)
    XCTAssertEqual(view.flex.bottom, 10)
    XCTAssertNil(view.flex.right)
  }

  func testPositionRight() {
    let view = UIView()
    view.flex.position(right: 10)
    XCTAssertNil(view.flex.top)
    XCTAssertNil(view.flex.left)
    XCTAssertNil(view.flex.bottom)
    XCTAssertEqual(view.flex.right, 10)
  }

  func testPositionRightOnly() {
    let view = UIView()
    view.flex.right(10)
    XCTAssertNil(view.flex.top)
    XCTAssertNil(view.flex.left)
    XCTAssertNil(view.flex.bottom)
    XCTAssertEqual(view.flex.right, 10)
  }

  func testPositionPoint() {
    let view = UIView()
    view.flex.position(top: 10, left: 20, bottom: 30, right: 40)
    XCTAssertEqual(view.flex.top, 10)
    XCTAssertEqual(view.flex.left, 20)
    XCTAssertEqual(view.flex.bottom, 30)
    XCTAssertEqual(view.flex.right, 40)
  }

  func testPositionPercent() {
    let view = UIView()
    view.flex.position(top: 10%, left: 20%, bottom: 30%, right: 40%)
    XCTAssertEqual(view.flex.top, 10%)
    XCTAssertEqual(view.flex.left, 20%)
    XCTAssertEqual(view.flex.bottom, 30%)
    XCTAssertEqual(view.flex.right, 40%)
  }

  func testPositionWithCGPoint() {
    let view = UIView()
    view.flex.position(CGPoint(x: 10, y: 20))
    XCTAssertEqual(view.flex.top, 20)
    XCTAssertEqual(view.flex.left, 10)
    XCTAssertNil(view.flex.bottom)
    XCTAssertNil(view.flex.right)
  }

  func testSizeWidth() {
    let view = UIView()
    view.flex.size(width: 200)
    XCTAssertEqual(view.flex.width, 200)
  }

  func testSizeWidthOnly() {
    let view = UIView()
    view.flex.width(200)
    XCTAssertEqual(view.flex.width, 200)
  }

  func testSizeHeight() {
    let view = UIView()
    view.flex.size(height: 200)
    XCTAssertEqual(view.flex.height, 200)
  }

  func testSizeHeightOnly() {
    let view = UIView()
    view.flex.height(200)
    XCTAssertEqual(view.flex.height, 200)
  }

  func testSizePoint() {
    let view = UIView()
    view.flex.size(width: 100, height: 300)
    XCTAssertEqual(view.flex.width, 100)
    XCTAssertEqual(view.flex.height, 300)
  }

  func testSizePercent() {
    let view = UIView()
    view.flex.size(width: 50%, height: 20%)
    XCTAssertEqual(view.flex.width, 50%)
    XCTAssertEqual(view.flex.height, 20%)
  }

  func testSizeAuto() {
    let view = UIView()
    view.flex.size(width: .auto, height: .auto)
    XCTAssertEqual(view.flex.width, .auto)
    XCTAssertEqual(view.flex.height, .auto)
  }

  func testSizeWithCGSize() {
    let view = UIView()
    view.flex.size(CGSize(width: 100, height: 300))
    XCTAssertEqual(view.flex.width, 100)
    XCTAssertEqual(view.flex.height, 300)
  }

  func testMinSizeWidth() {
    let view = UIView()
    view.flex.minSize(width: 200)
    XCTAssertEqual(view.flex.minWidth, 200)
  }

  func testMinSizeHeight() {
    let view = UIView()
    view.flex.minSize(height: 200)
    XCTAssertEqual(view.flex.minHeight, 200)
  }

  func testMinSizePoint() {
    let view = UIView()
    view.flex.minSize(width: 100, height: 300)
    XCTAssertEqual(view.flex.minWidth, 100)
    XCTAssertEqual(view.flex.minHeight, 300)
  }

  func testMinSizePercent() {
    let view = UIView()
    view.flex.minSize(width: 50%, height: 20%)
    XCTAssertEqual(view.flex.minWidth, 50%)
    XCTAssertEqual(view.flex.minHeight, 20%)
  }

  func testMinSizeWithCGSize() {
    let view = UIView()
    view.flex.minSize(CGSize(width: 100, height: 300))
    XCTAssertEqual(view.flex.minWidth, 100)
    XCTAssertEqual(view.flex.minHeight, 300)
  }

  func testMaxSizeWidth() {
    let view = UIView()
    view.flex.maxSize(width: 200)
    XCTAssertEqual(view.flex.maxWidth, 200)
  }

  func testMaxSizeHeight() {
    let view = UIView()
    view.flex.maxSize(height: 200)
    XCTAssertEqual(view.flex.maxHeight, 200)
  }

  func testMaxSizePoint() {
    let view = UIView()
    view.flex.maxSize(width: 100, height: 300)
    XCTAssertEqual(view.flex.maxWidth, 100)
    XCTAssertEqual(view.flex.maxHeight, 300)
  }

  func testMaxSizePercent() {
    let view = UIView()
    view.flex.maxSize(width: 50%, height: 20%)
    XCTAssertEqual(view.flex.maxWidth, 50%)
    XCTAssertEqual(view.flex.maxHeight, 20%)
  }

  func testMaxSizeWithCGSize() {
    let view = UIView()
    view.flex.maxSize(CGSize(width: 100, height: 300))
    XCTAssertEqual(view.flex.maxWidth, 100)
    XCTAssertEqual(view.flex.maxHeight, 300)
  }

  func testBorderWidthTop() {
    let view = UIView()
    view.flex.borderWidth(top: 10)
    XCTAssertEqual(view.flex.borderWidthTop, 10)
    XCTAssertNil(view.flex.borderWidthLeft)
    XCTAssertNil(view.flex.borderWidthBottom)
    XCTAssertNil(view.flex.borderWidthRight)
  }

  func testBorderWidthLeft() {
    let view = UIView()
    view.flex.borderWidth(left: 10)
    XCTAssertNil(view.flex.borderWidthTop)
    XCTAssertEqual(view.flex.borderWidthLeft, 10)
    XCTAssertNil(view.flex.borderWidthBottom)
    XCTAssertNil(view.flex.borderWidthRight)
  }

  func testBorderWidthBottom() {
    let view = UIView()
    view.flex.borderWidth(bottom: 10)
    XCTAssertNil(view.flex.borderWidthTop)
    XCTAssertNil(view.flex.borderWidthLeft)
    XCTAssertEqual(view.flex.borderWidthBottom, 10)
    XCTAssertNil(view.flex.borderWidthRight)
  }

  func testBorderWidthRight() {
    let view = UIView()
    view.flex.borderWidth(right: 10)
    XCTAssertNil(view.flex.borderWidthTop)
    XCTAssertNil(view.flex.borderWidthLeft)
    XCTAssertNil(view.flex.borderWidthBottom)
    XCTAssertEqual(view.flex.borderWidthRight, 10)
  }

  func testBorderWidth() {
    let view = UIView()
    view.flex.borderWidth(top: 10, left: 20, bottom: 30, right: 40)
    XCTAssertEqual(view.flex.borderWidthTop, 10)
    XCTAssertEqual(view.flex.borderWidthLeft, 20)
    XCTAssertEqual(view.flex.borderWidthBottom, 30)
    XCTAssertEqual(view.flex.borderWidthRight, 40)
  }

  func testCombination() {
    let view = UIView()
    view.flex
      .column()
      .padding(top: 20, bottom: 20)
      .align(items: .start)
      .align(content: .end)
  }

  func testEnable() {
    let view = UIView()
    XCTAssertFalse(view.flex.isEnabled)
    view.flex
      .enable()
      .grow(1)
      .shrink(1)

    XCTAssertTrue(view.flex.isEnabled)
  }

  func testDisable() {
    let view = UIView()
    XCTAssertFalse(view.flex.isEnabled)
    view.flex.enable()
    XCTAssertTrue(view.flex.isEnabled)
    view.flex.disable()
    XCTAssertFalse(view.flex.isEnabled)
  }
}
