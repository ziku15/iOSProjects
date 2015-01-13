//
//  ClassifiedItem.h
//  Pulse
//
//  Created by xibic on 6/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassifiedItem : NSObject

//API 17 : Show Classified

@property(nonatomic,copy) NSString *itemID;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *a_description;
@property(nonatomic,readwrite) int catID;
@property(nonatomic,readwrite) int media;
@property(nonatomic,copy) NSString *createdBy;
@property(nonatomic,copy) NSString *updatedBy;
@property(nonatomic,readwrite) BOOL isDel;
@property(nonatomic,copy) NSString *createdDate;
@property(nonatomic,copy) NSString *updatedDate;
@property(nonatomic,copy) NSArray *ownerInfo;
@property(nonatomic,copy) NSArray *photos;
@property(nonatomic,readwrite) int isDraft;
// owner_info not added
// photo not added


- (id)initwithDictionary:(NSDictionary*)dic;



@end
