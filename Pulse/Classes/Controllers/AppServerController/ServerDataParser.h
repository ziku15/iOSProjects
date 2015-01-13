//
//  ServerDataParser.h
//  Pulse
//
//  Created by xibic on 6/20/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MenuItem.h"
#import "DepartmentItem.h"
#import "StaffItem.h"
#import "EventItem.h"
#import "AlbumYearItem.h"
#import "AlbumItem.h"
#import "MediaItem.h"
#import "AnnouncementItem.h"
#import "NewsItem.h"
#import "PressReleaseItem.h"
#import "HRL1Item.h"
#import "HRL2Item.h"
#import "OfferItem.h"
#import "CategoryItem.h"
#import "ClassifiedItem.h"
#import "ForumItem.h"
#import "CommentItem.h"
#import "HashTagItem.h"
#import "PolicyItem.h"


@interface ServerDataParser : NSObject

+ (NSMutableArray* )validateUserAuthentication:(NSDictionary*)dataDictionary;

+ (NSMutableArray* )parseDataMenuNotifications:(NSDictionary*)dataDictionary;

+ (NSMutableArray* )parseDataAnnouncements:(NSDictionary*)dataDictionary;

+ (NSMutableArray* )parseDataOffersAndPromotions:(NSDictionary*)dataDictionary;
+ (NSMutableArray* )parseDataOffersAndPromotionsCategories:(NSDictionary*)dataDictionary;

+ (NSMutableArray* )parseDataClassifieds:(NSDictionary*)dataDictionary;
+ (NSMutableArray* )parseDataClassifiedCategories:(NSDictionary*)dataDictionary;

+ (NSMutableArray* )parseDataEvents:(NSDictionary*)dataDictionary;
+ (NSMutableArray* )parseDataHRCategories:(NSDictionary*)dataDictionary;
+ (NSMutableArray* )parseDataHRList:(NSDictionary*)dataDictionary;

+ (NSMutableArray* )parseDataStaffDirectoryDepartment:(NSDictionary*)dataDictionary;
+ (NSMutableArray* )parseDataStaffDirectoryStaffDetails:(NSDictionary*)dataDictionary;

+ (NSMutableArray* )parseDataPolicyDepartment:(NSDictionary*)dataDictionary;
+ (NSMutableArray* )parseDataPolicyDepartmentDetails:(NSDictionary*)dataDictionary;

+ (NSMutableArray* )parseDataGalleryAlbumYear:(NSDictionary*)dataDictionary;
+ (NSMutableArray* )parseDataGalleryAlbum:(NSDictionary*)dataDictionary;
+ (NSMutableArray* )parseDataGalleryAlbumDetails:(NSDictionary*)dataDictionary;

+ (NSMutableArray* )parseDataSidraInNews:(NSDictionary*)dataDictionary;

+ (NSMutableArray* )parseDataPressRelease:(NSDictionary*)dataDictionary;

+ (NSMutableArray* )parseDataForumPosts:(NSDictionary*)dataDictionary;
+ (NSMutableArray* )parseDataForumHashTag:(NSDictionary*)dataDictionary;

@end
