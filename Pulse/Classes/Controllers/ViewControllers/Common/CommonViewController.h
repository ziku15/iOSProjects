//
//  CommonViewController.h
//  Brand
//
//  Created by xibic on 5/12/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "Constants.h"
#import "XIBLoadingView.h"


@interface CommonViewController : UIViewController<UIScrollViewDelegate>{
    NSString *lastElementID;
    BOOL isLoading;
    int SCROLL_CONSIDER_HEIGHT;
    int menuSignature;
    XIBLoadingView * loadingView;
    BOOL isPulling;
   
}

@property (readwrite) BOOL shouldShowBackButton;
@property (readwrite) BOOL shouldShowRightMenuButton;

- (void)pullDownToRefresh;
- (void)pullUpToRefresh;
-(void) loadingPullUpView;
-(void) loadingPullDownView;

-(void)setNavigationCustomTitleView:(NSString *)titleText with:(NSString *)subtitleText;
- (void)goBack;
- (void)rightBarButtonAction;

- (void)showLoginView;

@end
