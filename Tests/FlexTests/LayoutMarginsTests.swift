//
//  LayoutMarginsTests.swift
//  
//
//  Created by Marc Bauer on 12.04.20.
//

import Flex
import SnapshotTesting
import UIKit
import XCTest

final class LayoutMarginsTests: XCTestCase {
  func testRespectsLayoutMarginsWhenLayouting() {
    let container = ContainerView()

    let view1 = UIView()
    container.flex
      .addChild(view1)
      .grow(1)

    let view2 = UIView()
    container.flex
      .addChild(view2)
      .grow(1)

    container.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    container.layoutMargins = UIEdgeInsets(top: 5, left: 7, bottom: 11, right: 13)

    container.flex.layoutSubviews()

    XCTAssertEqual(view1.frame, CGRect(x: 0, y: 0, width: 100, height: 50))
    XCTAssertEqual(view2.frame, CGRect(x: 0, y: 50, width: 100, height: 50))

    container.flex.layoutSubviews(respectingLayoutMargins: true)

    XCTAssertEqual(view1.frame, CGRect(x: 7, y: 5, width: 80, height: 42))
    XCTAssertEqual(view2.frame, CGRect(x: 7, y: 47, width: 80, height: 42))
  }
}
