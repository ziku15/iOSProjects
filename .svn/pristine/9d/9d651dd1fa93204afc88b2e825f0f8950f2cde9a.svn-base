//
//  MerdiaViewController.m
//  Pulse
//
//  Created by Atomix on 7/11/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "MediaViewController.h"

static NSString *twitterURL = @"https://mobile.twitter.com/sidra";
static NSString *youtubeURL = @"http://www.youtube.com/channel/UCBf9kAG-cyTT03V6BmG8osg?app=mobile";
static NSString *facebookURL = @"https://m.facebook.com/SidraMedicalAndResearchCenter";


@interface MediaViewController ()<UIWebViewDelegate> {
    UISegmentedControl *tabBarControlView;
    UIWebView *twitterWebView;
    UIWebView *youtubeWebView;
    UIWebView *facebookWebView;
    NSArray *socialNetworkName;
    UIColor *faceBookColor;
}

@end

@implementation MediaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"Social Channels";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    faceBookColor = [UIColor colorWithRed:(58.0/255.0) green:(80.0/255.0) blue:(146.0/255.0) alpha:1.0];
    
    [self tabBarDesign];
    
    [self socialMediaLink];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)socialMediaLink {
    
    [twitterWebView removeFromSuperview];
    [youtubeWebView removeFromSuperview];
    [facebookWebView removeFromSuperview];
    
    twitterWebView = nil;
    youtubeWebView = nil;
    facebookWebView = nil;
    
    // Twitter Link
    twitterWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 56, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 121)];
    twitterWebView.delegate = self;
    [twitterWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:twitterURL]]];
    twitterWebView.hidden = NO;
    [self.view addSubview:twitterWebView];
    
    
    
    // Youtube Link
    youtubeWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 56, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 121)];
    youtubeWebView.delegate = self;
    youtubeWebView.hidden =  YES;
    [self.view addSubview:youtubeWebView];
    
    
    // FaceBook Link
    facebookWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 56, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 121)];
    facebookWebView.delegate = self;
    facebookWebView.hidden = YES;
    [self.view addSubview:facebookWebView];
}

-(void)tabBarDesign {
    
    // White Background
    UIView *whiteBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 56)];
    whiteBg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteBg];
    
    UIView *lightGrayEffect = [[UIView alloc] initWithFrame:CGRectMake(0, whiteBg.frame.size.height-1, self.view.frame.size.width, 1)];
    lightGrayEffect.backgroundColor = [UIColor lightGrayColor];
    [whiteBg addSubview:lightGrayEffect];
    
    //***** Custom Tab bar ********//
    socialNetworkName = [[NSArray alloc] initWithObjects:@"Twitter", @"YouTube", @"Facebook", nil];
    tabBarControlView = [[UISegmentedControl alloc] initWithItems:socialNetworkName];
    tabBarControlView.frame = CGRectMake(10, 12, 300, 32);
    tabBarControlView.selectedSegmentIndex = 0;
    [tabBarControlView addTarget:self action:@selector(mediaTabBarAction:) forControlEvents: UIControlEventValueChanged];
    [tabBarControlView setTintColor:[UIColor sidraFlatTurquoiseColor]];
    [self setTintColor:[UIColor whiteColor] forSegmentAtIndex:0 titleName:[socialNetworkName objectAtIndex:0]];
    [self setTintColor:[UIColor redColor] forSegmentAtIndex:1 titleName:[socialNetworkName objectAtIndex:1]];
    [self setTintColor:faceBookColor forSegmentAtIndex:2 titleName:[socialNetworkName objectAtIndex:2]];
    
    [self.view addSubview:tabBarControlView];
    
}

// tab bar Action

- (void)mediaTabBarAction:(UISegmentedControl *)segment {
    
    XLog(@"tab Bar selected : %d", segment.selectedSegmentIndex);
    
    if (segment.selectedSegmentIndex==0) {
        
        //UI Color Change
        [tabBarControlView setTintColor:[UIColor sidraFlatTurquoiseColor]];
        [self setTintColor:[UIColor whiteColor] forSegmentAtIndex:0 titleName:[socialNetworkName objectAtIndex:0]];
        [self setTintColor:[UIColor redColor] forSegmentAtIndex:1 titleName:[socialNetworkName objectAtIndex:1]];
        [self setTintColor:faceBookColor forSegmentAtIndex:2 titleName:[socialNetworkName objectAtIndex:2]];
        
        // Twitter
        twitterWebView.hidden = NO;
        youtubeWebView.hidden = YES;
        facebookWebView.hidden = YES;
        [twitterWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:twitterURL]]];
    }
    
    else if(segment.selectedSegmentIndex==1){
        
        //UI Color Change
        [tabBarControlView setTintColor:[UIColor sidraFlatTurquoiseColor]];
        [self setTintColor:[UIColor sidraFlatTurquoiseColor] forSegmentAtIndex:0 titleName:[socialNetworkName objectAtIndex:0]];
        [self setTintColor:[UIColor whiteColor] forSegmentAtIndex:1 titleName:[socialNetworkName objectAtIndex:1]];
        [self setTintColor:faceBookColor forSegmentAtIndex:2 titleName:[socialNetworkName objectAtIndex:2]];
        
        // Youtube
        twitterWebView.hidden = YES;
        youtubeWebView.hidden = NO;
        facebookWebView.hidden = YES;
        [youtubeWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:youtubeURL]] ];
    }
    
    else if (segment.selectedSegmentIndex==2){
        
        // UI Color Change
        [tabBarControlView setTintColor:[UIColor sidraFlatTurquoiseColor]];
        [self setTintColor:[UIColor sidraFlatTurquoiseColor] forSegmentAtIndex:0 titleName:[socialNetworkName objectAtIndex:0]];
        [self setTintColor:[UIColor redColor] forSegmentAtIndex:1 titleName:[socialNetworkName objectAtIndex:1]];
        [self setTintColor:[UIColor whiteColor] forSegmentAtIndex:2 titleName:[socialNetworkName objectAtIndex:2]];
        
        // FaceBook
        twitterWebView.hidden = YES;
        youtubeWebView.hidden = YES;
        facebookWebView.hidden = NO;
        [facebookWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:facebookURL]] ];
    }
    
}


#pragma mark - UIWebView Delegate

-(void)webViewDidStartLoad:(UIWebView *)webView {
    XLog(@"start");
    [XIBWebActivityIndicator startActivity:self];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    XLog(@"finish");
    [XIBWebActivityIndicator dismissActivity];
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    return YES;
//}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    XLog(@"Error for WEBVIEW: %@", [error description]);
    [XIBWebActivityIndicator dismissActivity];
}

- (void)dealloc{
    [twitterWebView removeFromSuperview];
    [youtubeWebView removeFromSuperview];
    [facebookWebView removeFromSuperview];
    twitterWebView = nil;
    youtubeWebView = nil;
    facebookWebView = nil;
}


#pragma mark - UI Color For Segmented Control

- (void)setTintColor:(UIColor *)tintColor forSegmentAtIndex:(NSUInteger)segment titleName:(NSString*)title{
    
    if (title)
    {
        UIFont *font = [UIFont systemFontOfSize:14.0f];
        NSDictionary *attributes = @{NSFontAttributeName:font,
                                     NSForegroundColorAttributeName:tintColor};
        
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:title attributes:attributes];
        
        UIImage *image = [self imageFromAttributedString:attributedString];
        
        [tabBarControlView setImage:image forSegmentAtIndex:segment];
    }
}

- (UIImage *)imageFromAttributedString:(NSAttributedString *)text
{
    UIGraphicsBeginImageContextWithOptions(text.size, NO, 0.0);
    
    // draw in context
    [text drawAtPoint:CGPointMake(0.0, 0.0)];
    
    // transfer image
    UIImage *image = [UIGraphicsGetImageFromCurrentImageContext() imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIGraphicsEndImageContext();
    
    return image;
}

+ (BOOL)isIOS7
{
    static BOOL isIOS7 = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSInteger deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] integerValue];
        if (deviceSystemMajorVersion >= 7) {
            isIOS7 = YES;
        }
        else {
            isIOS7 = NO;
        }
    });
    return isIOS7;
}

@end
