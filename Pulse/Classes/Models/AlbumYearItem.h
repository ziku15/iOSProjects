//
//  AlbumYearItem.h
//  Pulse
//
//  Created by xibic on 7/9/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumYearItem : NSObject

@property(nonatomic,copy) NSString *galleryYear;
@property(nonatomic,copy) NSString *numberOfAlbum;

- (id)initwithDictionary:(NSDictionary*)dic;

@end
