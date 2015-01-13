//
//  ForumPostDetailsViewController.m
//  Pulse
//
//  Created by xibic on 7/15/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "ForumPostDetailsViewController.h"
#import "PostTableCell.h"
#import "StaffTableViewCell.h"
#import "CommentTableCell.h"
#import <MessageUI/MessageUI.h>
#import "CommentItem.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <objc/runtime.h>
#import "ForumPostView.h"
#import "VideoPreViewController.h"


#define POST_CELL_HEIGHT 240
#define POST_TEXT_WIDTH 290
#define POST_IMAGE_HEIGHT 135

#define NUMBER_OF_COMMENT_HEIGHT 30

#define MIN_COMMENT_CELL_HEIGHT 105
#define COMMENT_TEXTWIDTH 260
#define COMMENT_IMG_HEIGHT 130

#define URL_WEBVIEW_HEIGHT 80
#define URL_WEBVIEW_WIDTH 280

#define KEYBOARD_HEIGHT 216


#define CAMERA_BTN_WIDTH 35
#define CAMERA_BTN_HEIGHT 25
#define CAMEAR_BTN_X 8
#define CAMEAR_BTN_Y 38

#define POST_BTN_WIDTH 40
#define POST_BTN_HEIGHT 40
#define POST_BTN_Y 45

#define CHARACTER_LIMIT 250

const char MyConstantKey;
static BOOL isVideoPlaying = NO;

@interface ForumPostDetailsViewController ()<UIWebViewDelegate,UITableViewDataSource, UITableViewDelegate,MFMailComposeViewControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate,ForumPostViewDelegate,XIBPhotoScrollViewDelegate,FullScreenPhotoViewerDelegate,UIGestureRecognizerDelegate> {
    
    UITableView *postDetailsTableView;
    
    NSMutableArray *postPhotoArray;
    NSString *commentIamgeUrlOfStringFormate ;// post Picture Array
    ForumItem *itemForum ;
    BOOL selfPosted;
    BOOL isMe;
    
    //--- Bottom comment view
/*
    UIView *postCommentView ;
    UITextView *commentTextView;
    UIImageView *commentImg;
    UIButton *postBtn;
    UIButton *CameraBtn;
    
    float changeTextViewHeight;  // Calculate Dynamic Height
    BOOL isImageTaken; // image Have or Not
*/
    // comment view
    
    ForumPostView *commentView;
    
    MPMoviePlayerController *moviePlayer;
    BOOL videoPlayBackFinished;
    
    FullScreenPhotoViewer *fullScreenPhotoView;
}

@end

@implementation ForumPostDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated {
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithBool:NO] forKey:@"IsDetailsPage"];
    [defaults setObject:@"" forKey:@"Hashtag"];
    [defaults synchronize];
    [super setNavigationCustomTitleView:@"Sidra Forums" with:@""];
    itemForum = self.forumItemArray; // copy forum Data Array
    
    // Get Own Post or Not
    int postCreatedBy = (int)[itemForum.createdBy integerValue];
    int myID = (int)[[UserManager sharedManager].userID  integerValue];
    
    selfPosted = (postCreatedBy == myID);
    if (selfPosted) {
        
        isMe = YES;
    }
    else {
        
        isMe = NO;
    }
    
    postPhotoArray = [[NSMutableArray alloc] init];
    
    [itemForum.photos enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        [postPhotoArray addObject:[dic objectForKey:@"photo"]];
    }];
    //Press Release Table View
    
    postDetailsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - 65 - 40)];
    [postDetailsTableView setBackgroundColor:[UIColor clearColor]];
    [postDetailsTableView setDelegate:self];
    [postDetailsTableView setDataSource:self];
    [postDetailsTableView setScrollEnabled:YES];
    postDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    postDetailsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:postDetailsTableView];
    
    //Bottom Comment View
    
    [self CommentViewBottom]; // new
    
    
   // [self createCommentPostView]; // supron
    
/*
    //----- COMMENT VIEW UI OLD -------
    
    changeTextViewHeight = 50; // initialize height
    [self bottomCommentView]; // off it for new requirements
    
    // END
*/
    
    videoPlayBackFinished = FALSE;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerStarted:) name:@"UIMoviePlayerControllerDidEnterFullscreenNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerWillExitFullscreen:) name:@"UIMoviePlayerControllerWillExitFullscreenNotification" object:nil];
    
}


-(void) CommentViewBottom{
    
    UIView *bottomCommentView = [[UIView alloc] initWithFrame:CGRectMake( -1, [[UIScreen mainScreen] bounds].size.height - 60 - 50, 322, 50)];
    bottomCommentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomCommentView];
    
    bottomCommentView.backgroundColor = [UIColor sidraFlatLightGrayColor];
    [bottomCommentView.layer setBorderColor:[[[UIColor sidraFlatDarkGrayColor] colorWithAlphaComponent:1.0] CGColor]];
    [bottomCommentView.layer setBorderWidth:kViewBorderWidth];
    bottomCommentView.clipsToBounds = YES;
    
    
    UITapGestureRecognizer *singleTapOnProfile =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(comBtnAction:)];
    [singleTapOnProfile setNumberOfTapsRequired:1];
    [bottomCommentView addGestureRecognizer:singleTapOnProfile];
    
    
    UIView *whiteBorder = [[UIView alloc] initWithFrame:CGRectMake(10, 8.0, 300, 30)];
    whiteBorder.backgroundColor = [UIColor whiteColor];
    [bottomCommentView addSubview:whiteBorder];
    [whiteBorder.layer setBorderColor:[[[UIColor sidraFlatDarkGrayColor] colorWithAlphaComponent:1.0] CGColor]];
    [whiteBorder.layer setBorderWidth:kViewBorderWidth];
    [whiteBorder.layer setCornerRadius:kViewCornerRadius];
    whiteBorder.clipsToBounds = YES;
    
    
    UIImageView *cameraBtn = [[UIImageView alloc]initWithFrame:CGRectMake( 5, 3 , 30, 23)];
    cameraBtn.image = [UIImage imageNamed:@"cameraBtn.png"];
    [whiteBorder addSubview:cameraBtn];
    
    UILabel *replyText = [[UILabel alloc]initWithFrame:CGRectMake(50, 7, 200, 15)];
    replyText.text = @"Type your reply here";
    replyText.font = [UIFont systemFontOfSize:14];
    replyText.textColor = [UIColor sidraFlatGrayColor];
    [whiteBorder addSubview:replyText];
    
}

#pragma mark - Video Link Action

-(void)videoLinkAction:(UIGestureRecognizer *)recognizer {
    
    NSInteger indexNumber =  recognizer.view.tag - 502;
    CommentItem *itemCom = (CommentItem *)[itemForum.comments objectAtIndex:indexNumber];
    NSLog(@"video link Action : %@", itemCom.commentText);

    [self playVideoOnWebView:itemCom.commentText];
}

-(void)playVideoOnWebView:(NSString*)linkAsString {
    
    NSString *onlyVideoWeblink = [self urlFromText:[NSString stringWithFormat:@"%@",linkAsString]];
    NSString *_videoForPlay = @"";

    if ([onlyVideoWeblink rangeOfString:@"youtube.com/watch?"].location !=NSNotFound) {
        _videoForPlay = onlyVideoWeblink;
    }
    
    else if ([onlyVideoWeblink rangeOfString:@"//vimeo.com/"].location !=NSNotFound) {
        
        if ([onlyVideoWeblink rangeOfString:@"/m/"].location !=NSNotFound) {
            onlyVideoWeblink = [onlyVideoWeblink stringByReplacingOccurrencesOfString:@"/m" withString:@""];
        }
        _videoForPlay = onlyVideoWeblink;
    }
    
    VideoPreViewController *showVideoOnWebView = [[VideoPreViewController alloc]initWithNibName:@"VideoPreViewController" bundle:nil];
    showVideoOnWebView.videoLink = _videoForPlay;
    [self.navigationController pushViewController:showVideoOnWebView animated:YES];

}

#pragma mark - Comment Post
// action

-(void)comBtnAction:(UIGestureRecognizer *)recognizer{
    XLog(@"Comment View tap:");
    
    [commentView removeFromSuperview];
    commentView = Nil;
    
    commentView = [[ForumPostView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) forPostView:NO withHashTag:@""];
    commentView.backgroundColor  = [UIColor clearColor];
    commentView.postID = [NSString stringWithFormat:@"%@",itemForum.itemID];;
    commentView.delegate = self;
    
    [[UIApplication sharedApplication].keyWindow addSubview:commentView];
    
}

#pragma mark - ForumPostView Delegate

-(void)sendBtnValue:(NSString *)text commentItem:(CommentItem *)item{
    XLog(@"comment : %@", item.commentText);
    XLog(@"itemID : %@", item.userID);
    [commentView removeFromSuperview];
    commentView = nil;
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:itemForum.comments];
    [tempArray addObject:item];
   // itemForum.comments = nil;
    itemForum.comments = [NSArray arrayWithArray:tempArray];
    tempArray = nil;
    [postDetailsTableView reloadData];
    
    //post notification
    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/8.0, [UIScreen mainScreen].bounds.size.height/5.0 , 160, 50);
    NSString *msg = @"Comment Posted Successfully";
    AlertPopView *alertMsg = [[AlertPopView alloc] initWithFrame:frame alertMsg:msg];
    [self.view addSubview:alertMsg];
    alertMsg = nil;
    
}

-(void) cancelComment {
    [commentView removeFromSuperview];
    commentView = nil;
}

-(void)isPostingContinue:(BOOL)isPost {
    
}


#pragma mark - supron commnets post work

-(void)createCommentPostView{
    
    XLog(@"createCommentPostView");
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, IPHONE_5 == YES ? 464 : 376, self.view.frame.size.width, 40)];
    [view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    
}



#pragma mark -
#pragma mark - WebView
-(void)webViewDidStartLoad:(UIWebView *)webView {
    XLog(@"start");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    XLog(@"finish");
    //NSURL *url = [webView.request mainDocumentURL];
    //NSString *str = [url absoluteString];
    //NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //XLog(@"%s: url=%@ str=%@ title=%@", __PRETTY_FUNCTION__, url, str, title);
    
    [self performSelector: @selector(render:) withObject: webView afterDelay: 0.01f];
}


- (void) render: (id) obj
{
    UIWebView* webView = (UIWebView*) obj;
    
    CGSize thumbsize = CGSizeMake(96,72);
    UIGraphicsBeginImageContext(thumbsize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat scalingFactor = thumbsize.width/webView.frame.size.width;
    CGContextScaleCTM(context, scalingFactor,scalingFactor);
    [webView.layer renderInContext: context];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 96, 72)];
    [self.view addSubview:imageView];
    imageView.image = resultImage;
}

/******END*****/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return itemForum.comments.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0) {
        
        static NSString *cellIdentifier = @"PostDetailsCell";
        PostTableCell *cell = (PostTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        // If there is no cell to reuse, create a new one
        if(cell == nil)
        {
            
            cell = [[PostTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            [cell.emailBtn addTarget:self
                              action:@selector(postEmailBtnAction:) forControlEvents:UIControlEventTouchUpInside];  // Email Btn Action
            [cell.phoneBtn addTarget:self
                              action:@selector(postPhoneBtnAction:) forControlEvents:UIControlEventTouchUpInside];  // phone Btn Action
            [cell.deleteBtn addTarget:self
                               action:@selector(postDeleteBtnAction:) forControlEvents:UIControlEventTouchUpInside]; // delete Btn Action
            
        }
        
        cell.backgroundColor = [UIColor clearColor];
        
        cell.postText.text = [NSString stringWithFormat:@"%@",itemForum.text];
        [cell.postText setDetectionBlock:^(STTweetHotWord hotWord, NSString *string, NSString *protocol, NSRange range) {
            [self anyWebLinkAction:string from:@"post"]; // open weblink in WebView
        }];
        
        cell.postedOnDate.text = [[SettingsManager sharedManager] showPostedByFromDate:itemForum.createdDate];
        cell.postedByName.text = isMe ? @"You":itemForum.authorName;
        cell.postedByName.textColor = isMe ? [UIColor sidraFlatGreenColor]:[UIColor sidraFlatTurquoiseColor];
        
        
        NSString *zzzEmail = [NSString stringWithFormat:@"%@",itemForum.authorEmail];
        zzzEmail = [zzzEmail stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *zzzMobile = [NSString stringWithFormat:@"%@",itemForum.authorPhone];
        zzzMobile = [zzzMobile stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        
        if ([zzzEmail isEqualToString:@""]) {
            [cell.emailBtn setTitle:@"unavailable" forState:UIControlStateNormal];
            cell.emailBtn.enabled = NO;
        }else{
            [cell.emailBtn setTitle:itemForum.authorEmail forState:UIControlStateNormal];
        }
        
        if ([zzzMobile isEqualToString:@""]) {
            [cell.phoneBtn setTitle:@"unavailable" forState:UIControlStateNormal];
            cell.phoneBtn.enabled = NO;
        }else{
            [cell.phoneBtn setTitle:itemForum.authorPhone forState:UIControlStateNormal];
        }
        
        cell.deleteBtn.hidden = isMe ? NO : YES;
        
        // Check Post Text Have Or Not
        
        float postTextHeight = 0.0f;
        float postText_Y = 0.0f;
        
        if ([[NSString stringWithFormat:@"%@",itemForum.text] isEqualToString:@""]) {
            
            postTextHeight = 0.0f;
            postText_Y = 5.0f;
        }
        else {
            postTextHeight = [self textHeight:cell.postText.text textWidth:POST_TEXT_WIDTH size:12.0] + 15;
            postText_Y = 10.f;
        }
        
        // if Post Images Have
        
        float xPosition = 15;
        
        if (itemForum.photos.count!=0) {
            
            cell.postText.frame = CGRectMake(xPosition, postText_Y, POST_TEXT_WIDTH, postTextHeight);
            [cell addPhotoScrollerWithPhotos:postPhotoArray frameSize:CGRectMake(5, cell.postText.frame.size.height + cell.postText.frame.origin.y + 20, 310, POST_IMAGE_HEIGHT)]; // get Post Images
            cell.postedImgList.delegate = self;
            
            cell.postedOn.frame = CGRectMake(xPosition, cell.postText.frame.size.height + 45 + POST_IMAGE_HEIGHT, 55, 10);
            cell.deleteBtn.frame = CGRectMake(xPosition + 270, cell.postedOn.frame.origin.y - 2, 20, 20);
            cell.postedOnDate.frame = CGRectMake(xPosition + 60, cell.postedOn.frame.origin.y, 200, 10);
            cell.postedBy.frame = CGRectMake(xPosition, cell.postedOn.frame.origin.y + 20, 55, 10);
            cell.postedByName.frame = CGRectMake(xPosition + 60, cell.postedOn.frame.origin.y + 20, 150, 10);
            cell.emailImg.frame = CGRectMake(xPosition, cell.postedOn.frame.origin.y + 40, 10, 10);
            cell.emailBtn.frame = CGRectMake(xPosition + 15, cell.postedOn.frame.origin.y + 40, 150, 10);
            cell.phoneImg.frame = CGRectMake(xPosition + 170, cell.postedOn.frame.origin.y + 40, 10, 10);
            cell.phoneBtn.frame = CGRectMake(xPosition + 185, cell.postedOn.frame.origin.y + 40, 115, 10);
            cell.userPostWhiteBgView.frame = CGRectMake(5, 5, 310, POST_CELL_HEIGHT + postTextHeight );
            
        }
        
        // if Post have No images
        
        else  {
            
            cell.postText.frame = CGRectMake(xPosition, postText_Y, POST_TEXT_WIDTH, postTextHeight );
            cell.postedOn.frame = CGRectMake(xPosition, cell.postText.frame.size.height + 30, 55, 10);
            cell.deleteBtn.frame = CGRectMake(xPosition + 270, cell.postedOn.frame.origin.y - 2, 20, 20);
            cell.postedOnDate.frame = CGRectMake(xPosition + 60 , cell.postedOn.frame.origin.y, 200, 10);
            cell.postedBy.frame = CGRectMake(xPosition, cell.postedOn.frame.origin.y + 20, 55, 10);
            cell.postedByName.frame = CGRectMake(xPosition + 60 , cell.postedOn.frame.origin.y + 20, 150, 10);
            cell.emailImg.frame = CGRectMake(xPosition, cell.postedOn.frame.origin.y + 40, 10, 10);
            cell.emailBtn.frame = CGRectMake(xPosition + 15 , cell.postedOn.frame.origin.y + 40, 150, 10);
            cell.phoneImg.frame = CGRectMake(xPosition + 170, cell.postedOn.frame.origin.y + 40, 10, 10);
            cell.phoneBtn.frame = CGRectMake(xPosition + 185, cell.postedOn.frame.origin.y + 40, 115, 10);
            cell.userPostWhiteBgView.frame = CGRectMake(5, 5, 310, POST_CELL_HEIGHT + postTextHeight - POST_IMAGE_HEIGHT - 15);
        }
        
        return cell;
        
    }
    
    //+++++++++++++++++++++++++  Only total Number OF Comment Text Show +++++++++++++++++++++++ //
    
    if (indexPath.row==1) {
        
        static NSString *cellIdentifier = @"CommentCell";
        StaffTableViewCell *cell = (StaffTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        // If there is no cell to reuse, create a new one
        if(cell == nil)
        {
            cell = [[StaffTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.nameLabel.frame = CGRectMake(30, 5, 200, 20);
            cell.grayArrow.frame = CGRectMake(10, 7, 15, 15);
        }
        
        
        int totalNumOfcomment = (int)itemForum.comments.count;
        cell.nameLabel.text = [NSString stringWithFormat:@"Comments  %d",totalNumOfcomment];
        cell.nameLabel.font = [UIFont boldSystemFontOfSize:11];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.grayArrow.image = [UIImage imageNamed:@"comments_icon"];
        
        return cell;
        
    }
    
    //+++++++++++++++++++++++++  Show All Comment ++++++++++++++++++++++++++++++ //
    
    else{

        static NSString *cellIdentifier;
        cellIdentifier= [NSString stringWithFormat:@"AllCommentCell_%ld",(long)indexPath.row];
        
        CommentTableCell *cell = (CommentTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        CommentItem *itemCom = (CommentItem *)[itemForum.comments objectAtIndex:indexPath.row - 2];
       // cell = nil;
        // If there is no cell to reuse, create a new one
        if(cell == nil) {
            
            cell = [[CommentTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            // ASSIGN Tag
            cell.commentDeleteBtn.tag = indexPath.row - 2;
            cell.commentDeleteBtn.frame = CGRectMake(280, 5, 25, 25); // fixed frame
            cell.userName.tag = indexPath.row + 100;
            cell.postTime.tag = indexPath.row + 200;
            cell.postDetails.tag = indexPath.row + 300;
            cell.userPostedImages.tag = indexPath.row + 400; 
            // video section
            cell.urlView.tag = indexPath.row + 500;
            cell.imgThumbPreView.tag = indexPath.row + 600;
            cell.thumbTitle.tag = indexPath.row + 700;

            // Comment Delete ACTION
            [cell.commentDeleteBtn addTarget:self action:@selector(commentDelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        // CELL BACKGROUND COLOR
        cell.backgroundColor = [UIColor clearColor];
        
        // CELL VIEW ASSIGN WITH TAG
        UILabel *_userNameLabel = (UILabel*)[cell viewWithTag:indexPath.row + 100];
        _userNameLabel.frame = CGRectMake(20, 7, 200, 20);
        
        UILabel *_postTimeLabel = (UILabel*)[cell viewWithTag:indexPath.row + 200];
        _postTimeLabel.frame = CGRectMake(20, 25, 200, 20);
        _postTimeLabel.text = [[SettingsManager sharedManager] showPostedByFromDate:itemCom.created_at];
        
        STTweetLabel *_postDetailsLabel = (STTweetLabel*)[cell viewWithTag:indexPath.row + 300];
        
       
        AsyncImageView *_userPostedPhotos = (AsyncImageView*)[cell viewWithTag:indexPath.row + 400];

        _userPostedPhotos.showActivityIndicator = YES;
        _userPostedPhotos.layer.cornerRadius = 2.5;
        _userPostedPhotos.contentMode = UIViewContentModeScaleAspectFit;
        if (![itemCom.photo isEqualToString:@""]){
        _userPostedPhotos.imageURL = [NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@",
                                                                   SERVER_BASE_IMAGE_URL,itemCom.photo] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        commentIamgeUrlOfStringFormate = itemCom.photo;
        }
        
        
        
        // VIDEO PREVIEW (Thumb Img, Title)
        UIView *_holdUrlView = (UIView*)[cell viewWithTag:indexPath.row+500];
        AsyncImageView *_holdVideoThumbImg = (AsyncImageView*)[cell viewWithTag:indexPath.row+600];
        UILabel* _holdThumbTitle = (UILabel*)[cell viewWithTag:indexPath.row+700];
    
        // WHITE BG UPDATED FROM layOutSubviews
        cell.whiteBgView.frame = CGRectMake(10, 0, 300, 100);
        
        
        
        //*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*
        
        
       _userPostedPhotos.userInteractionEnabled = YES;
        UITapGestureRecognizer *pgr = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(handlePinch:)];
        [pgr setNumberOfTapsRequired:1];
        pgr.delegate = self;
        
        [_userPostedPhotos addGestureRecognizer:pgr];
        
        
        
        //*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

        
        
        
        
        
        // OWN COMMENT YES/NOT
        int postCreatedBy = (int)[itemCom.userID integerValue];
        int myID = (int)[[UserManager sharedManager].userID  integerValue];
        selfPosted = (postCreatedBy == myID);
        cell.commentDeleteBtn.hidden = selfPosted ? NO: YES;
        _userNameLabel.text = selfPosted ? @"You" : itemCom.commentatorName;
        _userNameLabel.textColor = selfPosted ? [UIColor sidraFlatGreenColor]:[UIColor blackColor];
        
     
        // COMMENT DETAILS
        _postDetailsLabel.text = [NSString stringWithFormat:@"%@",itemCom.commentText];
        [_postDetailsLabel setDetectionBlock:^(STTweetHotWord hotWord, NSString *string, NSString *protocol, NSRange range) {
            [self anyWebLinkAction:string from:@"comment"]; // open weblink in WebView
        }];
        
        float comTextHeight = 0.f;  // initialize Post Text Height
        
        if (![[NSString stringWithFormat:@"%@",itemCom.commentText] isEqualToString:@""]) {
            comTextHeight = [self textHeight:[NSString stringWithFormat:@"%@",itemCom.commentText] textWidth:COMMENT_TEXTWIDTH size:12.0] + 15;
        }
        
        _postDetailsLabel.numberOfLines = 0;
        _postDetailsLabel.frame = CGRectMake(20, 45, COMMENT_TEXTWIDTH, comTextHeight);
        
        
        // IF HTTPS/HTTP VIDEO LINK, YES/NOT
        if (([[NSString stringWithFormat:@"%@",itemCom.commentText] rangeOfString:@"youtube.com/watch?"].location != NSNotFound)||([[NSString stringWithFormat:@"%@",itemCom.commentText] rangeOfString:@"//vimeo.com/"].location != NSNotFound)) {
            
            _holdUrlView.hidden =  NO;
            _holdUrlView.frame =   CGRectMake(20, _postDetailsLabel.frame.origin.y + _postDetailsLabel.frame.size.height + 10, URL_WEBVIEW_WIDTH, URL_WEBVIEW_HEIGHT);
            
            // Http:// Action
            UITapGestureRecognizer *singleTapOnvideoLink =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoLinkAction:)];
            [singleTapOnvideoLink setNumberOfTapsRequired:1];
            [cell.urlView addGestureRecognizer:singleTapOnvideoLink];
 
            //VIDEO PREVIEW Thumb IMG
            _holdVideoThumbImg.hidden = NO;
            _holdVideoThumbImg.backgroundColor = [UIColor sidraFlatGrayColor];
            _holdVideoThumbImg.frame = CGRectMake(_holdUrlView.frame.origin.x + 5, _holdUrlView.frame.origin.y + 5, 90, 70);
            _holdVideoThumbImg.showActivityIndicator = YES;
            _holdVideoThumbImg.layer.cornerRadius = 2.5;
            _holdVideoThumbImg.contentMode = UIViewContentModeScaleAspectFit;
            
            // TEXT Section
            _holdThumbTitle.hidden = NO;
            _holdThumbTitle.frame = CGRectMake(_holdVideoThumbImg.frame.origin.x + _holdVideoThumbImg.frame.size.width + 5, _holdUrlView.frame.origin.y + 5, 150, 70);
        
            
            //+++++++ FETCH Data From Online Link "Youtube & Vimeo" +++++++
            
            NSString *onlyWeblink = [self urlFromText:[NSString stringWithFormat:@"%@",itemCom.commentText]];
            NSString *_urlAsString = @"";
       
            if ([onlyWeblink rangeOfString:@"youtube.com/watch?"].location !=NSNotFound) {
                _urlAsString = [NSString stringWithFormat:@"http://www.youtube.com/oembed?url=%@&format=json",onlyWeblink];
                
            }
            
            else if ([onlyWeblink rangeOfString:@"//vimeo.com/"].location !=NSNotFound) {
                
                if ([onlyWeblink rangeOfString:@"/m/"].location !=NSNotFound) {
                    onlyWeblink = [onlyWeblink stringByReplacingOccurrencesOfString:@"/m" withString:@""];
                }
                _urlAsString = [NSString stringWithFormat:@"https://vimeo.com/api/oembed.json?url=%@",onlyWeblink];
                
            }
            
            NSURL *_url = [[NSURL alloc] initWithString:_urlAsString];
            
            // JSON parsing to Show Title
            [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:_url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                
                if (error) {
                   // NSLog(@"Error to fetch data");
                    __block NSString *errorVideoTitle = @"Invalid Video URL";
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _holdThumbTitle.text = errorVideoTitle;
                    });
                } else {
        
                    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                 //   NSLog(@"Json data: %@",jsonData);
                    __block NSString *videoTitle = [jsonData objectForKey:@"title"];
                    __block NSString *videoThumbImg = [jsonData objectForKey:@"thumbnail_url"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _holdThumbTitle.text = videoTitle;
                        _holdVideoThumbImg.imageURL = [NSURL URLWithString:[[NSString stringWithFormat:@"%@",
                                                                            videoThumbImg] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    });
                //-----
                }
            }];
            
            //-- IMAGE AFTER VIDEO LINK HAVE OR NOT
            if (![itemCom.photo isEqualToString:@""]){
                _userPostedPhotos.hidden = NO;
                _userPostedPhotos.frame =  CGRectMake(10, _holdUrlView.frame.origin.y + _holdUrlView.frame.size.height + 10, 300, COMMENT_IMG_HEIGHT - 10);
            }
            else {
                _userPostedPhotos.hidden = YES;
                _userPostedPhotos.frame =  CGRectMake(10, _holdUrlView.frame.origin.y + _holdUrlView.frame.size.height + 10, 0, 0);
            }
            
        }
        
        else {
            
             //IMAGE AFTER COMMENT HAVE OR NOT
            if (![itemCom.photo isEqualToString:@""]){
                _userPostedPhotos.hidden =  NO;
                _userPostedPhotos.frame =  CGRectMake(10, _postDetailsLabel.frame.origin.y + _postDetailsLabel.frame.size.height + 10, 300, COMMENT_IMG_HEIGHT - 10);
            }
            else {
                _userPostedPhotos.hidden =  YES;
                _userPostedPhotos.frame =  CGRectMake(10, _postDetailsLabel.frame.origin.y + _postDetailsLabel.frame.size.height + 10, 0, 0);
            }
        }
        
        return cell;
        
    }
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row!=0 && indexPath.row!=1) {
        [postDetailsTableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
        
        //  [self addOrRemoveSelectedIndexPath:indexPath];
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//--- POST height calculation -------
    
    if (indexPath.row == 0) {
        
        float postTextHeight = 0.f;
        
        NSString *str = [NSString stringWithFormat:@"%@",itemForum.text];
        // Check Text have or Not
        if ([str isEqualToString:@""]) {
            
           postTextHeight = 0.0f;
        }
        else {
            postTextHeight = [self textHeight:str textWidth:POST_TEXT_WIDTH size:12.0] + 15;
        }
        
        // Check Image have or not
        if (itemForum.photos.count == 0) {
            
            return  POST_CELL_HEIGHT + postTextHeight - POST_IMAGE_HEIGHT - 10;
        }
        else
            return  POST_CELL_HEIGHT + postTextHeight + 5;
    }
    
//--- JUST Text Height calculation -------
    
    else if (indexPath.row ==1) {
        
        return NUMBER_OF_COMMENT_HEIGHT;
    }
    
//--- COMMENT Height calculation -------
    else
        
    {
        
        CommentItem *itemCom = (CommentItem *)[itemForum.comments objectAtIndex:indexPath.row - 2];
        
        float imageFixedSize = 0.f;
        
        if (![itemCom.photo isEqualToString:@""]) {
            
            imageFixedSize = COMMENT_IMG_HEIGHT;
        }
        
        
        float commentTextHeight = 0.f;
        
        if (![[NSString stringWithFormat:@"%@",itemCom.commentText] isEqualToString:@""]) {
            commentTextHeight = [self textHeight:[NSString stringWithFormat:@"%@",itemCom.commentText] textWidth:COMMENT_TEXTWIDTH size:12.0f] + 15;
        }
        
        float commentUrlView = 0.f;
        
        if (([[NSString stringWithFormat:@"%@",itemCom.commentText] rangeOfString:@"youtube.com/watch?"].location != NSNotFound)||([[NSString stringWithFormat:@"%@",itemCom.commentText] rangeOfString:@"//vimeo.com/"].location != NSNotFound)) {
            
            commentUrlView = URL_WEBVIEW_HEIGHT + 10;
        }
        
    
        CGFloat maxHeight = commentTextHeight + imageFixedSize + commentUrlView + 65;

        
        return maxHeight;
        
        
    }
    
}

-(float)textHeight :(NSString *)text textWidth:(float)width size:(float)fontSize{
    
    
    CGSize constrainSize = CGSizeMake(width, MAXFLOAT);
    CGSize labelSize     = [text sizeWithFont:[UIFont systemFontOfSize:fontSize]
                            constrainedToSize:constrainSize
                                lineBreakMode:NSLineBreakByCharWrapping];
    
    return labelSize.height;
    
}

/*  off more option
 
- (void)addOrRemoveSelectedIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (!self.selectedIndexPaths) {
        self.selectedIndexPaths = [[NSMutableArray alloc] init];
    }
    
    BOOL containsIndexPath = [self.selectedIndexPaths containsObject:indexPath];
    
    if (containsIndexPath) {
        [self.selectedIndexPaths removeObject:indexPath];
    }else{
        [self.selectedIndexPaths addObject:indexPath];
    }
    
    [postDetailsTableView reloadRowsAtIndexPaths:@[indexPath]
                                withRowAnimation:UITableViewRowAnimationFade];
    
}

*/

#pragma mark- CUSTOM METHOD 

-(NSString*)urlFromText:(NSString*)text{
    
    NSString *str = text;
    int checkHttpFirstTime = 0;
    NSArray *arrString = [str componentsSeparatedByString:@" "];
    
    for(int i=0; i<arrString.count;i++){
        
        if (checkHttpFirstTime == 0) {
            checkHttpFirstTime = checkHttpFirstTime + 1;
             if(([[arrString objectAtIndex:i] rangeOfString:@"https://"].location != NSNotFound)|| ([[arrString objectAtIndex:i] rangeOfString:@"http://"].location != NSNotFound))
               str = [arrString objectAtIndex:i];
        }
        
    }
    
    return str;
    
}

-(NSString*)youtubeHTML:(NSString*)weblink{
    
    NSString *urlString = weblink;
    urlString = [urlString stringByReplacingOccurrencesOfString:@"//m." withString:@"//www."];
    NSString* videoId = nil;
    NSURL *url = [NSURL URLWithString:urlString];
    NSArray *queryComponents = [url.query componentsSeparatedByString:@"&"];
    for (NSString* pair in queryComponents) {
        NSArray* pairComponents = [pair componentsSeparatedByString:@"="];
        if ([pairComponents[0] isEqualToString:@"v"]) {
            videoId = pairComponents[1];
            break;
        }
    }
    
    //XLog(@"Embed video id: %@", videoId);
    
    NSString *htmlString = @"<html><head>\
    <meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 99\"/></head>\
    <body style=\"background:#000;margin-top:0%;margin-left:0%; background-color: transparent;\">\
    <iframe id=\"ytplayer\" type=\"text/html\" width=\"98\" height=\"98\"\
    src=\"http://www.youtube.com/embed/%@?autoplay=1\"\
    frameborder=\"0\"/>\
    </body></html>";
    
    htmlString = [NSString stringWithFormat:htmlString, videoId, videoId];
    
    return htmlString;
    
}

-(void)anyWebLinkAction:(NSString*)link from:(NSString*)str{
    
    //XLog(@"Tap: %@",link);
    
    if (([link rangeOfString:@"https://"].location != NSNotFound)||
        ([link rangeOfString:@"http://"].location != NSNotFound)||
        ([link rangeOfString:@"www."].location != NSNotFound)){
            VideoPreViewController *showVideoOnWebView = [[VideoPreViewController alloc]initWithNibName:@"VideoPreViewController" bundle:nil];
            showVideoOnWebView.videoLink = link;
            [self.navigationController pushViewController:showVideoOnWebView animated:YES];
    }
    
    else /*{
        
        if ([str isEqualToString:@"post"]) {
            NSString *selectedHashTag = [link stringByReplacingOccurrencesOfString:@"#" withString:@""];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:[NSNumber numberWithBool:YES] forKey:@"IsDetailsPage"];
            [defaults setObject:selectedHashTag forKey:@"Hashtag"];
            [defaults synchronize];
            
            [self.navigationController popViewControllerAnimated:YES];
        }

    }*/{
            NSString *regEX = @"[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\\.[a-zA-Z]{2,4}";
            NSMutableString *tmpText = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@",link]];
            
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
                        [self sendMail:link];
                        
                    });
                }
            }];
        }
}


#pragma mark -  Custom Button Action

- (void)postEmailBtnAction:(UIButton *)sender{
    
    //XLog(@"email Button Pressed");
    
    [self sendMail:itemForum.authorEmail];
}


- (void)postPhoneBtnAction:(UIButton *)sender{
    
   // XLog(@"post Phone Btn Action Pressed");
    
    [self phoneCall:itemForum.authorPhone];
}


- (void)postDeleteBtnAction:(UIButton *)sender{
    
    NSString *_msg = @"Are you sure you want to delete your forum post?";
    
    UIAlertView *_alertMsg = [[UIAlertView alloc] initWithTitle:nil message:_msg delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    _alertMsg.tag = 1;
    [_alertMsg show];
    
}

- (void)commentDelBtnAction :(UIButton*)sender {
    
    NSString *_msg = @"Are you sure you want to delete this comment?";
    
    UIAlertView *_alertMsg = [[UIAlertView alloc] initWithTitle:nil message:_msg delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    _alertMsg.tag = 2;
    objc_setAssociatedObject(_alertMsg, &MyConstantKey, sender, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [_alertMsg show];
    
}



//phone call
-(void)phoneCall:(NSString*)phNo{
    
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView  *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}

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


#pragma mark - Alert Delegate Method

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    // POST delete 
    
    if (alertView.tag == 1) {
        
        if (buttonIndex == 1) {
            
            //*DELETE API*//
            [[ServerManager sharedManager] deleteItem:itemForum.itemID type:@"7" completion:^(BOOL success) {
                if (success) {
                    //alert
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
            //*DELETE API*//
        }
    }
    
    
    // COMMENT delete
    
    if (alertView.tag == 2) {
        
        if (buttonIndex == 1) {
            
            
            UIButton  *senderbtn = objc_getAssociatedObject(alertView, &MyConstantKey);
            
            XLog(@"associated string: %ld", (long)senderbtn.tag);
                CommentItem *commentItem = (CommentItem *)[itemForum.comments objectAtIndex:senderbtn.tag];
                //*DELETE COMMENT API*//
                [[ServerManager sharedManager] deleteItem:commentItem.itemID type:@"17" completion:^(BOOL success) {
                    if (success) {
                        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:itemForum.comments];
                        [tempArray removeObjectAtIndex:senderbtn.tag];
                        itemForum.comments = nil;
                        itemForum.comments = [NSArray arrayWithArray:tempArray];
                        tempArray = nil;
                        [postDetailsTableView reloadData];
                    }
                }];
                //*DELETE COMMENT API*//

        }
    }
    
}

#pragma mark - Video thumbnail Image

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}


#pragma mark - OFF IT FOR NEW Design

//-*******************************************************************************
/*
-(void)bottomCommentView {
    
    
    postCommentView = [[UIView alloc] initWithFrame:CGRectMake( -1, [[UIScreen mainScreen] bounds].size.height - 60 - changeTextViewHeight, 322, changeTextViewHeight)];
    postCommentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:postCommentView];
    
    postCommentView.backgroundColor = [UIColor sidraFlatLightGrayColor];
    [postCommentView.layer setBorderColor:[[[UIColor sidraFlatDarkGrayColor] colorWithAlphaComponent:1.0] CGColor]];
    [postCommentView.layer setBorderWidth:kViewBorderWidth];
    postCommentView.clipsToBounds = YES;
    
    
    CameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CameraBtn.frame = CGRectMake(CAMEAR_BTN_X, changeTextViewHeight - CAMEAR_BTN_Y , CAMERA_BTN_WIDTH, CAMERA_BTN_HEIGHT);
    UIImage *buttonImg = [UIImage imageNamed:@"cameraBtn"];
    [CameraBtn setImage:buttonImg forState:UIControlStateNormal];
    [CameraBtn addTarget:self action:@selector(cameraBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [postCommentView addSubview:CameraBtn];
    
    
    commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(50, 10, 220, 30)];
    [commentTextView.layer setBorderColor:[[[UIColor sidraFlatDarkGrayColor] colorWithAlphaComponent:1.0] CGColor]];
    [commentTextView.layer setBorderWidth:kViewBorderWidth];
    [commentTextView.layer setCornerRadius:kViewCornerRadius];
    commentTextView.clipsToBounds = YES;
    
    commentTextView.delegate = self;
    commentTextView.text = @"Write a comment...";
    commentTextView.autocapitalizationType = FALSE;
    commentTextView.autocorrectionType = FALSE;
    commentTextView.textColor = [UIColor sidraFlatGrayColor]; //optional
    [postCommentView addSubview:commentTextView];
    
    
    postBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    postBtn.frame = CGRectMake(commentTextView.frame.origin.x + commentTextView.frame.size.width + 5, changeTextViewHeight - POST_BTN_Y, POST_BTN_WIDTH, POST_BTN_WIDTH);
    [postBtn setTitle:@"Post" forState:UIControlStateNormal];
    postBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [postBtn addTarget:self action:@selector(sendBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [postCommentView addSubview:postBtn];
    postBtn.enabled = NO;
    
    
    // Demo cancel Button
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(265, 0, 60, 15);
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [postCommentView addSubview:cancelBtn];
    
    
    commentImg = [[UIImageView alloc] init];
    commentImg.image = nil;
    [postCommentView addSubview:commentImg];
    
}

-(void)scrollToBottomTableView {
    
    CGSize r = postDetailsTableView.contentSize;
    [postDetailsTableView scrollRectToVisible:CGRectMake(0, r.height-10, r.width, 10) animated:NO];
}

-(void)cancelBtnAction:(UIButton *)sender {
    
    XLog(@"cancel button pressed textview %hhd ", commentTextView.isFirstResponder);
    
    
    changeTextViewHeight = changeTextViewHeight - 40;
    commentImg.frame = CGRectMake(0, 0, 0, 0);
    commentImg.image = nil;
    isImageTaken = NO;
    
    
    if (commentTextView.isFirstResponder==YES) {
        postCommentView.frame = CGRectMake(-1, [[UIScreen mainScreen] bounds].size.height - 60 - KEYBOARD_HEIGHT - changeTextViewHeight , 322, changeTextViewHeight);
        postDetailsTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - 60 - KEYBOARD_HEIGHT - changeTextViewHeight);
    }
    else {
        postCommentView.frame = CGRectMake(-1, [[UIScreen mainScreen] bounds].size.height - 60 - changeTextViewHeight , 322, changeTextViewHeight);
        postDetailsTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - 60 - changeTextViewHeight);
    }
    
    CGRect frame = commentTextView.frame;
    frame.size.height = [commentTextView contentSize].height;
    commentTextView.frame = CGRectMake(50, 10 , 220, frame.size.height);
    
    CameraBtn.frame = CGRectMake(CAMEAR_BTN_X, changeTextViewHeight - CAMEAR_BTN_Y , CAMERA_BTN_WIDTH, CAMERA_BTN_HEIGHT);
    postBtn.frame = CGRectMake(commentTextView.frame.origin.x + commentTextView.frame.size.width + 5, changeTextViewHeight - POST_BTN_Y, POST_BTN_WIDTH, POST_BTN_WIDTH);
    
    [self scrollToBottomTableView];
    
    
    
}

-(void)sendBtnAction:(UIButton *) sender {
    
    XLog(@"Post Action");
    
    // +++++  FOR UI DESIGN ++++++++++++
    commentTextView.text = @"Write a comment...";
    commentTextView.textColor = [UIColor sidraFlatGrayColor]; //optional
    [commentTextView resignFirstResponder];
    
    //Reset All
    changeTextViewHeight = 50;
    postCommentView.frame = CGRectMake(-1, [[UIScreen mainScreen] bounds].size.height - 60 - changeTextViewHeight , 322, changeTextViewHeight);
    
    CameraBtn.frame = CGRectMake(CAMEAR_BTN_X, changeTextViewHeight - CAMEAR_BTN_Y , CAMERA_BTN_WIDTH, CAMERA_BTN_HEIGHT);
    commentTextView.frame = CGRectMake(50, 10, 220, 30);
    postBtn.frame = CGRectMake(commentTextView.frame.origin.x + commentTextView.frame.size.width + 5, changeTextViewHeight - POST_BTN_Y, POST_BTN_WIDTH, POST_BTN_WIDTH);
    commentImg.frame = CGRectMake(0, 0, 0, 0);
    
    // Table View
    postDetailsTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - 60 - changeTextViewHeight);
    
    // IMG
    commentImg.image = nil;
    isImageTaken = NO;
    
    //Post Button
    postBtn.enabled = NO;
    
    //----------------------------------
    
}

-(void)cameraBtnAction: (UIButton *)sender {
    
    XLog(@"btn Action Done");
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Take Picture"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    [actionSheet addButtonWithTitle:@"Choose Camera"];
    [actionSheet addButtonWithTitle:@"Choose Photo Album"];
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    
    [actionSheet showInView:self.view];
    
}


#pragma mark - Action Sheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    switch (buttonIndex) {
        case 0: // Camera
            
            [self useCamera];
            break;
            
        case 1: // Photo Album
            
            [self usePhotoAlbum];
            break;
            
        default:
            break;
    }
}


#pragma mark -
#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        
        commentImg.image = image; // set Image
        
        if (isImageTaken==NO) {
            isImageTaken = YES;
            changeTextViewHeight = changeTextViewHeight + 40;  // If No IMG Then Taken
        }
        else {
            changeTextViewHeight = changeTextViewHeight + 0;  // Replaceing IMG Not Frame
        }
        
        commentImg.frame = CGRectMake(50, 5, 40, 40);  // common IMG Frame
        
        postCommentView.frame = CGRectMake(-1, [[UIScreen mainScreen] bounds].size.height - 60 - changeTextViewHeight , 322, changeTextViewHeight);
        CGRect frame = commentTextView.frame;
        frame.size.height = [commentTextView contentSize].height;
        commentTextView.frame = CGRectMake(50, 50 , 220, frame.size.height);
        
        CameraBtn.frame = CGRectMake(CAMEAR_BTN_X, changeTextViewHeight - CAMEAR_BTN_Y , CAMERA_BTN_WIDTH, CAMERA_BTN_HEIGHT);
        postBtn.frame = CGRectMake(commentTextView.frame.origin.x + commentTextView.frame.size.width + 5, changeTextViewHeight - POST_BTN_Y, POST_BTN_WIDTH, POST_BTN_WIDTH);
        
        postDetailsTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - 60  - changeTextViewHeight);
        [self scrollToBottomTableView];
        
        
    }
    
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)usePhotoAlbum {
    
    XLog(@"Use Photo Album");
    
    
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        
    }
    
}

-(void)useCamera {
    
    
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        
    }
    
}



#pragma mark -
#pragma mark UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    
    if ([textView.text isEqualToString:@"Write a comment..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
    
    
    postCommentView.frame = CGRectMake(-1, [[UIScreen mainScreen] bounds].size.height - 60 - KEYBOARD_HEIGHT - changeTextViewHeight , 322, changeTextViewHeight);
    postDetailsTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - 60 - KEYBOARD_HEIGHT - changeTextViewHeight);
    CameraBtn.frame = CGRectMake(CAMEAR_BTN_X, changeTextViewHeight - CAMEAR_BTN_Y, CAMERA_BTN_WIDTH, CAMERA_BTN_HEIGHT);
    postBtn.frame = CGRectMake(commentTextView.frame.origin.x + commentTextView.frame.size.width + 5, changeTextViewHeight - POST_BTN_Y, POST_BTN_WIDTH, POST_BTN_HEIGHT);
    [self scrollToBottomTableView];
    
    // never called...
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Write a comment...";
        textView.textColor = [UIColor sidraFlatGrayColor]; //optional
    }
    
    [textView resignFirstResponder];
    
    postCommentView.frame = CGRectMake(-1, [[UIScreen mainScreen] bounds].size.height - 60 - changeTextViewHeight , 322, changeTextViewHeight);
    postDetailsTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - 60 - changeTextViewHeight);
    CameraBtn.frame = CGRectMake(CAMEAR_BTN_X, changeTextViewHeight - CAMEAR_BTN_Y, CAMERA_BTN_WIDTH, CAMERA_BTN_HEIGHT);
    postBtn.frame = CGRectMake(commentTextView.frame.origin.x + commentTextView.frame.size.width + 5, changeTextViewHeight - POST_BTN_Y, POST_BTN_WIDTH, POST_BTN_HEIGHT);
    
    
}

- (BOOL) textView: (UITextView*) textView
shouldChangeTextInRange: (NSRange) range
  replacementText: (NSString*) text
{
    
    NSUInteger newLength = (textView.text.length - range.length) + text.length;
    
    //    XLog(@"text view Total character : %d", newLength);
    
    if(newLength >= CHARACTER_LIMIT) {
        
        [textView resignFirstResponder];
        return NO;
    }
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    
    
    if ([textView.text isEqualToString:@"Write a comment..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
        postBtn.enabled = NO;
    }
    
    if (newLength!=0) {
        postBtn.enabled = YES;
    }
    else {
        postBtn.enabled = NO;
    }
    
    //--------- Update ALL Frame ----------------
    CGRect frame = textView.frame;
    frame.size.height = [textView contentSize].height;
    textView.frame = frame;
    
    
    postCommentView.frame = CGRectMake(-1, [[UIScreen mainScreen] bounds].size.height - 60 - KEYBOARD_HEIGHT - changeTextViewHeight , 322, changeTextViewHeight);
    postDetailsTableView.frame = CGRectMake(0, 0, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - 60 - KEYBOARD_HEIGHT - changeTextViewHeight);
    CameraBtn.frame = CGRectMake(CAMEAR_BTN_X, changeTextViewHeight - CAMEAR_BTN_Y , CAMERA_BTN_WIDTH, CAMERA_BTN_HEIGHT);
    postBtn.frame = CGRectMake(commentTextView.frame.origin.x + commentTextView.frame.size.width + 5, changeTextViewHeight - POST_BTN_Y , POST_BTN_WIDTH, POST_BTN_HEIGHT);
    
    if (isImageTaken==YES) {
        changeTextViewHeight = frame.size.height + 20 + 40;
    }
    else {
        changeTextViewHeight = frame.size.height + 20;
    }
    
    //    XLog(@"framne testc: %f",frame.origin.y);
    //    XLog(@"frame height : %f", frame.size.height);
    //    XLog(@"postCommentView y : %f", postCommentView.frame.origin.y);
    
    return YES;
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
   // [commentTextView resignFirstResponder];
    
}
*/
//- ****************************************************************************

#pragma mark - Video
#pragma mark - VideoView
- (void)showVideoScreenView:(CommentItem*)videoItem{
    
    videoPlayBackFinished = TRUE;
    
    //NSString *urlString = [[NSString stringWithFormat:@"%@",videoItem.commentText] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //XLog(@"Video URL: %@",urlString);
    //urlString = @"http://archive.org/download/WaltDisneyCartoons-MickeyMouseMinnieMouseDonaldDuckGoofyAndPluto/WaltDisneyCartoons-MickeyMouseMinnieMouseDonaldDuckGoofyAndPluto-HawaiianHoliday1937-Video.mp4";
    ///*
    moviePlayer=[[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:videoItem.commentText]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDonePressed:) name:MPMoviePlayerDidExitFullscreenNotification object:moviePlayer];
    //[[NSNotificationCenter defaultCenter] addObserver:self
    //                                         selector:@selector(MPMoviePlayerPlaybackStateDidChange:)
    //                                             name:MPMoviePlayerPlaybackStateDidChangeNotification
    //                                           object:moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoLoadStateChanged:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    
    MPMoviePlayerViewController *playerView = [[MPMoviePlayerViewController alloc]init];
    [moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
    [playerView setView:moviePlayer.view];
    
    [moviePlayer.view setFrame: self.view.bounds];
    [self presentMoviePlayerViewControllerAnimated:playerView];
    moviePlayer.shouldAutoplay=YES;
    [moviePlayer play];
    
    [XIBActivityIndicator startActivity];
    //[self playVideo:urlString];
    
}
- (void)videoLoadStateChanged:(NSNotification *)note {
    switch (moviePlayer.loadState) {
        case MPMovieLoadStatePlayable:
            [XIBActivityIndicator dismissActivity];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
        default:
            break;
    }
    
}

- (void)MPMoviePlayerPlaybackStateDidChange:(NSNotification *)notification{
    if (moviePlayer.playbackState == MPMoviePlaybackStatePlaying)
    { //playing
        [XIBActivityIndicator dismissActivity];
    }
    if (moviePlayer.playbackState == MPMoviePlaybackStateStopped)
    { //stopped
    }if (moviePlayer.playbackState == MPMoviePlaybackStatePaused)
    { //paused
    }if (moviePlayer.playbackState == MPMoviePlaybackStateInterrupted)
    { //interrupted
    }if (moviePlayer.playbackState == MPMoviePlaybackStateSeekingForward)
    { //seeking forward
    }if (moviePlayer.playbackState == MPMoviePlaybackStateSeekingBackward)
    { //seeking backward
    }
    
}

- (void) moviePlayBackDonePressed:(NSNotification*)notification{
    [moviePlayer stop];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerDidExitFullscreenNotification object:moviePlayer];
        
        if ([moviePlayer respondsToSelector:@selector(setFullscreen:animated:)]){
            [moviePlayer.view removeFromSuperview];
        }
        videoPlayBackFinished = FALSE;
        moviePlayer=nil;
    }];
    [XIBActivityIndicator dismissActivity];
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification{
    [moviePlayer stop];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerDidExitFullscreenNotification object:moviePlayer];
        
        if ([moviePlayer respondsToSelector:@selector(setFullscreen:animated:)]){
            [moviePlayer.view removeFromSuperview];
        }
        videoPlayBackFinished = FALSE;
        moviePlayer=nil;
    }];
    
    [XIBActivityIndicator dismissActivity];
}
//
#pragma mark -

-(void)playerStarted:(NSNotification *)notification{
    isVideoPlaying = YES;
}
-(void)playerWillExitFullscreen:(NSNotification *)notification {
    isVideoPlaying = NO;
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

#pragma mark - FULLSCREEN VIEW

#pragma mark - XIBPhotoScrollView delegate
- (void)imageTap:(int)index{
    //XLog(@"%d",index);
    [self showFullScreenView:index];
}


#pragma mark - FullScreenView
- (void)showFullScreenView:(int)index{
    //MediaItem *item = (MediaItem*)[photosArray objectAtIndex:index];
    //NSLog(@"SHow full view - %@",item.itemID);
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    [[AppManager sharedManager] hideNavigationBar];
    fullScreenPhotoView = [[FullScreenPhotoViewer alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height) photosArray:postPhotoArray withSelectedIndex:index isGallery:NO];
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


- (void)handlePinch:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    //handle pinch...
    
    [[AppManager sharedManager] hideNavigationBar];
    fullScreenPhotoView = [[FullScreenPhotoViewer alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height) photosArray:@[commentIamgeUrlOfStringFormate] withSelectedIndex:0 isGallery:NO];
    fullScreenPhotoView.delegate = self;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view addSubview:fullScreenPhotoView];
    }];
    
}

#pragma mark - GestureRecognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
@end
