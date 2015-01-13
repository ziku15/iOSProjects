//
//  CUploadImageView.h
//  Pulse
//
//  Created by xibic on 7/3/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CUploadImageViewDelegate <NSObject>

@optional
- (void)clickedDeleteButton:(NSInteger)tagID;
- (void)recievedPhotoName:(NSString*)serverPhotoName tag:(NSInteger)tagID;
@end

@interface CUploadImageView : UIView

@property (nonatomic,retain) id<CUploadImageViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame withImage:(UIImage *)image;
- (id)initWithFrame:(CGRect)frame withImageURL:(NSString *)imageurl;


- (void)uploadImage:(UIImage*)image;
- (void)setImageToTheView:(UIImage *)image;
@end
