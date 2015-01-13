//
//  AppManager.m
//  Pulse
//
//  Created by xibic on 5/28/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "AppManager.h"
#import "SynthesizeSingleton.h"

#import "SplashViewController.h"
#import "LoginViewController.h"

static NSString *APP_FIRST_TIME_RUN = @"APP_FIRST_TIME_RUN";
static NSString *APP_VERSION_NUMBER = @"APP_VERSION_NUMBER";

#pragma mark - interface
@interface AppManager(){
    UINavigationController *navigationController;
    UIImageView *dummysplashImageView;
}
DECLARE_SINGLETON_FOR_CLASS(AppManager)

@property (nonatomic, retain) NSUserDefaults *userDefaults;

@end


#pragma mark - imlementation
@implementation AppManager
SYNTHESIZE_SINGLETON_FOR_CLASS(AppManager)

@synthesize userDefaults = _userDefaults;
@synthesize appDelegate;
@synthesize authenticationFailed;

#pragma mark - init
- (id)init{
    if (self = [super init]){
        
        self.userDefaults = [NSUserDefaults standardUserDefaults];
        self.versionNumber = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        
        NSObject *settings = [self.userDefaults objectForKey:APP_FIRST_TIME_RUN];
        
        if (settings == nil){
            [self.userDefaults setObject:[NSNumber numberWithInt:10] forKey:APP_FIRST_TIME_RUN];
            [UserManager sharedManager];
            [HttpManager sharedManager];
            [SettingsManager sharedManager];
            
            [UserManager sharedManager].userName = @"";
            [UserManager sharedManager].userPassword = @"";
            [UserManager sharedManager].userEmail = @"invalidUser@invalidEmail.com";
            [UserManager sharedManager].userAccessToken = @"invalidAccessToken";
            [UserManager sharedManager].userID = @"0";
            
            [self.userDefaults synchronize];
        }
    }
    return self;
}

#pragma mark - App Info
- (NSString *)versionNumber{
    return [self.userDefaults stringForKey:APP_VERSION_NUMBER];
}

- (void)setVersionNumber:(NSString *)value{
    [self.userDefaults setObject:value forKey:APP_VERSION_NUMBER];
    [self.userDefaults synchronize];
}

#pragma mark - App Start
- (void)startAppWithDelegate:(AppDelegate*)appdelegate{
    self.appDelegate = appdelegate;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.appDelegate.window.backgroundColor = [UIColor sidraFlatLightGrayColor];
    //[[UIApplication sharedApplication] keyWindow].tintColor = [UIColor sidraFlatTurquoiseColor];
    //Main View
    RootViewController *rootView = [[RootViewController alloc] init];

    //Navigation Controller
    navigationController = [[UINavigationController alloc]
                            initWithRootViewController:rootView];
    navigationController.navigationBar.translucent = NO;
    navigationController.navigationBarHidden = NO;

    //Navigation Bar Text Color
    [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} ];
    
    //Set as main view
    [self showNavigationBarWithColor:[UIColor sidraFlatTurquoiseColor]];
    self.appDelegate.window.rootViewController = navigationController;
    //Menu inactive as this is the first time login
    [self showAppMenuInactive];
}

- (void)appBecameActive{
    
    if( [navigationController.presentedViewController isKindOfClass:[UINavigationController class]] ||
       [navigationController.presentedViewController isKindOfClass:[LoginViewController class]] ){
        
        XLog(@"Phew!");
        [self hideAppMenuInactiveView];
        
    }else{
        
        SplashViewController *splashViewController = [[SplashViewController alloc] init];
        UINavigationController *splashnavigationController = [[UINavigationController alloc]
                                                              initWithRootViewController:splashViewController];
        splashnavigationController.navigationBar.translucent = NO;
        splashnavigationController.navigationBarHidden = YES;
        [navigationController presentViewController:splashnavigationController animated:NO completion:^{
            [self hideAppMenuInactiveView];
            
        }];
        splashnavigationController = nil;
        splashViewController = nil;
        
    }
}

- (void)appBecameInactive{
    
    [self showAppMenuInactive];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"forumPostViewHide" object:nil];
    
}
//
- (void)showAppMenuInactive{
    //****** DUMMY SPLASH IMAGE FOR BLOCKING MENU APPEARENCE ********/
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    UIWindow *appView = [UIApplication sharedApplication].keyWindow;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    dummysplashImageView = [[UIImageView alloc] initWithFrame:appView.frame];
    UIImage *myImage = [UIImage imageNamed:(screenHeight == 568.0f)?@"splash-568@2x.png":@"splash@2x.png"];
    dummysplashImageView.image = myImage;
    [appView addSubview:dummysplashImageView];
    
    //****** DUMMY SPLASH IMAGE FOR BLOCKING MENU APPEARENCE ********/
}
//
- (void)hideAppMenuInactiveView{
    [UIView animateWithDuration:0.8 animations:^{
        dummysplashImageView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [dummysplashImageView removeFromSuperview];
        dummysplashImageView = nil;
    }];
    
}

- (void)showLoginView{
    
}

-(void)showNavigationBarWithColor:(UIColor *)color{
    [[UINavigationBar appearance] setBarTintColor:color];
}

-(void)hideNavigationBar{
    navigationController.navigationBarHidden = YES;
}

- (void)showNavigationBar{
    navigationController.navigationBarHidden = NO;
}

- (void)presentModelViewController:(UIViewController*)viewController{
    [navigationController presentViewController:viewController animated:YES completion:nil];
}
- (void)dismissModelViewController{
    [navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)showRootViewControllerForPushNotification:(NSDictionary *)pushInfo{
    [navigationController popToRootViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushNotificationType" object:nil userInfo:pushInfo];
}


@end
