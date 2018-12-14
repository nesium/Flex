//
//  FlexLayoutConfiguration.swift
//  Flex
//
//  Created by Marc Bauer on 13.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

import Foundation

public final class FlexLayoutConfiguration {
  public static let shared = FlexLayoutConfiguration()

  public var screenScale: CGFloat = UIScreen.main.scale
  public var printLayoutTree = false

  internal func round(_ value: CGFloat) -> CGFloat {
    return (value * self.screenScale).rounded(.toNearestOrAwayFromZero) / self.screenScale
  }

  internal func ceil(_ value: CGFloat) -> CGFloat {
    return (value * self.screenScale).rounded(.up) / self.screenScale
  }
}
