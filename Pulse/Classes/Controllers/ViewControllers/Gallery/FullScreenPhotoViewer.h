//
//  FullScreenPhotoViewer.h
//  Pulse
//
//  Created by xibic on 6/27/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FullScreenPhotoViewerDelegate <NSObject>

@optional
- (void)closePhotoViewer;
- (void)openMovieView:(int)videoTag;
@end


@interface FullScreenPhotoViewer : UIView

@property(nonatomic, retain) id<FullScreenPhotoViewerDelegate>delegate;

- (id)initWithFrame:(CGRect)frame photosArray:(NSArray*)array withSelectedIndex:(int)sindex;
- (id)initWithFrame:(CGRect)frame photosArray:(NSArray*)array withSelectedIndex:(int)sindex isGallery:(BOOL)isGallery;
- (id)initWithFrameForPreviewClassified:(CGRect)frame photosArray:(NSArray*)array withSelectedIndex:(int)sindex isGallery:(BOOL)isGallery;


@end
