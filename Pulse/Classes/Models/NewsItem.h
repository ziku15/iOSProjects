//
//  NewsItem.h
//  Pulse
//
//  Created by xibic on 6/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject

// API 11 : Sidra in News API

@property(nonatomic,copy) NSString *itemID;
@property(nonatomic,copy) NSString *headline;
@property(nonatomic,copy) NSString *releaseDate;
@property(nonatomic,copy) NSString *sourcePublication;
@property(nonatomic,copy) NSString *link;
@property(nonatomic,copy) NSString *createdBy;
@property(nonatomic,copy) NSString *updatedBy;
@property(nonatomic,copy) NSString *approvedBy;
@property(nonatomic,copy) NSString *publishedBy;
@property(nonatomic,copy) NSString *createdDate;
@property(nonatomic,copy) NSString *updatedDate;
@property(nonatomic,readwrite) BOOL status;
@property(nonatomic,readwrite) BOOL isDel;
@property(nonatomic,readwrite) BOOL isDraft;

- (id)initwithDictionary:(NSDictionary*)dic;

@end
