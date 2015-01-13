//
//  MediaItem.m
//  Pulse
//
//  Created by xibic on 6/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "MediaItem.h"

@implementation MediaItem

- (id)initwithDictionary:(NSDictionary*)dic{
    if (self == [super init]) {
        
        self.itemID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
        self.collectionID = [[dic valueForKey:@"collection_id"] integerValue];
        self.media = [dic objectForKey:@"media"];
        self.mediaType = [[dic valueForKey:@"media_type"] integerValue];
        self.createdBy = [dic objectForKey:@"created_by"];
        self.updatedBy = [dic objectForKey:@"updated_by"];
        self.createdDate = [dic objectForKey:@"created_at"];
        self.updatedDate = [dic objectForKey:@"updated_at"];
        self.isDel = ([[dic valueForKey:@"is_del"] integerValue] == 1);
        self.externalUrl = [dic objectForKey:@"external_url"];
        
    }
    return self;
}

@end
