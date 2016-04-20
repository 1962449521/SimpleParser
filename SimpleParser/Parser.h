//
//  xxx.h
//  notiDemo
//
//  Created by Mitty on 16/4/20.
//  Copyright © 2016年 Disney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrigNode.h"
#import "ParseNode.h"

@interface Parser : NSObject

+ (ParseNode *) parseTree:(OrigNode *)treeNode;

@end
