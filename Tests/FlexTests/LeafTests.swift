//
//  LeafTests.swift
//  
//
//  Created by Marc Bauer on 15.03.20.
//

@testable import Flex
import UIKit
import XCTest

final class LeafTests: XCTestCase {
  func testDirtyingDoesNotCrashAfterRemovingLastChild() {
    let view = UIView(frame: .init(x: 0, y: 0, width: 200, height: 200))
    view.flex.enable()

    let child = UIView()
    view.flex.addChild(child).grow(1)

    view.flex.layoutSubviews()

    XCTAssertEqual(child.frame.width, 200)
    XCTAssertEqual(child.frame.height, 200)
    XCTAssertEqual(view.flex.numberOfChildren, 1)

    child.removeFromSuperview()

    XCTAssertNoThrow(view.flex.setIsDirty())
  }
}
