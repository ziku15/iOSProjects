//
//  CommentItem.h
//  Pulse
//
//  Created by xibic on 7/15/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentItem : NSObject

@property(nonatomic,copy) NSString *itemID;
@property(nonatomic,copy) NSString *userID;
@property(nonatomic,copy) NSString *forumID;
@property(nonatomic,copy) NSString *commentText;
@property(nonatomic,copy) NSString *photo;
@property(nonatomic,copy) NSString *video;
@property(nonatomic,readwrite) BOOL isDel;
@property(nonatomic,copy) NSString *updated_at;
@property(nonatomic,copy) NSString *created_at;
@property(nonatomic,copy) NSArray *commentator;
@property(nonatomic,copy) NSString *commentatorName;
@property(nonatomic,copy) NSString *commentatorEmail;
@property(nonatomic,copy) NSString *commentatorPhone;

- (id)initwithDictionary:(NSDictionary*)dic;

@end
