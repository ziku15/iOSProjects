//
//  XIBActivityIndicator.m
//  Pulse
//
//  Created by xibic on 6/13/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "XIBActivityIndicator.h"

@interface XIBActivityIndicator(){
    UIView *hudView;
    UIImageView *loadingImageView;
}

@end

@implementation XIBActivityIndicator

+ (XIBActivityIndicator *)sharedActivity{
    static XIBActivityIndicator *sharedActivity;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedActivity = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
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

+ (void)startActivity{
    [[self sharedActivity] showLoading];
}


+ (void)dismissActivity{
    [[self sharedActivity] hideLoading];
}

- (void)showLoading{
    
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
    [self addSubview:loadingImageView];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = NO;
}

- (void)hideLoading{
    
    [hudView removeFromSuperview];
    hudView = nil;
    
    [loadingImageView stopAnimating];
    [loadingImageView removeFromSuperview];
    loadingImageView = nil;
    
    [self removeFromSuperview];
    
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
}

@end
