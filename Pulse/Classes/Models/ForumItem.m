//
//  ForumItem.m
//  Pulse
//
//  Created by xibic on 6/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "ForumItem.h"
#import "CommentItem.h"

@implementation ForumItem

- (id)initwithDictionary:(NSDictionary*)dic{
    if (self == [super init]) {
        
        self.itemID = [dic objectForKey:@"id"];
        self.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"text"]];
        self.createdBy = [dic objectForKey:@"created_by"];
        self.updatedBy = [dic objectForKey:@"updated_by"];
        self.isDel = ([[dic valueForKey:@"is_del"] integerValue] == 1);
        self.createdDate = [dic objectForKey:@"created_at"];
        self.updatedDate = [dic objectForKey:@"updated_at"];
        self.status = ([[dic valueForKey:@"status"] integerValue] == 1);
        self.totalComments = [[dic valueForKey:@"total_comments"] integerValue];
        self.photos = [dic objectForKey:@"photo"];
        [self parseAuthorInfo:[dic objectForKey:@"author_info"]];
        self.comments = [self parseCommentInfo:[dic objectForKey:@"comments"]];
        
    }
    return self;
}

- (void)parseAuthorInfo:(NSDictionary*)authorInfoObject{
    self.authorName = [authorInfoObject objectForKey:@"name"];
    self.authorEmail = [authorInfoObject objectForKey:@"email"];
    self.authorPhone = [authorInfoObject objectForKey:@"mobile"];
}

- (NSArray *)parseCommentInfo:(NSArray*)authorInfoObject{
    NSMutableArray *tempArray = [NSMutableArray array];
    [authorInfoObject enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        CommentItem *item = [[CommentItem alloc] initwithDictionary:obj];
        [tempArray addObject:item];
        item = nil;
    }];
    return tempArray;
}

@end
