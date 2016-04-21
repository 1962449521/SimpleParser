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
    if ([node.subNodes count] > 0) {
        printf("%s:\n", [node.result UTF8String]);
    }

    for (ParseNode *subNode in node.subNodes) {
        printf(" | %s", [subNode.result UTF8String]);
    }
    if ([node.subNodes count] > 0) {
        printf(" |\n");
    }
    for (ParseNode *subNode in node.subNodes) {
        printWhenLucky(subNode);
    }
}

void print(ParseNode *node) {
    if (node.error) {
        printf("\nparse fail\n %s\n", [[node.error localizedDescription] UTF8String]);
    } else {
        printf("\nparse success tree: %s\n", [node.result UTF8String]);
        printWhenLucky(node);
    }
}


int main(int argc, char * argv[]) {
    @autoreleasepool {
        { // Test Lucky level 2
            OrigNode *origRoot = [OrigNode new];
            origRoot.content = @"value:origValue1";
            OrigNode *origNode2 = [OrigNode new];
            origNode2.content = @"value:origValue2";
            OrigNode *origNode3 = [OrigNode new];
            origNode3.content = @"value:origValue3";
            origRoot.children = @[origNode2, origNode3];
            
            Parser *parser = [Parser new];
            ParseNode *parseResult = [parser parseTree:origRoot];
            print(parseResult);
        }
        
        { // Test Error level 2
            OrigNode *origRoot = [OrigNode new];
            origRoot.content = @"value:origValue1";
            OrigNode *origNode2 = [OrigNode new];
            origNode2.content = @"eulav:origValue2";
            OrigNode *origNode3 = [OrigNode new];
            origNode3.content = @"value:origValue3";
            origRoot.children = @[origNode2, origNode3];
            
            Parser *parser = [Parser new];
            ParseNode *parseResult = [parser parseTree:origRoot];
            print(parseResult);
        }
        
        { // Test Lucky level 4
            OrigNode *origRoot = [OrigNode new];
            origRoot.content = @"value:origValue1";
            OrigNode *origNode2 = [OrigNode new];
            origNode2.content = @"value:origValue2";
            OrigNode *origNode3 = [OrigNode new];
            origNode3.content = @"value:origValue3";
            
            OrigNode *origNode4 = [OrigNode new];
            origNode4.content = @"value:origValue4";
            
            OrigNode *origNode5 = [OrigNode new];
            origNode5.content = @"value:origValue5";
            
            origNode4.children = @[origNode5];
            origNode2.children = @[origNode4];
            origRoot.children = @[origNode2, origNode3];

            Parser *parser = [Parser new];
            ParseNode *parseResult = [parser parseTree:origRoot];
            print(parseResult);
        }
        
        { // Test Error level 4
            OrigNode *origRoot = [OrigNode new];
            origRoot.content = @"value:origValue1";
            OrigNode *origNode2 = [OrigNode new];
            origNode2.content = @"value:origValue2";
            OrigNode *origNode3 = [OrigNode new];
            origNode3.content = @"eulav:origValue3";
            
            OrigNode *origNode4 = [OrigNode new];
            origNode4.content = @"value:origValue4";
            
            OrigNode *origNode5 = [OrigNode new];
            origNode5.content = @"value:origValue5";
            
            origNode4.children = @[origNode5];
            origNode2.children = @[origNode4];
            origRoot.children = @[origNode2, origNode3];
            
            Parser *parser = [Parser new];
            ParseNode *parseResult = [parser parseTree:origRoot];
            print(parseResult);
        }

    }
}
