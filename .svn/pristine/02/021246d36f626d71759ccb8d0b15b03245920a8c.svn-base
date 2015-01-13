//
//  UIImageView+LoadingImage.m
//  Pulse
//
//  Created by xibic on 6/13/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "UIImageView+LoadingImage.h"

@implementation UIImageView (LoadingImage)
- (id)initWithLoadingImage{
    if (self=[super init]) {
        //
        UIImage *loadingImage = [UIImage imageNamed:@"1.png"];
        self.frame = CGRectMake(0, 0, loadingImage.size.width/2 - 10.0f, loadingImage.size.height/2 - 10.0f);
        
        self.animationImages = [NSArray arrayWithObjects:
                                            [UIImage imageNamed:@"1.png"],
                                            [UIImage imageNamed:@"2.png"],
                                            [UIImage imageNamed:@"3.png"],
                                            [UIImage imageNamed:@"4.png"],
                                            [UIImage imageNamed:@"5.png"],
                                            [UIImage imageNamed:@"6.png"],
                                            [UIImage imageNamed:@"7.png"],
                                            [UIImage imageNamed:@"8.png"],
                                            [UIImage imageNamed:@"9.png"],
                                            [UIImage imageNamed:@"10.png"],
                                            [UIImage imageNamed:@"11.png"],
                                            [UIImage imageNamed:@"12.png"],
                                            nil];
        self.animationDuration = 1.0;
        self.center = self.center;
        [self startAnimating];
    }
    return self;
}
@end
