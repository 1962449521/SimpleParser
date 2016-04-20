//
//  OrigNode.h
//  notiDemo
//
//  Created by Mitty on 16/4/21.
//  Copyright © 2016年 Disney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrigNode:NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray<OrigNode *> *children;

@end
