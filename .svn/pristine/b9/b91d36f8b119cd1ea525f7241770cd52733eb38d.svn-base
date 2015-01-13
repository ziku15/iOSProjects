//
//  PressReleaseItem.m
//  Pulse
//
//  Created by xibic on 6/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "PressReleaseItem.h"

@implementation PressReleaseItem


- (id)initwithDictionary:(NSDictionary*)dic{
    if (self == [super init]) {
        
        self.itemID = [dic objectForKey:@"id"];
        self.title = [dic objectForKey:@"title"];
        self.releaseDate = [dic objectForKey:@"release_date"];
        self.content = [dic objectForKey:@"content"];
        self.createdBy = [dic objectForKey:@"created_by"];
        self.updatedBy = [dic objectForKey:@"updated_by"];
        self.approvedBy = [dic objectForKey:@"approved_by"];
        self.publishedBy = [dic objectForKey:@"published_by"];
        self.createdDate = [dic objectForKey:@"created_at"];
        self.updatedDate = [dic objectForKey:@"updated_at"];
        self.status = ([[dic valueForKey:@"status"] integerValue] == 1);
        self.isDraft = ([[dic valueForKey:@"is_draft"] integerValue] == 1);
        self.isDel = ([[dic valueForKey:@"is_del"] integerValue] == 1);
        
        
    }
    return self;
}

@end
