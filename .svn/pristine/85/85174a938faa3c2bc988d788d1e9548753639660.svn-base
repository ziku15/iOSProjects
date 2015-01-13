//
//  SidraAlbumView.h
//  Pulse
//
//  Created by xibic on 6/25/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumItem.h"
@protocol SidraAlbumViewDelegate <NSObject>

 @optional
 - (void)clickedAlbum:(AlbumItem *)albumItem;

@end

@interface SidraAlbumView : UIView

@property(nonatomic, retain) id<SidraAlbumViewDelegate>delegate;


- (void)addAlbumViews:(NSArray *)itemArray;


@end
