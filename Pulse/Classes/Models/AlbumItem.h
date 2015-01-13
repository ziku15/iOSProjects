//
//  AlbumItem.h
//  Pulse
//
//  Created by xibic on 6/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumItem : NSObject

// API 9: Gallery Album

@property(nonatomic,copy) NSString *itemID;
@property(nonatomic,copy) NSString *catName;
@property(nonatomic,copy) NSString *createdBy;
@property(nonatomic,copy) NSString *updatedBy;
@property(nonatomic,readwrite) BOOL isDraft;
@property(nonatomic,readwrite) BOOL isDel;
@property(nonatomic,copy) NSString *createdDate;
@property(nonatomic,copy) NSString *updatedDate;
@property(nonatomic,copy) NSString *approvedBy;
@property(nonatomic,copy) NSString *publishedBy;
@property(nonatomic,readwrite) BOOL status;
@property(nonatomic,copy) NSString *thumb;
@property(nonatomic,readwrite) BOOL isRead;
@property(nonatomic,readwrite) int photos;
@property(nonatomic,readwrite) int videos;
@property(nonatomic,readwrite) int totalAlbum;


- (id)initwithDictionary:(NSDictionary*)dic;

@end
