//
//  xxx.m
//  notiDemo
//
//  Created by Mitty on 16/4/20.
//  Copyright © 2016年 Disney. All rights reserved.
//

#import "Parser.h"
#import <libkern/OSAtomic.h>

volatile uint32_t _isShouldCancel;

id parseStr(NSString *content, NSError **error){
    // TODO:操作字符串解释，生成解释结果或者错误
    if ([content hasPrefix:@"value:"]) {
        return [content stringByReplacingOccurrencesOfString:@"value:" withString:@""];
    } else {
        *error = [NSError errorWithDomain:@"com.parser.mitty" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"不含标识符"}];
    }
    return nil;
}

void assembleParseResult(ParseNode *node, id result, NSError *error) {
    if (error) {
        OSAtomicOr32Barrier(1, &_isShouldCancel);
        node.error = error;
    } else {
        node.result = result;
    }
}

@implementation Parser

+ (ParseNode *) parseTree:(OrigNode *)treeNode {
    ParseNode *treeParseNode = [ParseNode new];
    treeParseNode.subNodes = [NSMutableArray new];
    
    NSError *error;                                     // 解释自身数据
    id result = parseStr([treeNode content], &error);
    assembleParseResult(treeParseNode, result, error);
    
    if (_isShouldCancel) {
        return treeParseNode;
    }
    
    [[treeNode children] enumerateObjectsUsingBlock:^(OrigNode *child, NSUInteger idx, BOOL *stop) { // 解释子结点数据
        @autoreleasepool {
            if (_isShouldCancel != 0) { // 检查其它分支可能出错
                *stop = YES;
            } else {
                ParseNode *checkResult = [self parseTree:child];  // 解释子结点数据
                if (checkResult.error) {
                    treeParseNode.error = checkResult.error;      // 收集子结点错误
                    OSAtomicOr32Barrier(1, &_isShouldCancel);
                    * stop = YES;
                } else {
                    [treeParseNode.subNodes addObject:checkResult];
                }
            }
        }
    }];
    return treeParseNode;
}


@end
