//
//  HashTagItem.m
//  Pulse
//
//  Created by xibic on 7/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "HashTagItem.h"

@implementation HashTagItem
- (id)initwithDictionary:(NSDictionary*)dic{
    if (self == [super init]) {
        
        self.tagName = [dic objectForKey:@"tag_name"];
        self.postCount = [dic objectForKey:@"total"];

    }
    return self;
}
@end
