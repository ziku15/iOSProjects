//
//  RootViewController.m
//  Pulse
//
//  Created by xibic on 5/28/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "RootViewController.h"

#import "CommonViewController.h"

#import "SettingsViewController.h"
#import "AnnouncementViewController.h"
#import "ClassifiedsViewController.h"
#import "EventsViewController.h"
#import "ForumsViewController.h"
#import "HumanResourcesViewController.h"
#import "NewsLetterViewController.h"
#import "OffersAndPromotionsViewController.h"
#import "PoliciesViewController.h"
#import "StaffDirectoryViewController.h"
#import "StaffSearchViewController.h"
#import "StayInformedViewController.h"
#import "GalleryViewController.h"

#import "XIBButtonScrollView.h"
#import "XIBSearchBar.h"

@interface RootViewController ()<XIBButtonScrollViewDelegate,XIBSearchBarDelegate,ForumPostViewDelegate>{
    XIBButtonScrollView *buttonScrollView;
    XIBSearchBar *directorySearchBar;
    BOOL postedOnForum;
    
    
    
}

@end

@implementation RootViewController

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - ViewWillAppear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
   
    
    dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Notifications Queue", NULL);
    dispatch_async(backgroundQueue, ^{
        if (![[UserManager sharedManager].userID isEqualToString:@"0"]) {
            ///*
            [[ServerManager sharedManager] fetchAllNotifications:^(BOOL success, NSMutableArray *resultDataArray) {
                if (success && buttonScrollView!=nil) {
                    //call this methode after server finish call
                    
                    MenuItem *item = (MenuItem *)[resultDataArray objectAtIndex:0];
                    
                    if(item.announcement != 0)[buttonScrollView showButtonNotificationsForButton:kAnnouncement withNumber:item.announcement];
                    if(item.classified != 0)[buttonScrollView showButtonNotificationsForButton:kClassifieds withNumber:item.classified];
                    if(item.event != 0)[buttonScrollView showButtonNotificationsForButton:kEvents withNumber:item.event];
                    if(item.gallery != 0)[buttonScrollView showButtonNotificationsForButton:kGallery withNumber:item.gallery];
                    if(item.offerAndPromotion != 0)[buttonScrollView showButtonNotificationsForButton:kOffersAndPromotions withNumber:item.offerAndPromotion];
                    //if(item.forums != 0)[buttonScrollView showButtonNotificationsForButton:kForums withNumber:item.forums];
                    
                }else{
                    
                }
            }];
            // */
        }
    });
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - ViewDidLoad
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"Main Menu";
    self.view.backgroundColor = [UIColor sidraFlatLightGrayColor];
    
    [self addSettingsButton];
    
    [self addStaffSearchView];
    
    [self addMenuButtonsView:@[
                           @{@"Announcements":@"announcements"},
                           @{@"Staff Directory":@"staff_directory"},
                           @{@"Forums":@"forums"},
                           @{@"Classifieds":@"classifieds"},
                           @{@"Offers & Promotions":@"offers_promotions"},
                           @{@"Events":@"events"},
                           @{@"Newsletter":@"newsletter"},
                           @{@"Gallery":@"gallery"},
                           @{@"Human Resources":@"human_resources"},
                           @{@"Policies":@"policies"},
                           @{@"Stay Informed":@"stay_informed"} ]
     ];
    
    [self addShareOnForumView];
    
    //Parser testing
    //[self testParserMethod];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dismissForumPostView:)
                                                 name:@"forumPostViewHide" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pushViewFromNotification:)
                                                 name:@"pushNotificationType" object:nil];
    
}

/* ****** SETTINGS - START ****** */
#pragma mark - Settings
- (void)addSettingsButton{
    OBShapedButton *settingsButton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
    [settingsButton setFrame:CGRectMake(0.0f, 0.0f, 53.0f,50.0f)];
    [settingsButton setImage:[UIImage imageNamed:@"setting_btn.png"] forState:UIControlStateNormal];
    [settingsButton addTarget:self
                   action:@selector(settingsButtonAction)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    // Add a negative spacer on iOS >= 7.0
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -18;
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, barButton, nil]];
    
    
    
    
    
    
    //self.navigationItem.rightBarButtonItem = barButton;
    //self.navigationItem.rightBarButtonItem.imageInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    
}

- (void)settingsButtonAction{
    SettingsViewController *settingsView = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    settingsView.shouldShowBackButton = YES;
    [self.navigationController pushViewController:settingsView animated:YES];
    
}
/* ****** SETTINGS - END ****** */






/* ****** FORUM POST - START ****** */

#pragma mark - Share on Forum
- (void)addShareOnForumView{
    UIView *bottomCommentView = [[UIView alloc] initWithFrame:CGRectMake(20.0f, SCREEN_SIZE.height-100, 280.0f, 34.0f)];
    bottomCommentView.backgroundColor = [UIColor sidraFlatLightGrayColor];
    [self.view addSubview:bottomCommentView];
    /*
     bottomCommentView.backgroundColor = [UIColor sidraFlatLightGrayColor];
     [bottomCommentView.layer setBorderColor:[[[UIColor sidraFlatDarkGrayColor] colorWithAlphaComponent:1.0] CGColor]];
     [bottomCommentView.layer setBorderWidth:kViewBorderWidth];
     bottomCommentView.clipsToBounds = YES;
     */
    
    UITapGestureRecognizer *singleTapOnProfile =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forumPostButtonAction:)];
    [singleTapOnProfile setNumberOfTapsRequired:1];
    [bottomCommentView addGestureRecognizer:singleTapOnProfile];
    
    
    UIView *whiteBorder = [[UIView alloc] initWithFrame:CGRectMake(00, 0.0, 280, 30)];
    whiteBorder.backgroundColor = [UIColor whiteColor];
    [bottomCommentView addSubview:whiteBorder];
    [whiteBorder.layer setBorderColor:[[[UIColor sidraFlatGrayColor] colorWithAlphaComponent:1.0] CGColor]];
    [whiteBorder.layer setBorderWidth:kViewBorderWidth];
    [whiteBorder.layer setCornerRadius:kViewCornerRadius];
    whiteBorder.clipsToBounds = YES;
    
    
    UIImageView *cameraBtn = [[UIImageView alloc]initWithFrame:CGRectMake( 5, 3 , 30, 23)];
    cameraBtn.image = [UIImage imageNamed:@"cameraBtn.png"];
    [whiteBorder addSubview:cameraBtn];
    
    UILabel *replyText = [[UILabel alloc]initWithFrame:CGRectMake(50, 7, 200, 15)];
    replyText.text = @"Share on Sidra Forum";
    replyText.font = [UIFont systemFontOfSize:14];
    replyText.textColor = [UIColor sidraFlatGrayColor];
    [whiteBorder addSubview:replyText];
}


- (void)forumPostButtonAction:(id)sender{
    
    self.self.forumPostView = [[ForumPostView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) forPostView:NO withHashTag:@""];
    self.forumPostView.backgroundColor  = [UIColor clearColor];
    self.forumPostView.delegate = self;
    self.forumPostView.postID = @"";
    [[UIApplication sharedApplication].keyWindow addSubview:self.forumPostView];
    
}

#pragma mark - self.forumPostView Delegate
-(void)sendBtnValue:(NSString *)text commentItem:(CommentItem *)item{
    XLog(@"post : %@", text);
    XLog(@"item : %@", item);
    [self.forumPostView removeFromSuperview];
    self.forumPostView = nil;
    
    //post notification
    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/8.0, [UIScreen mainScreen].bounds.size.height/5.0 , 160, 50);
    NSString *msg = @"Posted Successfully to the Sidra Forum";
    AlertPopView *alertMsg = [[AlertPopView alloc] initWithFrame:frame alertMsg:msg];
    [self.view addSubview:alertMsg];
    alertMsg = nil;
}

-(void) cancelComment {
    [self.forumPostView removeFromSuperview];
    self.forumPostView = nil;
}

- (void)dismissForumPostView:(NSNotification *)notif{
    [self cancelComment];
}

-(void)isPostingContinue:(BOOL)isPost {
    
}
/* ****** FORUM POST - END ****** */




/* ****** SEARCH - START ****** */

#pragma mark - Staff Search
- (void)addStaffSearchView{
    directorySearchBar = [[XIBSearchBar alloc] initWithFrame:CGRectMake(10, 0, 300, 50) withPlaceholderText:@"Search staff directory"];
    directorySearchBar.delegate = self;
    [self.view addSubview:directorySearchBar];
}
#pragma mark - XIBSearchBarDelegate 
- (void)searchResult:(NSArray *)resultArray forText:(NSString *)searchText{
    XLog(@"Search result for text:%@ - %@",searchText,resultArray);
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedString = [searchText stringByTrimmingCharactersInSet:charSet];
    if ([trimmedString isEqualToString:@""]) {
        // it's empty or contains only white spaces
    }
    else{
    
    
    StaffSearchViewController *viewController = [[StaffSearchViewController alloc] initWithNibName:@"StaffSearchViewController" bundle:nil];
    viewController.staffArray = resultArray;
    viewController.searchKey = searchText;
    [self.navigationController pushViewController:viewController animated:YES];
    viewController = nil;
    }
    
}

/* ****** SEARCH - END ****** */






/* ****** MENU - START ****** */
#pragma mark - Menu Buttons
- (void)addMenuButtonsView:(NSArray*)buttonTitlesArray{
    CGSize buttonScrollViewSize;
    
    if (IPHONE_5) buttonScrollViewSize = CGSizeMake(320, 478);
    else buttonScrollViewSize = CGSizeMake(320, 420);
    
    buttonScrollView = [[XIBButtonScrollView alloc] initWithFrame:CGRectMake(0.0f, 30.0f,buttonScrollViewSize.width,buttonScrollViewSize.height)
                                                      withButtons:buttonTitlesArray
                                                    andButtonSize:CGSizeMake(130, IPHONE_5?120:100)];
    buttonScrollView.delegate = self;
    [self.view addSubview:buttonScrollView];
    
    UITapGestureRecognizer *hideKeyboardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapHideKeyboard:)];
    [buttonScrollView addGestureRecognizer:hideKeyboardTap];
    [self.view addSubview:buttonScrollView];
    hideKeyboardTap = nil;
    
}

- (void)scrollViewTapHideKeyboard:(UIGestureRecognizer*)gestureRecognizer {
    [self.view endEditing:YES];
}


#pragma mark - XIBButtonScrollView delegate
- (void)buttonClicked:(int)buttonId{
    
    switch (buttonId) {
        case kAnnouncement:
            [self pushViewController:@"Announcement"];
            break;
        case kStaffDirectory:
            [self pushViewController:@"StaffDirectory"];
            break;
        case kForums:
            [self pushViewController:@"Forums"];
            break;
        case kClassifieds:
            [self pushViewController:@"Classifieds"];
            break;
        case kOffersAndPromotions:
            [self pushViewController:@"OffersAndPromotions"];
            break;
        case kEvents:
            [self pushViewController:@"Events"];
            break;
        case kNewsLetter:
            [self pushViewController:@"NewsLetter"];
            break;
        case kGallery:
            [self pushViewController:@"Gallery"];
            break;
        case kHumanResources:
            [self pushViewController:@"HumanResources"];
            break;
        case kPolicies:
            [self pushViewController:@"Policies"];
            break;
        case kStayInformed:
            [self pushViewController:@"StayInformed"];
            break;

        default:
            break;
    }
}

- (void)pushViewController:(NSString*)className{
    [self.view endEditing:YES];
    NSString *ViewControllerClass = [NSString stringWithFormat:@"%@ViewController",className];
    UIViewController *viewController = [[NSClassFromString(ViewControllerClass) alloc] initWithNibName:ViewControllerClass bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    viewController = nil;
}
/* ****** MENU - END ****** */

- (void)pushViewFromNotification:(NSNotification *)notif{
    //[self cancelComment];
    
    if ([notif.name isEqualToString:@"pushNotificationType"]){

        NSDictionary* userInfo = notif.userInfo;
        NSString *notoficationType = [NSString stringWithFormat:@"%d",[[userInfo valueForKey:@"type"] integerValue]];
        XLog(@"Notification type: %@",notoficationType);
        if ([notoficationType isEqualToString:@"1"]) {
            //Announcement
            [self performSelector:@selector(pushViewController:) withObject:@"Announcement" afterDelay:1.0f];
        }
        else if ([notoficationType isEqualToString:@"2"]) {
            //Forums
            [self performSelector:@selector(pushViewController:) withObject:@"Forums" afterDelay:1.0f];
        }
        else if ([notoficationType isEqualToString:@"3"]) {
            //Event
            [self performSelector:@selector(pushViewController:) withObject:@"Events" afterDelay:1.0f];
        }
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:@"pushNotificationType"];
}




/* ********** TEST ********** */
- (void)testParserMethod{
   
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
