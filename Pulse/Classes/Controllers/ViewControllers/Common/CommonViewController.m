//
//  CommonViewController.m
//  Brand
//
//  Created by xibic on 5/12/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "CommonViewController.h"

@interface CommonViewController (){
    UIActivityIndicatorView *activityIndicator;
    int pullToRefresh;
    
}

@end

@implementation CommonViewController

@synthesize shouldShowBackButton,shouldShowRightMenuButton;

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        NSString *titleString = NSStringFromClass([self class]);
//        titleString = [titleString stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
//        self.title = titleString;
//    }
//    return self;
//}


#pragma mark - Back to Menu
- (void)addCustomBackButton{
    //Back Button
    OBShapedButton *backButton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0.0f, 0.0f, 53.0f,47.0f)];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(goBack)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil action:nil];
    negativeSpacer.width = -20;
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, barButton, nil]];
    
    
    
    //self.navigationItem.leftBarButtonItem = barButton;
}

- (void)goBack{
    [loadingView dismisssView];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Show Menu Button
- (void)addCustomNavigationBarRightButton{
    //Back Button
    OBShapedButton *menuButton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
    [menuButton setFrame:CGRectMake( SCREEN_SIZE.width - 53.0f, 0.0f, 53.0f,47.0f)];
    [menuButton setImage:[UIImage imageNamed:@"menu_btn.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self
                   action:@selector(rightBarButtonAction)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -20;
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, barButton, nil]];

    
    //self.navigationItem.rightBarButtonItem = barButton;
}

- (void)rightBarButtonAction{
    [loadingView dismisssView];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

#pragma mark -ViewDidLoad
- (void)viewDidLoad{
    [super viewDidLoad];
    menuSignature = common_index;
    [loadingView dismisssView];
    self.view.backgroundColor = [UIColor sidraFlatLightGrayColor];
    //if(self.shouldShowBackButton){[self addCustomBackButton];}
    //else { self.navigationItem.hidesBackButton = YES; }
    [self addCustomBackButton];
    
    if(self.shouldShowRightMenuButton){[self addCustomNavigationBarRightButton];}
    else { self.navigationItem.rightBarButtonItem =  nil; }

    isLoading = NO;
    isPulling = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userAuthenticationFailed:)
                                                 name:@"xxx" object:nil];
    
    loadingView = [[XIBLoadingView alloc] init];
    
    
}


#pragma mark -
#pragma mark - Hide Keyboard on BG Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
      float  endScrolling2=0.0;;
    if(scrollView.contentSize.height>=scrollView.frame.size.height){
        endScrolling2  = scrollView.frame.size.height+scrollView.contentOffset.y+1 ;
    }
    
    
     XLog(@"\nAfter SCROLLING is pull:%d",pullToRefresh);
   
    if(isPulling){
        
        if(scrollView.contentOffset.y<=0){
            
            [self pullDownToRefresh];
            
        }

        else{
            
            
                
                
                if(endScrolling2>=scrollView.contentSize.height && endScrolling2>=scrollView.frame.size.height){
                      [self pullUpToRefresh];
                    
                }
                else if(endScrolling2<1 &&endScrolling2>-1){
                 [loadingView dismisssView];
                }
                
                else{
                    XLog(@"\n NOT SCROLLING:");
                    [loadingView dismisssView];
                   
                }
            
            
     
        }
    

           isPulling = false;
    }
    else{
       

       
    }

     [self stoppedDragging];
}

/*
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    [self isDragging];
   
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self stoppedDragging];

}*/


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    //float endScrolling = scrollView.contentOffset.y + scrollView.contentSize.height;
    
    float  endScrolling2=0.0;;
 
    if(scrollView.contentSize.height>=scrollView.frame.size.height){
        endScrolling2  = scrollView.frame.size.height+scrollView.contentOffset.y+1 ;
    }
    
    if(scrollView.contentOffset.y<=0){
        
        [self loadingPullDownView];
        isPulling = true;
        //pullToRefresh = 0;
    
    }
    else
    {
       
        
    if(endScrolling2>=scrollView.contentSize.height && endScrolling2>=scrollView.frame.size.height){
         [self loadingPullUpView];
        XLog(@"\nSCROLLING:");
        isPulling = true;
        //pullToRefresh = 1;
    
    }
             
    else{
                    XLog(@"\n NOT SCROLLING:");
        isPulling = false;
        //pullToRefresh = 0;
    }
    }
             
    
    XLog(@"\nSCROLLING: Content Offset %f -----\nContent size %f -------\nscreen size %f\n endscroll  %f",scrollView.contentOffset.y , scrollView.contentSize.height, scrollView.frame.size.height,endScrolling2);
   // float offset = scrollView.contentOffset.y;

    
    /*if (endScrolling <= 490 && endScrolling >= 485){
    //if (offset<=-3.0f){//endScrolling <= 490 && endScrolling >= 485){
       // XLog(@"\n>>>>Scroll UP Called, %f",endScrolling);
        
        if (!isPulling) {
            isPulling = true;
            pullToRefresh = 0;
            XLog(@"<<<<<<<<<<Release to refreash>>>>>>>>>>>>>");
            [self loadingPullDownView];
            
        }
        
    }
    
    if (endScrolling >= (scrollView.contentSize.height-SCROLL_CONSIDER_HEIGHT)){
        XLog(@"\n>>>>>>Pull UP %f",scrollView.contentSize.height);
        
        if (!isPulling) {
            isPulling = true;
            pullToRefresh = 1;
            [self loadingPullUpView];
        }
        
    }*/
    
    
}


//***********************************************

-(void) loadingPullUpView{
    [[UIApplication sharedApplication].keyWindow addSubview:loadingView];
//    [self.view bringSubviewToFront:loadingView];
//    [self.view addSubview:loadingView];

   }

-(void) loadingPullDownView{
    [[UIApplication sharedApplication].keyWindow addSubview:loadingView];
//    [self.view sendSubviewToBack:loadingView];
//    [self.view addSubview:loadingView];
    
}


- (void)isDragging{
    
}
- (void)stoppedDragging{
    
}



- (void)pullDownToRefresh{
    
}
- (void)pullUpToRefresh{
    
}

#pragma mark - parent view controller delegate

//set title and subtitle text to the navigation bar
-(void)setNavigationCustomTitleView:(NSString *)titleText with:(NSString *)subtitleText{
    //First Remove previous view
    for (UIView *view in self.navigationItem.titleView.subviews) {
        [view removeFromSuperview];
    }
    
    
    //Create view and add to the title view
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ([subtitleText isEqualToString:@""]?6:2), 0, 0)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.text = titleText;
    [titleLabel sizeToFit];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, 0, 0)];
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.textColor = [UIColor whiteColor];
    subTitleLabel.font = [UIFont systemFontOfSize:11];
    subTitleLabel.text = subtitleText;
    [subTitleLabel sizeToFit];
    
    UIView *twoLineTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAX(subTitleLabel.frame.size.width, titleLabel.frame.size.width), 30)];
    [twoLineTitleView addSubview:titleLabel];
    [twoLineTitleView addSubview:subTitleLabel];
    
    float widthDiff = subTitleLabel.frame.size.width - titleLabel.frame.size.width;
    
    if (widthDiff > 0) {
        CGRect frame = titleLabel.frame;
        frame.origin.x = widthDiff / 2;
        titleLabel.frame = CGRectIntegral(frame);
    }else{
        CGRect frame = subTitleLabel.frame;
        frame.origin.x = abs(widthDiff) / 2;
        subTitleLabel.frame = CGRectIntegral(frame);
    }
    
    self.navigationItem.titleView = twoLineTitleView;
}

- (void)showLoginView{
    
    if( ![self.navigationController.presentedViewController isKindOfClass:[LoginViewController class]] ){
        LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController presentViewController:loginView animated:YES completion:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        loginView = nil;
    }
}
- (void)userAuthenticationFailed:(NSNotification *)notif{
    //NSLog(@"Received Notification");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self showLoginView];
}

#pragma mark -
#pragma mark Cleanup

/*---------------------------------------------------------------------------
 * Cleanup
 *--------------------------------------------------------------------------*/

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
