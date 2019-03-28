//
//  FlexLayout.swift
//  Flex
//
//  Created by Marc Bauer on 13.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

// This is in large parts a translation of YogaKit
// Source: https://github.com/facebook/yoga/tree/master/YogaKit

import UIKit
import Yoga

public final class FlexLayout {
  public var enabled = false
  public var includedInLayout = true

  public var isDirty: Bool {
    return YGNodeIsDirty(self.node)
  }

  public var intrinsicSize: CGSize {
    return self.sizeThatFits(
      CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    )
  }

  public enum Direction {
    case column
    case columnReverse
    case row
    case rowReverse
  }

  public enum Value {
    case point(CGFloat)
    case percent(CGFloat)
  }

  public enum AutoValue {
    case point(CGFloat)
    case percent(CGFloat)
    case auto
  }

  public enum Justify {
    case start
    case center
    case end
    case spaceBetween
    case spaceAround
    case spaceEvenly
  }

  public enum Align {
    case auto
    case start
    case center
    case end
    case stretch
    case baseline
    case spaceBetween
    case spaceAround
  }

  public enum Position {
    case absolute
    case relative
  }

  public enum Wrap {
    case noWrap
    case wrap
    case wrapReverse
  }

  public enum Overflow {
    case visible
    case hidden
    case scroll
  }

  public enum Display {
    case flex
    case none
  }

  public typealias Margin = (AutoValue?, AutoValue?, AutoValue?, AutoValue?)

  private unowned let owner: UIView
  private let ownerIsPlainView: Bool

  internal let node: YGNodeRef

  private let round: (CGFloat) -> (CGFloat)
  private let ceil: (CGFloat) -> (CGFloat)

  // MARK: - Initialization -

  internal init(owner: UIView) {
    self.owner = owner
    self.ownerIsPlainView = type(of: owner) == UIView.self

    let config = YGConfigNew()
    YGConfigSetExperimentalFeatureEnabled(config, YGExperimentalFeatureWebFlexBasis, true)
    YGConfigSetPointScaleFactor(config, 0)
    YGConfigSetPrintTreeFlag(config, FlexLayoutConfiguration.shared.printLayoutTree)

    self.node = YGNodeNewWithConfig(config)
    self.round = FlexLayoutConfiguration.shared.round
    self.ceil = FlexLayoutConfiguration.shared.ceil

    YGNodeSetContext(self.node, Unmanaged.passUnretained(self.owner).toOpaque())
  }

  deinit {
    YGNodeFree(self.node)
  }

  // MARK: - Public Methods -

  public func style(with handler: (FlexLayout) -> ()) {
    handler(self)
  }

  public func sizeThatFits(_ size: CGSize) -> CGSize {
    return self.calculateLayout(with: CGSize(
      width: size.width == CGFloat.greatestFiniteMagnitude ? CGFloat(YGValueUndefined.value) : size.width,
      height: size.height == CGFloat.greatestFiniteMagnitude ? CGFloat(YGValueUndefined.value) : size.height
    ))
  }

  public func layoutSubviews() {
    guard self.enabled, !self.isLeaf else {
      return
    }

    self.calculateLayout(with: self.owner.bounds.size)

    self.owner.subviews.forEach { subview in
      FlexLayout.applyLayoutToViewHierarchy(in: subview, round: self.round, ceil: self.ceil)
    }
  }

  public func setIsDirty() {
    guard !self.isDirty, self.isLeaf else {
      return
    }

    // Yoga is not happy if we try to mark a node as "dirty" before we have set
    // the measure function. Since we already know that this is a leaf,
    // this *should* be fine. Forgive me Hack Gods.
    if (YGNodeGetMeasureFunc(self.node) == nil) {
      YGNodeSetMeasureFunc(self.node) { node, width, widthMode, height, heightMode in
        FlexLayout.measureView(
          node: node,
          width: width,
          widthMode: widthMode,
          height: height,
          heightMode: heightMode
        )
      }
    }

    YGNodeMarkDirty(node)
  }

  // MARK: - Internal Methods -

  internal var isLeaf: Bool {
    guard self.enabled else {
      return true
    }

    return !self.owner.subviews.contains { subview in
      subview.flex.enabled
    }
  }

  internal var numberOfChildren: Int {
    return Int(YGNodeGetChildCount(self.node))
  }

  // MARK: - Private Methods -

  @discardableResult
  private func calculateLayout(with size: CGSize) -> CGSize {
    assert(self.enabled, "Yoga is not enabled for this view.")

    FlexLayout.attachNodesFromViewHierarchy(in: self.owner)

    YGNodeCalculateLayout(
      self.node,
      Float(size.width),
      Float(size.height),
      YGNodeStyleGetDirection(self.node)
    )

    // We round the rounded float again. Since on 64 Bit system, CGFloat is a Double, which can lead
    // to rounding problems when we simply use a float on @3x devices.
    return CGSize(
      width: self.round(CGFloat(YGNodeLayoutGetWidth(node))),
      height: self.round(CGFloat(YGNodeLayoutGetHeight(node)))
    )
  }

  private static func attachNodesFromViewHierarchy(in view: UIView) {
    let layout = view.flex
    let node = layout.node

    // Only leaf nodes should have a measure function
    guard !layout.isLeaf else {
      YGNodeRemoveAllChildren(node)
      YGNodeSetMeasureFunc(node) { node, width, widthMode, height, heightMode in
        FlexLayout.measureView(
          node: node,
          width: width,
          widthMode: widthMode,
          height: height,
          heightMode: heightMode
        )
      }
      return
    }

    YGNodeSetMeasureFunc(node, nil)

    let includedSubviews = view.subviews.filter { subview in
      let layout = subview.flex
      return layout.enabled && layout.includedInLayout
    }

    if !FlexLayout.children(in: node, equalTo: includedSubviews) {
      YGNodeRemoveAllChildren(node)
      includedSubviews.enumerated().forEach { idx, subview in
        YGNodeInsertChild(node, subview.flex.node, UInt32(idx))
      }
    }

    includedSubviews.forEach { subview in
      FlexLayout.attachNodesFromViewHierarchy(in: subview)
    }
  }

  private static func applyLayoutToViewHierarchy(
    in view: UIView,
    round: (CGFloat) -> (CGFloat),
    ceil: (CGFloat) -> (CGFloat)
  ) {
    let layout = view.flex

    guard layout.enabled, layout.includedInLayout else {
      return
    }

    let node = layout.node

    // This fixes a race condition which occurred when a child created another subchild while its
    // parent was already performing a layout.
    guard !YGNodeIsDirty(node) else {
      return
    }

    let alignmentRect = CGRect(
      x: CGFloat(YGNodeLayoutGetLeft(node)),
      y: CGFloat(YGNodeLayoutGetTop(node)),
      width: CGFloat(YGNodeLayoutGetWidth(node)),
      height: CGFloat(YGNodeLayoutGetHeight(node))
    )

    let frame = view.frame(forAlignmentRect: alignmentRect)

    view.frame = CGRect(
      x: round(frame.minX),
      y: round(frame.minY),
      width: ceil(frame.width),
      height: ceil(frame.height)
    )

    guard !layout.isLeaf else {
      return
    }

    view.subviews.forEach { subview in
      FlexLayout.applyLayoutToViewHierarchy(in: subview, round: round, ceil: ceil)
    }
  }

  private static func measureView(
    node: YGNodeRef?,
    width: Float,
    widthMode: YGMeasureMode,
    height: Float,
    heightMode: YGMeasureMode
  ) -> YGSize {
    let constrainedSize = CGSize(
      width: widthMode == YGMeasureModeUndefined
        ? CGFloat.greatestFiniteMagnitude
        : CGFloat(width),
      height: heightMode == YGMeasureModeUndefined
        ? CGFloat.greatestFiniteMagnitude
        : CGFloat(height)
    )

    let view: UIView = Unmanaged.fromOpaque(YGNodeGetContext(node!)!).takeUnretainedValue()

    let requiredSize: CGSize

    // The default implementation of sizeThatFits: returns the existing size of
    // the view. That means that if we want to layout an empty UIView, which
    // already has got a frame set, its measured size should be CGSizeZero, but
    // UIKit returns the existing size.
    //
    // See https://github.com/facebook/yoga/issues/606 for more information.
    if view.subviews.isEmpty, view.flex.ownerIsPlainView {
      requiredSize = .zero
    } else {
      requiredSize = view.alignmentRect(
        forFrame: CGRect(origin: .zero, size: view.sizeThatFits(constrainedSize))
      ).size
    }

    return YGSize(
      width: FlexLayout.sanitizeMeasurement(
        of: requiredSize.width,
        constrainedValue: constrainedSize.width,
        mode: widthMode
      ),
      height: FlexLayout.sanitizeMeasurement(
        of: requiredSize.height,
        constrainedValue: constrainedSize.height,
        mode: heightMode
      )
    )
  }

  private static func sanitizeMeasurement(
    of value: CGFloat,
    constrainedValue: CGFloat,
    mode: YGMeasureMode
  ) -> Float {
    switch mode.rawValue {
      case YGMeasureModeExactly.rawValue:
        return Float(constrainedValue)
      case YGMeasureModeAtMost.rawValue:
        return Float(min(value, constrainedValue))
      default:
        return Float(value)
    }
  }

  private static func children(in node: YGNodeRef, equalTo subviews: [UIView]) -> Bool {
    guard YGNodeGetChildCount(node) == subviews.count else {
      return false
    }

    for (idx, subview) in subviews.enumerated() {
      if YGNodeGetChild(node, UInt32(idx)) != subview.flex.node {
        return false
      }
    }

    return true
  }
}