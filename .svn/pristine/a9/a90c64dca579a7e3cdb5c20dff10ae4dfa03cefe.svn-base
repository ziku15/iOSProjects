//
//  AlbumItem.m
//  Pulse
//
//  Created by xibic on 6/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "AlbumItem.h"

@implementation AlbumItem

- (id)initwithDictionary:(NSDictionary*)dic{
    if (self == [super init]) {
        
        self.itemID = [dic objectForKey:@"id"];
        self.catName = [dic objectForKey:@"cat_name"];
        self.createdBy = [dic objectForKey:@"created_by"];
        self.updatedBy = [dic objectForKey:@"updated_by"];
        self.isDraft = ([[dic valueForKey:@"is_draft"] integerValue] == 1);
        self.isDel = ([[dic valueForKey:@"is_del"] integerValue] == 1);
        self.createdDate = [dic objectForKey:@"created_at"];
        self.updatedDate = [dic objectForKey:@"updated_at"];
        self.approvedBy = [dic objectForKey:@"approved_by"];
        self.publishedBy = [dic objectForKey:@"published_by"];
        self.status = ([[dic valueForKey:@"status"] integerValue] == 1);
        self.thumb = [dic objectForKey:@"thumb"];
        self.isRead = ([[dic valueForKey:@"is_read"] integerValue] == 1);
        self.photos = [[dic valueForKey:@"photos"] integerValue];
        self.videos = [[dic valueForKey:@"videos"] integerValue];
        self.totalAlbum = [[dic valueForKey:@"total_album"] integerValue];
    }
    return self;
}


@end
