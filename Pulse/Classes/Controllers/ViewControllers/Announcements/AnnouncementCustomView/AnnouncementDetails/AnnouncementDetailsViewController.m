//
//  AnnouncementDetailsViewController.m
//  Pulse
//
//  Created by Supran on 6/17/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "AnnouncementDetailsViewController.h"
#import "VideoPreViewController.h"

@interface AnnouncementDetailsViewController ()

@end

@implementation AnnouncementDetailsViewController
@synthesize detailsItem;
@synthesize selectedIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init:(AnnouncementItem *)item with:(NSInteger)index{
    self = [super init];
    if (self) {
        self.title = @"Announcement";
        detailsItem = item;
        selectedIndex = index;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Create main Scrollview
    UIScrollView *mainScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width-10, self.view.frame.size.height-10)];
    [mainScrollview setContentSize:CGSizeMake(mainScrollview.frame.size.width, mainScrollview.frame.size.height)];
    mainScrollview.backgroundColor = [UIColor whiteColor];
    mainScrollview.layer.borderColor = [UIColor lightGrayColor].CGColor;
    mainScrollview.layer.borderWidth = 0.5f;
    mainScrollview.layer.cornerRadius = kViewCornerRadius;
    [self.view addSubview:mainScrollview];
    
    
    // Create title label
    CommonDynamicCellModel *titleLabelInfo = [[CommonHelperClass sharedConstants] calculateLabelMaxSize:detailsItem.title with:[UIFont boldSystemFontOfSize:16.0f] with:mainScrollview.frame.size.width-4];
    //Title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, 0, mainScrollview.frame.size.width-4, titleLabelInfo.maxSize.height > 48 ? titleLabelInfo.maxSize.height : 48)];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    [titleLabel setFont:titleLabelInfo.maxFont];
    [titleLabel setTextColor:[UIColor sidraFlatTurquoiseColor]];
    [titleLabel setText:titleLabelInfo.maxTitle];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [mainScrollview addSubview:titleLabel];


    // Create Category label
    UILabel *categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, titleLabel.frame.origin.y + titleLabel.frame.size.height  +2,
                                                                       mainScrollview.frame.size.width-4, 20)];
    [categoryLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [categoryLabel setTextColor:[UIColor sidraFlatRedColor]];
    [categoryLabel setText:[NSString stringWithFormat:@"Type : %@", detailsItem.cat_name]];
    [categoryLabel setBackgroundColor:[UIColor clearColor]];
    [mainScrollview addSubview:categoryLabel];

    // Create date label
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, categoryLabel.frame.origin.y+ categoryLabel.frame.size.height,
                                                                   mainScrollview.frame.size.width-4, categoryLabel.frame.size.height)];
    [dateLabel setTextColor:[UIColor sidraFlatRedColor]];
    [dateLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [dateLabel setText:[[CommonHelperClass sharedConstants] getDateNameFormat2:detailsItem.createdDate]];
    [mainScrollview addSubview:dateLabel];
    
    UIView *endLineView = [[UIView alloc] init];
    [endLineView setBackgroundColor:[UIColor sidraFlatLightGrayColor]];
    [endLineView setFrame:CGRectMake(10.0f, dateLabel.frame.origin.y+dateLabel.frame.size.height+5, 290.0f, 1.0f)];
    [mainScrollview addSubview:endLineView];

    // Create Details label
    //detailsItem.description = @"Lorem Announcement Title Goes Here: a maximum of two lines are allowed here here here here here here here x Announcement Title Goes Here: a maximum of two lines are allowed here here here here here here here x Announcement Title Goes Here: a maximum of two lines are allowed here here here here here here here x Announcement Title Goes Here: a maximum of two lines are allowed here here here here here here here x Announcement Title Goes Here: a maximum of two lines are allowed here here here here here here here x Announcement Title Goes Here: a maximum of two lines are allowed here here here here here here here x Announcement Title Goes Here: a maximum of two lines are allowed here here here here here here here x Announcement Title Goes Here: a maximum of two lines are allowed here here here here here here here x Announcement Title Goes Here: a maximum of two lines are allowed here here here here here here here x Announcement Title Goes Here: a maximum of two lines are allowed here here here here here here here x Announcement Title Goes Here: a maximum of two lines are allowed here here here here here here here x Announcement Title Goes Here: a maximum of two lines are allowed here here here here here here here x Announcement Title Goes Here: a maximum of two lines are allowed here here here here here here here x Announcement Title Goes Here: a maximum of two lines are allowed here here here here here here here x Announcement Title Goes Here: a maximum of two lines are allowed here here here here here here here x Z";
    
    CommonDynamicCellModel *detailsDetails = [[CommonHelperClass sharedConstants] calculateLabelMaxSize:detailsItem.a_description with:[UIFont systemFontOfSize:14.0f] with:mainScrollview.frame.size.width-4];
    
    
    STTweetLabel *detailsLabel = [[STTweetLabel alloc] initWithFrame:CGRectMake(4, dateLabel.frame.origin.y + dateLabel.frame.size.height +10,
                                                                      mainScrollview.frame.size.width-4, detailsDetails.maxSize.height)];
    detailsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    detailsLabel.numberOfLines = 0;
    [detailsLabel setFont:detailsDetails.maxFont];//[UIFont fontWithName:@"ProximaNova-Regular" size:15.0f]];
    [detailsLabel setTextColor:[UIColor sidraFlatDarkGrayColor]];
    [detailsLabel setText:detailsDetails.maxTitle];
    [detailsLabel setBackgroundColor:[UIColor clearColor]];
    [mainScrollview addSubview:detailsLabel];
    
    [detailsLabel setDetectionBlock:^(STTweetHotWord hotWord, NSString *string, NSString *protocol, NSRange range) {
        [self openExternalBrowserWithURL:string];
    }];
    
    //set mainscrollview content size
    [mainScrollview setContentSize:CGSizeMake(mainScrollview.frame.size.width, detailsLabel.frame.origin.y + detailsLabel.frame.size.height + 10)];
    
    if (!detailsItem.isRead) {
        [[ServerManager sharedManager] updateReadStatusForItem:detailsItem.itemID type:@"1" completion:^(BOOL success) {
            if (success) {
                detailsItem.isRead = !detailsItem.isRead;
            }
        }];
    }
    
    
    
    //[self.view setBackgroundColor:[UIColor sidraFlatLightGrayColor]];
}

- (void)openExternalBrowserWithURL:(NSString *)urlString{
    
    if (([urlString rangeOfString:@"https://"].location != NSNotFound)||
        ([urlString rangeOfString:@"http://"].location != NSNotFound)||
        ([urlString rangeOfString:@"www."].location != NSNotFound)){
        VideoPreViewController *showVideoOnWebView = [[VideoPreViewController alloc]initWithNibName:@"VideoPreViewController" bundle:nil];
        showVideoOnWebView.videoLink = urlString;
        [self.navigationController pushViewController:showVideoOnWebView animated:YES];
    }else{
        NSString *regEX = @"[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\\.[a-zA-Z]{2,4}";
        NSMutableString *tmpText = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@",urlString]];
        
        NSError *regexError = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regEX options:0 error:&regexError];
        
        [regex enumerateMatchesInString:tmpText options:0 range:NSMakeRange(0, tmpText.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            NSString *protocol = @"@";
            NSString *link = [tmpText substringWithRange:result.range];
            NSRange protocolRange = [link rangeOfString:protocol];
            if (protocolRange.location != NSNotFound) {
                //valid email add
                dispatch_async(dispatch_get_main_queue(), ^{
                    XLog(@"valid email address");//
                    [self sendMail:urlString];
                    
                });
            }
        }];
    }
    
}

#pragma send email



//send Mail
-(void)sendMail:(NSString *)mailAddress {
    
    if ([MFMailComposeViewController canSendMail]) {
        
        NSArray *toRecipents = [NSArray arrayWithObject:mailAddress];
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setToRecipients:toRecipents];
        [mc setSubject:@"RE:"];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
        
    }
    
    else {
        UIAlertView  *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Device is not configured to send mail" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
