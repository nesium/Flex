//
//  FlexLayout+Debug.swift
//  Flex
//
//  Created by Marc Bauer on 23.02.20.
//

import CoreGraphics
import Foundation

extension FlexLayout {
  @discardableResult
  public func enable() -> FlexLayout {
    self.isEnabled = true
    return self
  }

  @discardableResult
  public func disable() -> FlexLayout {
    self.isEnabled = false
    return self
  }

  @discardableResult
  public func excludeFromLayout() -> FlexLayout {
    self.isIncludedInLayout = false
    return self
  }

  @discardableResult
  public func includeInLayout() -> FlexLayout {
    self.isIncludedInLayout = true
    return self
  }

  /// Stacks the flex items in `.column` direction, or if `reverse` is `true` in
  /// the `.columnReverse` direction.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/css/css3_flexbox.asp#flex-direction).
  @discardableResult
  public func column(reverse: Bool = false) -> FlexLayout {
    self.direction = reverse ? .columnReverse : .column
    return self
  }

  /// Stacks the flex items in `.row` direction, or if `reverse` is `true` in
  /// the `.rowReverse` direction.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/css/css3_flexbox.asp#flex-direction).
  @discardableResult
  public func row(reverse: Bool = false) -> FlexLayout {
    self.direction = reverse ? .rowReverse : .row
    return self
  }

  /// Positions the element.
  ///
  /// An absolute positioned element is positioned relative to the nearest positioned ancestor.
  /// However, if an absolute positioned element has no positioned ancestors, it uses the
  /// document body, and moves along with page scrolling.
  ///
  /// Setting the top, right, bottom, and left properties of a relatively-positioned element will
  /// cause it to be adjusted away from its normal position. Other content will not be adjusted to
  /// fit into any gap left by the element.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/css/css_positioning.asp).
  @discardableResult
  public func position(_ position: Position) -> FlexLayout {
    self.position = position
    return self
  }

  /// Aligns the flex items.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/css/css3_flexbox.asp#justify-content).
  @discardableResult
  public func justify(content justify: Justify) -> FlexLayout {
    self.justifyContent = justify
    return self
  }

  /// Aligns the flex lines.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/css/css3_flexbox.asp#align-content).
  @discardableResult
  public func align(content align: Align) -> FlexLayout {
    self.alignContent = align
    return self
  }

  /// Aligns the flex items vertically.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/css/css3_flexbox.asp#align-items).
  @discardableResult
  public func align(items align: Align) -> FlexLayout {
    self.alignItems = align
    return self
  }

  /// Specifies the alignment for the selected item inside the flexible container.
  ///
  /// The alignSelf property overrides the default alignment set by the container's
  /// alignItems property.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/css/css3_flexbox.asp#align-self).
  @discardableResult
  public func align(self align: Align) -> FlexLayout {
    self.alignSelf = align
    return self
  }

  /// Specifies whether the flex items should wrap or not.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/css/css3_flexbox.asp#flex-wrap).
  @discardableResult
  public func wrap(_ wrap: Wrap) -> FlexLayout {
    self.wrap = wrap
    return self
  }

  /// Controls what happens to content that is too big to fit into an area.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/css/css_overflow.asp).
  @discardableResult
  public func overflow(_ overflow: Overflow) -> FlexLayout {
    self.overflow = overflow
    return self
  }

  /// Specifies if/how an element is displayed.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/css/css_display_visibility.asp).
  @discardableResult
  public func display(_ display: Display) -> FlexLayout {
    self.display = display
    return self
  }

  /// Specifies how much a flex item will grow relative to the rest of the flex items.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/css/css3_flexbox.asp#flex-grow).
  @discardableResult
  public func grow(_ grow: CGFloat) -> FlexLayout {
    self.grow = grow
    return self
  }

  /// Specifies how much a flex item will shrink relative to the rest of the flex items.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/css/css3_flexbox.asp#flex-shrink).
  @discardableResult
  public func shrink(_ shrink: CGFloat) -> FlexLayout {
    self.shrink = shrink
    return self
  }

  /// Specifies the initial length of a flex item.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/css/css3_flexbox.asp#flex-basis).
  @discardableResult
  public func basis(_ basis: AutoValue) -> FlexLayout {
    self.basis = basis
    return self
  }

  /// Defines the top/left/bottom/right values of a positioned element. Setting these properties
  /// has no effect on non-positioned elements.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/cssref/pr_pos_top.asp).
  @discardableResult
  public func position(
    top: Value? = nil,
    left: Value? = nil,
    bottom: Value? = nil,
    right: Value? = nil
  ) -> FlexLayout {
    top.map { self.top = $0 }
    left.map { self.left = $0 }
    bottom.map { self.bottom = $0 }
    right.map { self.right = $0 }
    return self
  }

  /// Sets the width and height of an element. These dimensions do not include padding, borders,
  /// or margins.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/cssref/pr_dim_width.asp).
  @discardableResult
  public func size(width: AutoValue? = nil, height: AutoValue? = nil) -> FlexLayout {
    width.map { self.width = $0 }
    height.map { self.height = $0 }
    return self
  }

  /// Sets the minimum width and height of an element.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/cssref/pr_dim_min-width.asp).
  @discardableResult
  public func minSize(width: Value? = nil, height: Value? = nil) -> FlexLayout {
    width.map { self.minWidth = $0 }
    height.map { self.minHeight = $0 }
    return self
  }

  /// Sets the maximum width and height of an element.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/cssref/pr_dim_max-width.asp).
  @discardableResult
  public func maxSize(width: Value? = nil, height: Value? = nil) -> FlexLayout {
    width.map { self.maxWidth = $0 }
    height.map { self.maxHeight = $0 }
    return self
  }

  /// Sets the padding of an element. An element's padding is the space between its content
  /// and its border.
  ///
  /// Padding creates extra space within an element, while margin creates extra space around
  /// an element.
  /// For more information see [w3schools](https://www.w3schools.com/cssref/pr_padding.asp).
  @discardableResult
  public func padding(
    top: Value? = nil,
    left: Value? = nil,
    bottom: Value? = nil,
    right: Value? = nil
  ) -> FlexLayout {
    top.map { self.paddingTop = $0 }
    left.map { self.paddingLeft = $0 }
    bottom.map { self.paddingBottom = $0 }
    right.map { self.paddingRight = $0 }
    return self
  }

  /// Sets the margin of an element. An element's margin is the space between its content
  /// and its border.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/cssref/pr_margin.asp).
  @discardableResult
  public func margin(
    top: AutoValue? = nil,
    left: AutoValue? = nil,
    bottom: AutoValue? = nil,
    right: AutoValue? = nil
  ) -> FlexLayout {
    top.map { self.marginTop = $0 }
    left.map { self.marginLeft = $0 }
    bottom.map { self.marginBottom = $0 }
    right.map { self.marginRight = $0 }
    return self
  }

  /// Sets the width of an element's four borders.
  ///
  /// For more information see [w3schools](https://www.w3schools.com/cssref/pr_border-width.asp).
  @discardableResult
  public func borderWidth(
    top: CGFloat? = nil,
    left: CGFloat? = nil,
    bottom: CGFloat? = nil,
    right: CGFloat? = nil
  ) -> FlexLayout {
    top.map { self.borderWidthTop = $0 }
    left.map { self.borderWidthLeft = $0 }
    bottom.map { self.borderWidthBottom = $0 }
    right.map { self.borderWidthRight = $0 }
    return self
  }
}
