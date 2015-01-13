//
//  FUploadImageView.h
//  Pulse
//
//  Created by xibic on 7/3/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FUploadImageViewDelegate <NSObject>

@optional
- (void)clickedDeleteButton;
- (void)recievedPhotoName:(NSString*)serverPhotoName withTag:(NSInteger)tagID;
@end

@interface FUploadImageView : UIView

@property (nonatomic,retain) id<FUploadImageViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame withImage:(UIImage *)image;
- (id)initWithFrame:(CGRect)frame withImageURL:(NSString *)imageurl;

@end