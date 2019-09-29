//
//  FlexLayout+Debug.swift
//  Flex
//
//  Created by Marc Bauer on 14.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

#if DEBUG
import Foundation
import YogaDebug

extension FlexLayout: CustomDebugStringConvertible {
  public var debugDescription: String {
    return NSStringFromNode(self.node, YGPrintOptionsStyle)
  }
}
#endif
