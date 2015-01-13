//
//  AppManager.h
//  Pulse
//
//  Created by xibic on 5/28/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface AppManager : NSObject

@property (nonatomic, copy) NSString *versionNumber;
@property (nonatomic, readwrite) BOOL authenticationFailed;
@property (nonatomic, strong) AppDelegate *appDelegate;

+ (AppManager *)sharedManager;

- (void)startAppWithDelegate:(AppDelegate*)appdelegate;
- (void)appBecameActive;
- (void)appBecameInactive;

- (void)presentModelViewController:(UIViewController*)viewController;
- (void)dismissModelViewController;
- (void)showRootViewControllerForPushNotification:(NSDictionary *)pushInfo;

- (void)showNavigationBar;
- (void)hideNavigationBar;

@end
