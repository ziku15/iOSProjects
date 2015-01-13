//
//  SplashViewController.m
//
//  Created by xibic on 2/26/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "SplashViewController.h"
#import "LoginViewController.h"

@interface SplashViewController (){
    UIImageView *loadingImageView;
}

@end

@implementation SplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIImageView *splashImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    UIImage *myImage = [UIImage imageNamed:(screenHeight == 568.0f)?@"splash-568@2x.png":@"splash@2x.png"];
    splashImageView.image = myImage;
    [self.view addSubview:splashImageView];
    
    loadingImageView = [[UIImageView alloc] initWithLoadingImage];
    loadingImageView.center = self.view.center;
    [self.view addSubview:loadingImageView];

    //[self performSelector:@selector(removeSplash) withObject:nil afterDelay:1.5];
    
    [[ServerManager sharedManager] checkForUserAuthentication:^(BOOL success) {
        if (success) {
            
            [self removeSplash];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }else{
            BOOL network = [[ServerManager sharedManager] checkForNetworkAvailability];
            if (!network) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//                alert = nil;
                CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/10.0, [UIScreen mainScreen].bounds.size.height/5.0 , 200, 50);
                NSString *msg = @"The app can’t be accessed offline. Please check your internet connection";
                AlertPopView *alertMsg = [[AlertPopView alloc] initWithFrame:frame alertMsg:msg];
                [self.view addSubview:alertMsg];
                alertMsg = nil;
            }
            [self removeSplash];
            LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:loginView animated:YES];
            
        }
    }];
    
}

- (void)removeSplash{
    [loadingImageView stopAnimating];
    [loadingImageView removeFromSuperview];
    loadingImageView = nil;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
