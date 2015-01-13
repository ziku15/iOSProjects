//
//  OfferItem.m
//  Pulse
//
//  Created by xibic on 6/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "OfferItem.h"
#import "MediaItem.h"

@implementation OfferItem

- (id)initwithDictionary:(NSDictionary*)dic{
    if (self == [super init]) {
        self.itemID = [dic objectForKey:@"id"];
        self.cat_id = [dic objectForKey:@"cat_id"];
        self.title = [dic objectForKey:@"title"];
        self.a_description = [dic objectForKey:@"description"];
        self.approvedBy = [dic objectForKey:@"approved_by"];
        self.companyThumb = [dic objectForKey:@"company_thumb"];
        self.createdDate = [dic objectForKey:@"created_at"];
        self.createdBy = [dic objectForKey:@"created_by"];
        self.isDeleted = [dic objectForKey:@"is_del"];
        self.isDraft = [dic objectForKey:@"is_draft"];
        self.publishedDate = [dic objectForKey:@"published_by"];
        self.updatedDate = [dic objectForKey:@"updated_at"];
        self.updatedBy = [dic objectForKey:@"updated_by"];
        self.validPeriod = [dic objectForKey:@"valid_until"];
        self.photos = [dic objectForKey:@"photo"];
        self.isBookmarked = ([[dic valueForKey:@"is_bookmarked"] integerValue] == 1);
        self.isRead = ([[dic valueForKey:@"is_read"] integerValue] == 1);
        self.isLongTermOffer = ([[dic valueForKey:@"long_term"] integerValue] == 1);
    }
    return self;
}


@end
