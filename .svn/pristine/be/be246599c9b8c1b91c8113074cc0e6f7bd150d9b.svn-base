//
//  AnnouncementItem.m
//  Pulse
//
//  Created by xibic on 6/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "AnnouncementItem.h"

@implementation AnnouncementItem

- (id)initwithDictionary:(NSDictionary*)dic{
    if (self == [super init]) {
        self.itemID = [dic objectForKey:@"id"];
        self.cat_name = [dic objectForKey:@"cat_name"];
        self.cat_id = [dic objectForKey:@"cat_id"];
        self.title = [dic objectForKey:@"title"];
        self.a_description = [NSString stringWithFormat:@"%@",[dic objectForKey:@"description"]];
        self.createdDate = [dic objectForKey:@"created_at"];
        self.updatedDate = [dic objectForKey:@"updated_at"];
        self.isRead = ([[dic valueForKey:@"is_read"] integerValue] == 1);
    }
    return self;
}


@end
