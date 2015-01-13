//
//  CommentItem.m
//  Pulse
//
//  Created by xibic on 7/15/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "CommentItem.h"

@implementation CommentItem

- (id)initwithDictionary:(NSDictionary*)dic{
    if (self == [super init]) {
        
        self.itemID = [dic objectForKey:@"id"];
        self.userID = [dic objectForKey:@"user_id"];
        self.forumID = [dic objectForKey:@"forum_id"];
        self.commentText = [dic objectForKey:@"comment_text"];
        self.photo = [dic objectForKey:@"image"];
        self.video = [dic objectForKey:@"video"];
        self.isDel = ([[dic valueForKey:@"status"] integerValue] == 1);
        self.updated_at = [dic objectForKey:@"updated_at"];
        self.created_at = [dic objectForKey:@"created_at"];
        [self parseCommentatorInfo:[dic objectForKey:@"commentator"]];
    }
    return self;
}
- (void)parseCommentatorInfo:(NSDictionary*)authorInfoObject{
    self.commentatorName = [authorInfoObject objectForKey:@"name"];
    self.commentatorEmail = [authorInfoObject objectForKey:@"email"];
    self.commentatorPhone = [authorInfoObject objectForKey:@"mobile"];
}
@end
