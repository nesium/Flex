@testable import Flex
import SnapshotTesting
import UIKit
import XCTest
import Yoga

final class NestingTests: XCTestCase {
  func testNestingContainerViews() {
    let container = ContainerView()
    container.flex
      .enable()
      .column()

    let body = UIView()
    body.flex
      .enable()
      .grow(1)

    let footerChild = TestView(intrinsicSize: CGSize(width: 200, height: 40))

    let footer = ContainerView()
    footer.addSubview(footerChild)
    footer.flex.enable()

    container.addSubview(body)
    container.addSubview(footer)

    container.frame = CGRect(x: 0, y: 0, width: 200, height: 300)
    container.layoutIfNeeded()

    let expectedContainerFrame = CGRect(x: 0, y: 0, width: 200, height: 300)
    let expectedBodyFrame = CGRect(x: 0, y: 0, width: 200, height: 260)
    let expectedFooterFrame = CGRect(x: 0, y: 260, width: 200, height: 40)
    let expectedFooterChildFrame = CGRect(x: 0, y: 0, width: 200, height: 40)

    XCTAssertEqual(container.frame, expectedContainerFrame)
    XCTAssertEqual(body.frame, expectedBodyFrame)
    XCTAssertEqual(footer.frame, expectedFooterFrame)
    XCTAssertEqual(footerChild.frame, expectedFooterChildFrame)

    footer.setNeedsLayout()
    footer.layoutIfNeeded()
    container.setNeedsLayout()
    container.layoutIfNeeded()

    XCTAssertEqual(container.frame, expectedContainerFrame)
    XCTAssertEqual(body.frame, expectedBodyFrame)
    XCTAssertEqual(footer.frame, expectedFooterFrame)
    XCTAssertEqual(footerChild.frame, expectedFooterChildFrame)

    XCTAssertEqual(
      footer.sizeThatFits(
        CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
      ),
      CGSize(width: 200, height: 40)
    )

    footer.setNeedsLayout()
    footer.layoutIfNeeded()
    container.setNeedsLayout()
    container.layoutIfNeeded()

    XCTAssertEqual(container.frame, expectedContainerFrame)
    XCTAssertEqual(body.frame, expectedBodyFrame)
    XCTAssertEqual(footer.frame, expectedFooterFrame)
    XCTAssertEqual(footerChild.frame, expectedFooterChildFrame)
  }

  func testMixAndMatchNesting() {
    final class ManualLayoutView: UIView {
      private let childView: UIView

      init(childView: UIView) {
        self.childView = childView
        super.init(frame: .zero)
        self.addSubview(childView)
      }

      required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
      }

      override func sizeThatFits(_ size: CGSize) -> CGSize {
        self.childView.sizeThatFits(size)
      }

      override func layoutSubviews() {
        super.layoutSubviews()
        self.childView.frame = self.bounds
      }
    }

    let outerContainer = ContainerView()
    outerContainer.flex
      .enable()
      .column()
      .padding(top: 40)

    let innerContainer = ContainerView()
    innerContainer.flex
      .enable()
      .row()
      .padding(left: 10, right: 10)

    let leftChild = UIView()
    let rightChild = UIView()

    innerContainer.flex
      .addChild(leftChild)
      .grow(1)
    innerContainer.flex
      .addChild(rightChild)
      .grow(1)

    let innerManual = ManualLayoutView(childView: innerContainer)
    let outerManual = ManualLayoutView(childView: innerManual)

    outerContainer.flex
      .addChild(outerManual)
      .grow(1)

    let expectedOuterContainerFrame = CGRect(x: 0, y: 0, width: 300, height: 100)
    let expectedOuterManualFrame = CGRect(x: 0, y: 40, width: 300, height: 60)
    let expectedInnerManualFrame = CGRect(x: 0, y: 0, width: 300, height: 60)
    let expectedInnerContainerFrame = CGRect(x: 0, y: 0, width: 300, height: 60)
    let expectedLeftChildFrame = CGRect(x: 10, y: 0, width: 140, height: 60)
    let expectedRightChildFrame = CGRect(x: 150, y: 0, width: 140, height: 60)

    outerContainer.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
    outerContainer.layoutIfNeeded()

    XCTAssertEqual(outerContainer.frame, expectedOuterContainerFrame)
    XCTAssertEqual(outerManual.frame, expectedOuterManualFrame)
    XCTAssertEqual(innerManual.frame, expectedInnerManualFrame)
    XCTAssertEqual(innerContainer.frame, expectedInnerContainerFrame)
    XCTAssertEqual(leftChild.frame, expectedLeftChildFrame)
    XCTAssertEqual(rightChild.frame, expectedRightChildFrame)

    innerContainer.setNeedsLayout()
    innerContainer.layoutSubviews()

    XCTAssertEqual(outerContainer.frame, expectedOuterContainerFrame)
    XCTAssertEqual(outerManual.frame, expectedOuterManualFrame)
    XCTAssertEqual(innerManual.frame, expectedInnerManualFrame)
    XCTAssertEqual(innerContainer.frame, expectedInnerContainerFrame)
    XCTAssertEqual(leftChild.frame, expectedLeftChildFrame)
    XCTAssertEqual(rightChild.frame, expectedRightChildFrame)

    outerContainer.setNeedsLayout()
    outerContainer.layoutSubviews()

    XCTAssertEqual(outerContainer.frame, expectedOuterContainerFrame)
    XCTAssertEqual(outerManual.frame, expectedOuterManualFrame)
    XCTAssertEqual(innerManual.frame, expectedInnerManualFrame)
    XCTAssertEqual(innerContainer.frame, expectedInnerContainerFrame)
    XCTAssertEqual(leftChild.frame, expectedLeftChildFrame)
    XCTAssertEqual(rightChild.frame, expectedRightChildFrame)
  }

  func testMixedUpLayoutOrder() {
    let innerContainer = ContainerView()
    let leftChild = UIView()
    let rightChild = UIView()

    innerContainer.flex
      .addChild(leftChild)
      .grow(1)

    let outerContainer = ContainerView()
    outerContainer.flex.enable()

    outerContainer.frame = CGRect(x: 0, y: 0, width: 200, height: 40)

    outerContainer.flex
      .addChild(innerContainer)
      .row()
      .grow(1)

    outerContainer.layoutIfNeeded()

    innerContainer.flex
      .addChild(rightChild)
      .grow(1)

    XCTAssertTrue(YGNodeIsDirty(rightChild.flex.node))

    XCTAssertNoThrow(innerContainer.layoutIfNeeded(), "CALayer position should not contain NaN")

    let expectedOuterContainerFrame = CGRect(x: 0, y: 0, width: 200, height: 40)
    let expectedInnerContainerFrame = CGRect(x: 0, y: 0, width: 200, height: 40)
    let expectedLeftChildFrame = CGRect(x: 0, y: 0, width: 100, height: 40)
    let expectedRightChildFrame = CGRect(x: 100, y: 0, width: 100, height: 40)

    XCTAssertEqual(outerContainer.frame, expectedOuterContainerFrame)
    XCTAssertEqual(innerContainer.frame, expectedInnerContainerFrame)
    XCTAssertEqual(leftChild.frame, expectedLeftChildFrame)
    XCTAssertEqual(rightChild.frame, expectedRightChildFrame)
  }
}
