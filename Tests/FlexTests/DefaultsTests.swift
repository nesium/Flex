//
//  DefaultsTests.swift
//  FlexTests
//
//  Created by Marc Bauer on 13.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

@testable import Flex
import UIKit
import XCTest

final class DefaultsTests: XCTestCase {
  func testDefaults() {
    let view = UIView()

    XCTAssertEqual(view.flex.direction, .column)
    XCTAssertEqual(view.flex.justifyContent, .start)
    XCTAssertEqual(view.flex.alignContent, .start)
    XCTAssertEqual(view.flex.alignItems, .stretch)
    XCTAssertEqual(view.flex.alignSelf, .auto)
    XCTAssertEqual(view.flex.position, .relative)
    XCTAssertEqual(view.flex.wrap, .noWrap)
    XCTAssertEqual(view.flex.overflow, .visible)
    XCTAssertEqual(view.flex.display, .flex)

    XCTAssertEqual(view.flex.grow, 0)
    XCTAssertEqual(view.flex.shrink, 0)
    XCTAssertEqual(view.flex.basis, .auto)

    XCTAssertNil(view.flex.top)
    XCTAssertNil(view.flex.left)
    XCTAssertNil(view.flex.bottom)
    XCTAssertNil(view.flex.right)
    XCTAssertNil(view.flex.start)
    XCTAssertNil(view.flex.end)

    XCTAssertNil(view.flex.marginTop)
    XCTAssertNil(view.flex.marginLeft)
    XCTAssertNil(view.flex.marginBottom)
    XCTAssertNil(view.flex.marginRight)
    XCTAssertNil(view.flex.marginStart)
    XCTAssertNil(view.flex.marginEnd)
    XCTAssertNil(view.flex.marginHorizontal)
    XCTAssertNil(view.flex.marginVertical)

    XCTAssertNil(view.flex.paddingTop)
    XCTAssertNil(view.flex.paddingLeft)
    XCTAssertNil(view.flex.paddingBottom)
    XCTAssertNil(view.flex.paddingRight)
    XCTAssertNil(view.flex.paddingStart)
    XCTAssertNil(view.flex.paddingEnd)
    XCTAssertNil(view.flex.paddingHorizontal)
    XCTAssertNil(view.flex.paddingVertical)

    XCTAssertNil(view.flex.borderWidthTop)
    XCTAssertNil(view.flex.borderWidthLeft)
    XCTAssertNil(view.flex.borderWidthBottom)
    XCTAssertNil(view.flex.borderWidthRight)
    XCTAssertNil(view.flex.borderWidthStart)
    XCTAssertNil(view.flex.borderWidthEnd)

    XCTAssertEqual(view.flex.width, .auto)
    XCTAssertEqual(view.flex.height, .auto)
    XCTAssertNil(view.flex.minWidth)
    XCTAssertNil(view.flex.minHeight)
    XCTAssertNil(view.flex.maxWidth)
    XCTAssertNil(view.flex.maxHeight)
    XCTAssertNil(view.flex.aspectRatio)
  }
}
