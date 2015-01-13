//
//  XIBParser.m
//  Pulse
//
//  Created by xibic on 6/17/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "XIBParser.h"

@implementation XIBParser

+ (XIBParser *)sharedParser{
    static XIBParser *sharedParser;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedParser = [[self alloc] init];
    });
    return sharedParser;
}
- (id)init{
    if (self = [super init]) {
        
        
    }
    return self;
}

+ (void)testingWithBlocks{
    
    int multiplier = 7;
    
    int(^myBlock)(int) = ^(int num){ return num*multiplier; };
    
    printf("%d",myBlock(3));
    

}


@end
