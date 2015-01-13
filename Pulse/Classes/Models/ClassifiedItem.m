//
//  ClassifiedItem.m
//  Pulse
//
//  Created by xibic on 6/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "ClassifiedItem.h"

@implementation ClassifiedItem


- (id)initwithDictionary:(NSDictionary*)dic{
    if (self == [super init]) {
        
        self.itemID = [dic objectForKey:@"id"];
        self.title = [dic objectForKey:@"title"];
        self.a_description = [dic objectForKey:@"description"];
        self.catID = [[dic valueForKey:@"cat_id"] integerValue];
        self.media = [[dic valueForKey:@"media"] integerValue];
        self.createdBy = [dic objectForKey:@"created_by"];
        self.updatedBy = [dic objectForKey:@"updated_by"];
        self.isDel = ([[dic valueForKey:@"is_del"] integerValue] == 1);
        self.createdDate = [dic objectForKey:@"created_at"];
        self.updatedDate = [dic objectForKey:@"updated_at"];
        self.ownerInfo = [dic objectForKey:@"owner_info"];
        self.photos = [dic objectForKey:@"photo"];
        self.isDraft = [[dic objectForKey:@"is_draft"] integerValue];
        
    }
    return self;
}

@end
