//
//  UIImageView+LoadingImage.h
//  Pulse
//
//  Created by xibic on 6/13/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//


///***********/// How to use ///***********///

/*

 #import "UIImageView+LoadingImage"

 UIImageView *loadingImageView = [[UIImageView alloc] initWithLoadingImage];
 loadingImageView.center = self.center;
 [self addSubview:loadingImageView];
 
 */

///***********/// END ///***********///


#import <UIKit/UIKit.h>

@interface UIImageView (LoadingImage)
- (id)initWithLoadingImage;
@end
