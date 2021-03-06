//
//  HRL2Item.m
//  Pulse
//
//  Created by xibic on 6/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "HRL2Item.h"

@implementation HRL2Item

- (id)initwithDictionary:(NSDictionary*)dic{
    if (self == [super init]) {
        
        self.itemID = [dic objectForKey:@"id"];
        self.catID = [[dic valueForKey:@"cat_id"] integerValue];
        self.question = [NSString stringWithFormat:@"%@",[dic objectForKey:@"question"]];
        self.answer = [NSString stringWithFormat:@"%@",[dic objectForKey:@"answer"]];
        self.createdBy = [dic objectForKey:@"created_by"];
        self.updatedBy = [dic objectForKey:@"updated_by"];
        self.isDel = ([[dic valueForKey:@"is_del"] integerValue] == 1);
        self.createdDate = [dic objectForKey:@"created_at"];
        self.updatedDate = [dic objectForKey:@"updated_at"];

        
    }
    return self;
}

@end
