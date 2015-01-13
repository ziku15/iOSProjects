//
//  ForumItem.h
//  Pulse
//
//  Created by xibic on 6/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForumItem : NSObject

// API 22 : 

@property(nonatomic,copy) NSString *itemID;
@property(nonatomic,copy) NSString *text;
@property(nonatomic,copy) NSString *createdBy;
@property(nonatomic,copy) NSString *updatedBy;
@property(nonatomic,readwrite) BOOL isDel;
@property(nonatomic,copy) NSString *createdDate;
@property(nonatomic,copy) NSString *updatedDate;
@property(nonatomic,readwrite) BOOL status;
@property(nonatomic,readwrite) int totalComments;
@property(nonatomic,copy) NSString *authorName;
@property(nonatomic,copy) NSString *authorEmail;
@property(nonatomic,copy) NSString *authorPhone;
@property(nonatomic,copy) NSArray *photos;
@property(nonatomic,copy) NSArray *comments;

- (id)initwithDictionary:(NSDictionary*)dic;


@end
