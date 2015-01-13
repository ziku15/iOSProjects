//
//  NewsWebViewController.m
//  Pulse
//
//  Created by Atomix on 7/10/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "NewsWebViewController.h"

@interface NewsWebViewController ()<UIWebViewDelegate,UIAlertViewDelegate>{
    UIWebView *newsLetterWebView;
}

@end

@implementation NewsWebViewController

@synthesize webLink;

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
    // Do any additional setup after loading the view from its nib.
    
    // added Web View
    
    newsLetterWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 65)];
    NSString *url;
    if ([self.webLink hasPrefix:@"http://"] || [self.webLink hasPrefix:@"https://"]) {
        url = self.webLink;
    }else{
        NSString *prefix = @"http://";
        url = [prefix stringByAppendingString:self.webLink];
    }
    NSURL *nsurl = [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:nsurl];
    newsLetterWebView.delegate = self;
    [newsLetterWebView loadRequest:urlReq ];
    [self.view addSubview:newsLetterWebView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIWebView Delegate

-(void)webViewDidStartLoad:(UIWebView *)webView{
    XLog(@"start");
    [XIBWebActivityIndicator startActivity:self];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    XLog(@"finish");
    [XIBWebActivityIndicator dismissActivity];
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    return YES;
//}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    XLog(@"Error for WEBVIEW: %@", [error description]);
    [XIBWebActivityIndicator dismissActivity];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!!!!" message:[error description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)dealloc{
    [newsLetterWebView removeFromSuperview];
    newsLetterWebView = nil;
}

#pragma alertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [super goBack];
}


@end
