//
//  AllClassifiedDetailsViewController.m
//  Pulse
//
//  Created by Supran on 7/9/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "ClassifiedDetailsViewController.h"
#import "VideoPreViewController.h"

@interface ClassifiedDetailsViewController () <UIAlertViewDelegate,XIBPhotoScrollViewDelegate,FullScreenPhotoViewerDelegate>{
    UIScrollView *mainScrollview;
    NSMutableArray *photosArray;
    FullScreenPhotoViewer *fullScreenPhotoView;
}

@end

@implementation ClassifiedDetailsViewController
@synthesize selectedIndex;
@synthesize isDeleteClick;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(id)init:(ClassifiedItem *)item selectionIndex:(NSInteger)selIndex{
    self = [super init];
    if (self) {
        [super setNavigationCustomTitleView:@"Classified" with:@"Post Details"];
        dataItems = item;
        selectedIndex = selIndex;
        isDeleteClick = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Create main Scrollview
    mainScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainScrollview.showsHorizontalScrollIndicator = mainScrollview.showsVerticalScrollIndicator = NO;
    [mainScrollview setContentSize:CGSizeMake(mainScrollview.frame.size.width, mainScrollview.frame.size.height)];
    [self.view addSubview:mainScrollview];
    
    if (IPHONE_5) {
        [mainScrollview setFrame:CGRectMake(mainScrollview.frame.origin.x, mainScrollview.frame.origin.y, mainScrollview.frame.size.width, self.view.frame.size.height - 64)];
    }
    else{
        [mainScrollview setFrame:CGRectMake(mainScrollview.frame.origin.x, mainScrollview.frame.origin.y, mainScrollview.frame.size.width, 480-64)];
    }
    
    
    UIView *topMainView = [[UIView alloc] initWithFrame:CGRectMake(mainScrollview.frame.origin.x+5, 5, mainScrollview.frame.size.width-10, 200)];
    [topMainView setBackgroundColor:[UIColor whiteColor]];
    topMainView.layer.borderColor = [UIColor sidraFlatGrayColor].CGColor;
    topMainView.layer.borderWidth = 0.5f;
    topMainView.layer.cornerRadius = kViewCornerRadius;
    [mainScrollview addSubview:topMainView];
    

    UILabel *titleLabel = [self createTitleView:topMainView with:[NSString stringWithFormat:@"%@",dataItems.title]];
    UILabel *dateLabel = [self createDateView:titleLabel with:topMainView with:[NSString stringWithFormat:@"%@",dataItems.createdDate]];
    UIView *postView = [self createPostedByView:dateLabel with:topMainView];
    
    
    UIView *endLineView = [[UIView alloc] init];
    [endLineView setBackgroundColor:[UIColor sidraFlatLightGrayColor]];
    [endLineView setFrame:CGRectMake(postView.frame.origin.x, postView.frame.origin.y + postView.frame.size.height + 5, titleLabel.frame.size.width-10, 1)];
    [topMainView addSubview:endLineView];
    [topMainView setFrame:CGRectMake(topMainView.frame.origin.x, topMainView.frame.origin.y, topMainView.frame.size.width, endLineView.frame.origin.y + endLineView.frame.size.height)];
    
    
    [self createDescriptionView:endLineView parent:topMainView description:dataItems.a_description];
    
    
    
    
    //Create image View
    CGRect newCreateFrame = CGRectMake(topMainView.frame.origin.x, topMainView.frame.origin.y + topMainView.frame.size.height + 15, topMainView.frame.size.width, 160);
    XIBPhotoScrollView *imageScroller = [self addPhotoScrollView:newCreateFrame];
    if (imageScroller!=nil) {
        [mainScrollview setContentSize:CGSizeMake(imageScroller.frame.size.width, imageScroller.frame.size.height + imageScroller.frame.origin.y + 50)];
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Photo Carousel
- (XIBPhotoScrollView *)addPhotoScrollView:(CGRect)frame{
    
    photosArray = [NSMutableArray array];
    for (NSDictionary *dic in dataItems.photos) {
        [photosArray addObject:[dic objectForKey:@"photo"]];
    }
    if (photosArray.count>0) {
        XIBPhotoScrollView *photoScrollView = [[XIBPhotoScrollView alloc] initWithFrame:frame withPhotos:photosArray];
        [mainScrollview addSubview:photoScrollView];
        photoScrollView.delegate = self;
        return photoScrollView;
    }
    return nil;
}


#pragma mark - XIBPhotoScrollView delegate
- (void)imageTap:(int)index{
    //XLog(@"%d",index);
    [self showFullScreenView:index];
}


#pragma mark - FullScreenView
- (void)showFullScreenView:(int)index{

    [[AppManager sharedManager] hideNavigationBar];
    fullScreenPhotoView = [[FullScreenPhotoViewer alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height) photosArray:photosArray withSelectedIndex:index isGallery:NO];
    fullScreenPhotoView.delegate = self;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view addSubview:fullScreenPhotoView];
    }];
    
}

- (void)closePhotoViewer{
    [[AppManager sharedManager] showNavigationBar];
    [UIView animateWithDuration:0.5 animations:^{
        [fullScreenPhotoView removeFromSuperview];
        fullScreenPhotoView = nil;
    }];
}



#pragma mark - Description
-(void)createDescriptionView:(UIView *)previousView parent:(UIView *)parentView description:(NSString *)desText{
    
//    desText = [desText stringByAppendingString:@"nsbkjfbnkjsdbf kjsdfk bsadjkbfkjasbdfk asbdfkbkjsadb fkjsab dkfjbsadkjsab fdkjsbdkjasb fkjbasdkfj baskjf nsbkjfbnkjsdbf kjsdfk bsadjkbfkjasbdfk asbdfkbkjsadb fkjsab dkfjbsadkjsab fdkjsbdkjasb fkjbasdkfj baskjfnsbkjfbnkjsdbf kjsdfk bsadjkbfkjasbdfk asbdfkbkjsadb fkjsab dkfjbsadkjsab fdkjsbdkjasb fkjbasdkfj baskjfnsbkjfbnkjsdbf kjsdfk bsadjkbfkjasbdfk asbdfkbkjsadb fkjsab dkfjbsadkjsab 123 fdkjsbdkjasb fkjbasdkfj baskjf nsbkjfbnkjsdbf kjsdfk bsadjkbfkjasbdfk asbdfkbkjsadb fkjsab dkfjbsadkjsab fdkjsbdkjasb fkjbasdkfj baskjf nsbkjfbnkjsdbf kjsdfk bsadjkbfkjasbdfk asbdfkbkjsadb fkjsab dkfjbsadkjsab fdkjsbdkjasb fkjbasdkfj baskjfnsbkjfbnkjsdbf kjsdfk bsadjkbfkjasbdfk asbdfkbkjsadb fkjsab dkfjbsadkjsab fdkjsbdkjasb fkjbasdkfj baskjfnsbkjfbnkjsdbf kjsdfk bsadjkbfkjasbdfk asbdfkbkjsadb fkjsab dkfjbsadkjsab 123 fdkjsbdkjasb fkjbasdkfj baskjfnsbkjfbnkjsdbf kjsdfk bsadjkbfkjasbdfk asbdfkbkjsadb fkjsab dkfjbsadkjsab fdkjsbdkjasb fkjbasdkfj baskjf nsbkjfbnkjsdbf kjsdfk bsadjkbfkjasbdfk asbdfkbkjsadb fkjsab dkfjbsadkjsab fdkjsbdkjasb fkjbasdkfj baskjfnsbkjfbnkjsdbf kjsdfk bsadjkbfkjasbdfk asbdfkbkjsadb fkjsab dkfjbsadkjsab fdkjsbdkjasb fkjbasdkfj baskjfnsbkjfbnkjsdbf kjsdfk bsadjkbfkjasbdfk asbdfkbkjsadb fkjsab dkfjbsadkjsab 123 fdkjsbdkjasb fkjbasdkfj baskjf 321"];
    
    
    
    
    CommonDynamicCellModel *desDetails = [[CommonHelperClass sharedConstants] calculateLabelMaxSize:desText with:[UIFont systemFontOfSize:12.5f] with:parentView.frame.size.width-20];

    UIView *desView = [[UIView alloc] initWithFrame:CGRectMake(10, previousView.frame.origin.y + previousView.frame.size.height + 5, parentView.frame.size.width-20, (desDetails.maxSize.height < 220?220:desDetails.maxSize.height))];
    [parentView addSubview:desView];
    

    STTweetLabel *desLabel = [[STTweetLabel alloc] initWithFrame:CGRectMake(0, 0, parentView.frame.size.width-20 , desDetails.maxSize.height)];
    [desLabel setTextColor:[UIColor sidraFlatDarkGrayColor]];
    [desLabel setText:desText];
    [desLabel setBackgroundColor:[UIColor clearColor]];
    [desView addSubview:desLabel];
    
    [desLabel setDetectionBlock:^(STTweetHotWord hotWord, NSString *string, NSString *protocol, NSRange range) {
        [self openExternalBrowserWithURL:string];
    }];
    

    [parentView setFrame:CGRectMake(parentView.frame.origin.x, parentView.frame.origin.y, parentView.frame.size.width, desView.frame.origin.y + desView.frame.size.height + 5)];
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


/*
#pragma mark - Mail Delegate Methods

// -------------------------------------------------------------------------------
//	mailComposeController:didFinishWithResult:
//  Dismisses the email composition interface when users tap Cancel or Send.
//  Proceeds to update the message field with the result of the operation.
// -------------------------------------------------------------------------------
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            XLog(@"Result: Mail sending canceled") ;
            break;
        case MFMailComposeResultSaved:
            XLog(@"Result: Mail saved") ;
            break;
        case MFMailComposeResultSent:
            XLog(@"Result: Mail sent") ;
            break;
        case MFMailComposeResultFailed:
            XLog(@"Result: Mail sending failed") ;
            break;
        default:
            XLog( @"Result: Mail not sent");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}
*/




#pragma mark - Posted View
-(NSString *)checkNull:(NSString *)myString{
    if ( (myString == NULL) || [myString  isEqualToString:@""] || myString.length <= 0) {
        myString   = NO_DATA_MESSAGE;
    }
    return myString;
}

-(NSString *)getOwnerInfo:(NSString *)key{
    NSArray *ownerInfo = dataItems.ownerInfo;

    if (ownerInfo.count > 0) {
        NSDictionary *ownerDic = [ownerInfo objectAtIndex:0];
        key = [self checkNull:[NSString stringWithFormat:@"%@",[ownerDic objectForKey:key]]];
//        authorName = [self checkNull:[ownerDic objectForKey:@"name"]];
//        emailAddress = [self checkNull:[ownerDic objectForKey:@"email"]];
//        mobileNumber = [self checkNull:[ownerDic objectForKey:@"mobile"]];
    }
    else{
        key = NO_DATA_MESSAGE;
//        authorName   = @"No data found";
//        emailAddress = @"No data found";
//        mobileNumber = @"No data found";
    }
    return key;
}
-(UIView *)createPostedByView:(UILabel *)previousView with:(UIView *)parentView{
    NSString *authorName = @"";
    NSString *mobileNumber = @"";
    NSString *emailAddress = @"";
    UIColor *colorCode ;

    authorName = [self getOwnerInfo:@"name"];
    emailAddress = [self getOwnerInfo:@"email"];
    mobileNumber = [self getOwnerInfo:@"mobile"];
    
    if ([[UserManager sharedManager].userID isEqualToString:[NSString stringWithFormat:@"%@",dataItems.createdBy]]) {
        authorName = @"You";
        colorCode = [UIColor sidraFlatGreenColor];
    }
    else{
        colorCode = [UIColor sidraFlatTurquoiseColor];
    }
    
    
    
    NSString *initialString = @"Posted By : ";
    
    CGFloat width = previousView.frame.size.width;
    if ([authorName isEqualToString:@"You"]) {

        
        UIButton *delButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [delButton setBackgroundColor:[UIColor clearColor]];
        [delButton setImage:[UIImage imageNamed:@"delete_icon.png"] forState:UIControlStateNormal];
        [delButton addTarget:self
                      action:@selector(deleteActionDetails:)
            forControlEvents:UIControlEventTouchUpInside];
        delButton.frame = CGRectMake(width+5, previousView.frame.origin.y+ previousView.frame.size.height, 25, 25);
        [delButton setCenter:CGPointMake(width + 15, previousView.frame.origin.y+ previousView.frame.size.height)];
        [parentView addSubview:delButton];
        
    }
    // Create date label
    UILabel *postedByLabel = [[UILabel alloc] initWithFrame:CGRectMake(previousView.frame.origin.x, previousView.frame.origin.y+ previousView.frame.size.height, width, 20)];
    [postedByLabel setTextColor:[UIColor grayColor]];
    [postedByLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [postedByLabel setBackgroundColor:[UIColor clearColor]];
    [parentView addSubview:postedByLabel];
    
    
    initialString = [initialString stringByAppendingString:authorName];
    CGFloat textLength = authorName.length;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", initialString]];
    [attrStr addAttribute:NSForegroundColorAttributeName value:colorCode range:NSMakeRange(12, textLength)];
    postedByLabel.attributedText = attrStr;
    
    


    UIView *emailView = [self createEmailView:emailAddress with:parentView with:postedByLabel];
    UIView *mobileView = [self createMobileView:mobileNumber parent:parentView previous:emailView];
    
    
    
    
    [parentView setFrame:CGRectMake(parentView.frame.origin.x, parentView.frame.origin.y, parentView.frame.size.width, mobileView.frame.origin.y + mobileView.frame.size.height)];
    
    return emailView;
}

-(IBAction)deleteActionDetails:(id)sender{
    
    
    NSString *_msg = @"Are you sure you want to delete your classified?";
    
    UIAlertView *_alertMsg = [[UIAlertView alloc] initWithTitle:_msg message:nil delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    _alertMsg.tag = 1;
    [_alertMsg show];


}

#pragma mark - Create Mobile View
-(UIView *)createMobileView:(NSString *)mobileNumber parent:(UIView *)parentView previous:(UIView *)previous{
    UIView *mobileView = [[UIView alloc] initWithFrame:CGRectMake(previous.frame.origin.x + previous.frame.size.width, previous.frame.origin.y, previous.frame.size.width, previous.frame.size.height)];
    [mobileView setBackgroundColor:[UIColor clearColor]];
    [parentView addSubview:mobileView];
    
    
    UIImageView *mobileIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
    [mobileIcon setImage:[UIImage imageNamed:@"phone_icon.png"]];
    [mobileView addSubview:mobileIcon];
    
    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(mobileIcon.frame.size.width + mobileIcon.frame.origin.x, 0, mobileView.frame.size.width-mobileIcon.frame.size.width, mobileView.frame.size.height)];
    [numberLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [numberLabel setText:mobileNumber];
    [numberLabel setTextColor:[UIColor lightGrayColor]];
    [mobileView addSubview:numberLabel];
    
    UIButton *mobileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mobileButton addTarget:self
                    action:@selector(mobileButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    mobileButton.frame = CGRectMake(0, 0, mobileView.frame.size.width, mobileView.frame.size.height);
    [mobileView addSubview:mobileButton];
    
    return mobileView;
}

-(IBAction)mobileButtonAction:(id)sender{
    NSString *mobileNumber = [self getOwnerInfo:@"mobile"];
    
//    mobileNumber = @"1-800-555-1212";
    if (![mobileNumber isEqualToString:NO_DATA_MESSAGE]) {
        NSString *phoneURLString = [NSString stringWithFormat:@"tel:%@", mobileNumber];
        NSURL *phoneURL = [NSURL URLWithString:phoneURLString];
        [[UIApplication sharedApplication] openURL:phoneURL];
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:NO_DATA_MESSAGE message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        });
    }
}

#pragma mark - Create Email View
-(UIView *)createEmailView:(NSString *)emailAddress with:(UIView *)parentView with:(UILabel *)previousLabel{
    UIView *emailView = [[UIView alloc] initWithFrame:CGRectMake(previousLabel.frame.origin.x, previousLabel.frame.origin.y+ previousLabel.frame.size.height, previousLabel.frame.size.width*2/3, 14)];
    [emailView setBackgroundColor:[UIColor clearColor]];
    [parentView addSubview:emailView];
    
    UIImageView *emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
    [emailIcon setImage:[UIImage imageNamed:@"mass_icon.png"]];
    [emailView addSubview:emailIcon];
    
    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(emailIcon.frame.size.width + emailIcon.frame.origin.x, 0, emailView.frame.size.width-emailIcon.frame.size.width, emailView.frame.size.height)];
    [numberLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [numberLabel setText:emailAddress];
    [numberLabel setTextColor:[UIColor lightGrayColor]];
    [numberLabel setBackgroundColor:[UIColor clearColor]];
    [emailView addSubview:numberLabel];
    
    UIButton *emailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [emailButton addTarget:self
                    action:@selector(emailButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    emailButton.frame = CGRectMake(0, 0, emailView.frame.size.width, emailView.frame.size.height);
    [emailView addSubview:emailButton];
    
    return emailView;
}

#pragma mark - Send Mail

-(IBAction)emailButtonAction:(id)sender{
    NSString *emailAdd = [self getOwnerInfo:@"email"];

    if (![emailAdd isEqualToString:NO_DATA_MESSAGE]) {
        if ([MFMailComposeViewController canSendMail]) {
            // Show the composer
            MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
            controller.mailComposeDelegate = self;
            [controller setSubject:[@"RE:" stringByAppendingString:dataItems.title]];
            [controller setMessageBody:@"Message.." isHTML:NO];
            [controller setToRecipients:[NSArray arrayWithObjects:emailAdd,nil]];
            if (controller) [self presentViewController:controller animated:YES completion:nil];
        } else {
            // Handle the error
            dispatch_async(dispatch_get_main_queue(), ^{
                [[[UIAlertView alloc] initWithTitle:@"That device does not support send mail app" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            });
            
        }

    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:NO_DATA_MESSAGE message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        });
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {

        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"Successfull" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        });
        
    }
    else{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"Failed" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        });
        
    }

    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - Date View
-(UILabel *)createDateView:(UILabel *)previousView with:(UIView *)parentView with:(NSString *)date_time{
    // Create date label
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(previousView.frame.origin.x, previousView.frame.origin.y+ previousView.frame.size.height + 2, previousView.frame.size.width - 20, 12)];
    [dateLabel setTextColor:[UIColor sidraFlatRedColor]];
    [dateLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [dateLabel setText:[[CommonHelperClass sharedConstants] getDateNameFormat:date_time]];
    [dateLabel setBackgroundColor:[UIColor clearColor]];
    [parentView addSubview:dateLabel];
    

    [parentView setFrame:CGRectMake(parentView.frame.origin.x, parentView.frame.origin.y, parentView.frame.size.width, dateLabel.frame.origin.y + dateLabel.frame.size.height)];
    
    return dateLabel;
}

#pragma mark - Title View
-(UILabel *)createTitleView:(UIView *)parentView with:(NSString *)title{
    //bound your title with maximum
//    title = [title stringByAppendingString:@"nsbkjfbnkjsdbf kjsdfk bsadjkbfkjasbdfk asbdfkbkjsadb fkjsab dkfjbsadkjsab fdkjsbdkjasb fkjbasdkfj baskjf"];
//    if([title length]>45){
//        title=[title substringToIndex:42];
//        title = [title stringByAppendingString:@"..."];
//    }
    CommonDynamicCellModel *titleInfo = [[CommonHelperClass sharedConstants] calculateLabelMaxSize:title with:[UIFont systemFontOfSize:16.0f] with:parentView.frame.size.width-20];
    
    //create title label with a temporary frame size
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, parentView.frame.size.width-20, titleInfo.maxSize.height > 20 ? titleInfo.maxSize.height : 20)];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    [titleLabel setText:title];
    [titleLabel setTextColor:[UIColor sidraFlatDarkGrayColor]];
    [titleLabel setFont:titleInfo.maxFont];
    //[titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [parentView addSubview:titleLabel];
    
    [parentView setFrame:CGRectMake(parentView.frame.origin.x, parentView.frame.origin.y, parentView.frame.size.width, titleLabel.frame.origin.y + titleLabel.frame.size.height)];
    return titleLabel;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - ALERT Delegate Method

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // POST Delete
    
    if (alertView.tag == 1) {
        
        if (buttonIndex == 1) {
            
           [[ServerManager sharedManager] deleteItem:dataItems.itemID type:DELETE_CLASSIFIED_TYPE completion:^(BOOL success){

            if (success) {
                    isDeleteClick = YES;
                    [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[[UIAlertView alloc] initWithTitle:@"Failed to delete, Please try again later" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
                        });
            }
               
            }];
            
        }
    }
    
    
    
}

@end
