//
//  ServerDataParser.m
//  Pulse
//
//  Created by xibic on 6/20/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "ServerDataParser.h"


@implementation ServerDataParser


#pragma mark - User Authentication
+ (NSMutableArray* )validateUserAuthentication:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //*****CREATE MODELS******//
    NSString *status = [dataDictionary objectForKey:@"status"];
    
    NSDictionary *dataArray = [dataDictionary objectForKey:@"data"];

    NSString *accessToken = [dataArray objectForKey:@"access_token"];
    NSString *pushSettings = [dataArray objectForKey:@"push_on"];
    NSString *userid = [dataArray objectForKey:@"user_id"];
    
    //
    return [NSMutableArray arrayWithArray:@[status,accessToken,pushSettings,userid]];
}

#pragma mark - Menu Notification models
+ (NSMutableArray* )parseDataMenuNotifications:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSDictionary *tempDictionary = [dataDictionary objectForKey:@"data"];
    MenuItem *item = [[MenuItem alloc] initwithDictionary:tempDictionary];
    [dataArray addObject:item];
    item = nil;
    
    //
    return dataArray;
}

#pragma mark - Announcment models
+ (NSMutableArray* )parseDataAnnouncements:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        AnnouncementItem *item = [[AnnouncementItem alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;
}

#pragma mark - Staff Directory
+ (NSMutableArray* )parseDataStaffDirectoryDepartment:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        DepartmentItem *item = [[DepartmentItem alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;
}
+ (NSMutableArray* )parseDataStaffDirectoryStaffDetails:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        StaffItem *item = [[StaffItem alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;
}

+ (NSMutableArray* )parseDataEvents:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        EventItem *item = [[EventItem alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;
}


#pragma mark - Offers and Promotions models
+ (NSMutableArray* )parseDataOffersAndPromotions:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        OfferItem *item = [[OfferItem alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;
}
#pragma mark - Offers and Promotions Categories
+ (NSMutableArray* )parseDataOffersAndPromotionsCategories:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        CategoryItem *item = [[CategoryItem alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;
}

#pragma mark - Classifieds models
+ (NSMutableArray* )parseDataClassifieds:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        ClassifiedItem *item = [[ClassifiedItem alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;
}

#pragma mark - Classifieds Categories
+ (NSMutableArray* )parseDataClassifiedCategories:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        CategoryItem *item = [[CategoryItem alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;
}

#pragma mark - Gallery Album Year
+ (NSMutableArray* )parseDataGalleryAlbumYear:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        AlbumYearItem *item = [[AlbumYearItem alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;

}

#pragma mark - Gallery Album
+ (NSMutableArray* )parseDataGalleryAlbum:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        AlbumItem *item = [[AlbumItem alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;
}

#pragma mark - Gallery ALbum Media details
+ (NSMutableArray* )parseDataGalleryAlbumDetails:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        MediaItem *item = [[MediaItem alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;
}

#pragma mark - HR Categories
+ (NSMutableArray* )parseDataHRCategories:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        HRL1Item *item = [[HRL1Item alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;
}
#pragma mark - HR List
+ (NSMutableArray* )parseDataHRList:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        HRL2Item *item = [[HRL2Item alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;
    
}
#pragma mark - Policy Department
+ (NSMutableArray* )parseDataPolicyDepartment:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        CategoryItem *item = [[CategoryItem alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;
}
#pragma mark - Policy Department Details
+ (NSMutableArray* )parseDataPolicyDepartmentDetails:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        PolicyItem *item = [[PolicyItem alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;
}

#pragma mark - Sidra in News
+ (NSMutableArray* )parseDataSidraInNews:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        NewsItem *item = [[NewsItem alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;
}
#pragma mark - Press Release
+ (NSMutableArray* )parseDataPressRelease:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        PressReleaseItem *item = [[PressReleaseItem alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;
}

#pragma mark - Forum Posts
+ (NSMutableArray* )parseDataForumPosts:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        ForumItem *item = [[ForumItem alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;
}
#pragma mark - Forum HashTag
+ (NSMutableArray* )parseDataForumHashTag:(NSDictionary*)dataDictionary{
    //
    if (dataDictionary == nil) return nil;
    //
    NSMutableArray *dataArray = [NSMutableArray array];
    //*****CREATE MODELS******//
    NSArray *tempArray = [dataDictionary objectForKey:@"data"];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dictonary = (NSDictionary* )obj;
        HashTagItem *item = [[HashTagItem alloc] initwithDictionary:dictonary];
        [dataArray addObject:item];
        item = nil;
    }];
    
    //
    return dataArray;
}

@end
