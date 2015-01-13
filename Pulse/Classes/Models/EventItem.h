//
//  EventItem.h
//  Pulse
//
//  Created by xibic on 6/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventItem : NSObject

// API 7 : Events

@property(nonatomic,copy) NSString *itemID;
@property(nonatomic,copy) NSString *eventTitle;
@property(nonatomic,copy) NSString *venue;
@property(nonatomic,copy) NSString *startDate;
@property(nonatomic,copy) NSString *endDate;
@property(nonatomic,copy) NSString *eventDescription;
@property(nonatomic,copy) NSString *createdBy;
@property(nonatomic,copy) NSString *approvedBy;
@property(nonatomic,copy) NSString *publishedBy;
@property(nonatomic,readwrite) BOOL isDraft;
@property(nonatomic,readwrite) BOOL isDel;
@property(nonatomic,copy) NSString *updatedBy;
@property(nonatomic,readwrite) BOOL status;
@property(nonatomic,copy) NSString *createdDate;
@property(nonatomic,copy) NSString *updatedDate;
@property(nonatomic,readwrite) BOOL isBookmarked;

- (id)initwithDictionary:(NSDictionary*)dic;

@end
