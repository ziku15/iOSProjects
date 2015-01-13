//
//  XIBLoadingView.h
//  Pulse
//
//  Created by Ziku-Atomix on 10/31/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XIBLoadingView : UIView

@property (retain,nonatomic) UIActivityIndicatorView *activityIndicator;
@property (assign) BOOL isRefreshing;


-(id) initWithFrame:(CGRect)frame;
-(void)dismisssView;
-(void) apeareLoadingView;

@end
