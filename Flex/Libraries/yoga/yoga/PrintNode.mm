//
//  PrintNode.m
//  Flex
//
//  Created by Marc Bauer on 14.12.18.
//  Copyright © 2018 Marc Bauer. All rights reserved.
//

#ifdef DEBUG
#import "PrintNode.h"
#include <string>
#include "YGNodePrint.h"

NSString *NSStringFromNode(YGNodeRef node, YGPrintOptions options) {
  std::string str;
  facebook::yoga::YGNodeToString(str, node, options, 0);
  return [[NSString alloc] initWithCString:str.c_str() encoding:NSUTF8StringEncoding];
}
#endif
