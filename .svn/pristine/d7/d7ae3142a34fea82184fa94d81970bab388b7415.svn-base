//
//  NewsLetterViewController.m
//  Pulse
//
//  Created by xibic on 6/11/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "NewsLetterViewController.h"

@interface NewsLetterViewController ()<UIWebViewDelegate>

@end

@implementation NewsLetterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Newsletter";
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // added Web View
    
    UIWebView *newsLetterWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 65)];
    
    NSString *url = @"http://0380e28.netsolhost.com/jananewsletter/";
    NSURL *nsurl = [NSURL URLWithString:url];
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:nsurl];
    newsLetterWebView.delegate = self;
    [newsLetterWebView loadRequest:urlReq ];
    [self.view addSubview:newsLetterWebView];
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

@end
