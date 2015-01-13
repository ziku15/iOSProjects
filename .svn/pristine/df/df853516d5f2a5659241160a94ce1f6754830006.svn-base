//
//  XIBWebActivityIndicator.m
//  Pulse
//
//  Created by xibic on 9/23/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "XIBWebActivityIndicator.h"

@interface XIBWebActivityIndicator(){
    UIView *hudView;
    UIImageView *loadingImageView;
}

@end


@implementation XIBWebActivityIndicator

+ (XIBWebActivityIndicator *)sharedActivity{
    static XIBWebActivityIndicator *sharedActivity;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedActivity = [[self alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    });
    return sharedActivity;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
		self.alpha = 1;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

+ (void)startActivity:(id)parentController{
    [[self sharedActivity] showLoading:parentController];
}


+ (void)dismissActivity{
    [[self sharedActivity] hideLoading];
}

- (void)showLoading:(UIViewController *)parentController{
    
    [hudView removeFromSuperview];
    hudView = nil;
    
    hudView = [[UIView alloc] initWithFrame:self.frame];
    hudView.backgroundColor = [UIColor blackColor];
    hudView.alpha = 0.3f;
    [self addSubview:hudView];
    
    [loadingImageView removeFromSuperview];
    loadingImageView = nil;
    
    loadingImageView = [[UIImageView alloc] initWithLoadingImage];
    loadingImageView.center = self.center;
    CGRect frame = loadingImageView.frame;
    frame.origin.y = self.center.y - 55;
    loadingImageView.frame = frame;
    [self addSubview:loadingImageView];
    
    [parentController.view addSubview:self];
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
}

- (void)hideLoading{
    
    [hudView removeFromSuperview];
    hudView = nil;
    
    [loadingImageView stopAnimating];
    [loadingImageView removeFromSuperview];
    loadingImageView = nil;
    
    [self removeFromSuperview];
    
    //[UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
}

@end
