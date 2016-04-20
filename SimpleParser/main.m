//
//  main.m
//  SimpleParser
//
//  Created by Mitty on 16/4/21.
//  Copyright © 2016年 Disney. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Parser.h"

void printWhenLucky(ParseNode *node) {
    printf("%s\n", [node.result UTF8String]);
    for (ParseNode *subNode in node.subNodes) {
        printf("%s | ", [subNode.result UTF8String]);
    }
    printf("\n");
}

void print(ParseNode *node) {
    if (node.error) {
        printf("\nparse fail\n %s\n", [[node.error localizedDescription] UTF8String]);
    } else {
        printf("\nparse success\n");
        printWhenLucky(node);
    }
}


int main(int argc, char * argv[]) {
    @autoreleasepool {
        { // Test Lucky
            OrigNode *origRoot = [OrigNode new];
            origRoot.content = @"value:origValue1";
            OrigNode *origNode2 = [OrigNode new];
            origNode2.content = @"value:origValue2";
            OrigNode *origNode3 = [OrigNode new];
            origNode3.content = @"value:origValue3";
            origRoot.children = @[origNode2, origNode3];
            
            
            ParseNode *parseResult = [Parser parseTree:origRoot];
            print(parseResult);
        }
        
        { // Test Error
            OrigNode *origRoot = [OrigNode new];
            origRoot.content = @"value:origValue1";
            OrigNode *origNode2 = [OrigNode new];
            origNode2.content = @"eulav:origValue2";
            OrigNode *origNode3 = [OrigNode new];
            origNode3.content = @"value:origValue3";
            origRoot.children = @[origNode2, origNode3];
            
            ParseNode *parseResult = [Parser parseTree:origRoot];
            print(parseResult);
        }
    }
}
