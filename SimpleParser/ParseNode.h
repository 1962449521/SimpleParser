//
//  ParseNode.h
//  notiDemo
//
//  Created by Mitty on 16/4/21.
//  Copyright © 2016年 Disney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseNode : NSObject

@property (nonatomic, strong) id result;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSMutableArray<ParseNode *> *subNodes;

@end
