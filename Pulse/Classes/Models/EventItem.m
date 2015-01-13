//
//  EventItem.m
//  Pulse
//
//  Created by xibic on 6/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "EventItem.h"

@implementation EventItem

- (id)initwithDictionary:(NSDictionary*)dic{
    if (self == [super init]) {
        
        self.itemID = [dic objectForKey:@"id"];
        self.eventTitle = [dic objectForKey:@"event_title"];
        self.venue = [dic objectForKey:@"venue"];
        self.startDate = [dic objectForKey:@"start_dt"];
        self.endDate = [dic objectForKey:@"end_dt"];
        self.eventDescription = [dic objectForKey:@"event_description"];
        self.createdBy = [dic objectForKey:@"created_by"];
        self.approvedBy = [dic objectForKey:@"approved_by"];
        self.publishedBy = [dic objectForKey:@"published_by"];
        self.isDraft = ([[dic valueForKey:@"is_draft"] integerValue] == 1);
        self.isDel = ([[dic valueForKey:@"is_del"] integerValue] == 1);
        self.updatedBy = [dic objectForKey:@"updated_by"];
        self.status = ([[dic valueForKey:@"status"] integerValue] == 1);
        self.createdDate = [dic objectForKey:@"created_at"];
        self.updatedDate = [dic objectForKey:@"updated_at"];
        self.isBookmarked = ([[dic valueForKey:@"is_bookmarked"] integerValue] == 1);
        
    }
    return self;
}

@end
