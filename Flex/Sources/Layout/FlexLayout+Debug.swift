//
//  FlexLayout+Debug.swift
//  Flex
//
//  Created by Marc Bauer on 14.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

import Foundation
import Yoga

extension FlexLayout: CustomDebugStringConvertible {
  public var debugDescription: String {
    return NSStringFromNode(self.node, YGPrintOptionsStyle)
  }
}
