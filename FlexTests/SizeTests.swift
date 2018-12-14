//
//  SizeTests.swift
//  FlexTests
//
//  Created by Marc Bauer on 13.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

import Flex
import UIKit
import XCTest

final class SizeTests: XCTestCase {
  func testPointDimensions() {
    let parent = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    parent.flex.enabled = true

    let child = UIView()
    parent.addSubview(child)

    child.flex.style {
      $0.enabled = true
      $0.width = 150
      $0.height = 100
    }

    parent.flex.layoutSubviews()

    XCTAssertEqual(parent.frame, CGRect(x: 0, y: 0, width: 300, height: 300))
    XCTAssertEqual(child.frame, CGRect(x: 0, y: 0, width: 150, height: 100))
  }

  func testPercentDimensions() {
    let parent = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    parent.flex.enabled = true

    let child = UIView()
    parent.addSubview(child)

    child.flex.style {
      $0.enabled = true
      $0.width = 50%
      $0.height = 20%
    }

    parent.flex.layoutSubviews()

    XCTAssertEqual(parent.frame, CGRect(x: 0, y: 0, width: 300, height: 300))
    XCTAssertEqual(child.frame, CGRect(x: 0, y: 0, width: 150, height: 60))
  }

  func testMinSize() {
    let parent = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    parent.flex.enabled = true
    parent.flex.alignItems = .start

    let child = TestView(intrinsicSize: CGSize(width: 10, height: 10))
    parent.addSubview(child)

    parent.flex.layoutSubviews()

    XCTAssertEqual(child.frame, CGRect(x: 0, y: 0, width: 10, height: 10))

    child.flex.style {
      $0.minWidth = 30
      $0.minHeight = 50
    }

    parent.flex.layoutSubviews()

    XCTAssertEqual(child.frame, CGRect(x: 0, y: 0, width: 30, height: 50))

    XCTAssertEqual(child.flex.minWidth, .point(30))
    child.flex.minWidth = nil
    XCTAssertNil(child.flex.minWidth)

    XCTAssertEqual(child.flex.minHeight, .point(50))
    child.flex.minHeight = nil
    XCTAssertNil(child.flex.minHeight)
  }

  func testMaxSize() {
    let parent = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    parent.flex.enabled = true
    parent.flex.alignItems = .start

    let child = TestView(intrinsicSize: CGSize(width: 200, height: 200))
    parent.addSubview(child)

    parent.flex.layoutSubviews()

    XCTAssertEqual(child.frame, CGRect(x: 0, y: 0, width: 200, height: 200))

    child.flex.style {
      $0.maxWidth = 100
      $0.maxHeight = 150
    }

    parent.flex.layoutSubviews()

    XCTAssertEqual(child.frame, CGRect(x: 0, y: 0, width: 100, height: 150))

    XCTAssertEqual(child.flex.maxWidth, .point(100))
    child.flex.maxWidth = nil
    XCTAssertNil(child.flex.maxWidth)

    XCTAssertEqual(child.flex.maxHeight, .point(150))
    child.flex.maxHeight = nil
    XCTAssertNil(child.flex.maxHeight)
  }

  func testAutoMargin() {
    let parent = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    parent.flex.enabled = true

    let child = UIView()
    parent.addSubview(child)

    child.flex.style {
      $0.enabled = true
      $0.width = 100
      $0.height = 100
      $0.margin = (.auto, .auto, 10, 20)
    }

    parent.flex.layoutSubviews()

    XCTAssertEqual(child.frame, CGRect(x: 180, y: 190, width: 100, height: 100))
  }
}
