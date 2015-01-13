//
//  OfferAndPromotionsDetailsViewController.m
//  Pulse
//
//  Created by Supran on 6/19/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "OfferAndPromotionsDetailsViewController.h"

@interface OfferAndPromotionsDetailsViewController ()<XIBPhotoScrollViewDelegate,FullScreenPhotoViewerDelegate>{

    UIScrollView *mainScrollview;
    FullScreenPhotoViewer *fullScreenPhotoView;
    NSMutableArray *photosArray;
}

@end

@implementation OfferAndPromotionsDetailsViewController
@synthesize detailsItem, selectedIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init:(OfferItem *)item with:(NSInteger)index{
    self = [super init];
    if (self) {
        self.title = @"Offers";
        detailsItem = item;
        selectedIndex = index;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    XLog(@"Details: %@",self.detailsItem.photos);
    
    //Create main Scrollview
    mainScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [mainScrollview setContentSize:CGSizeMake(mainScrollview.frame.size.width, mainScrollview.frame.size.height)];
    [self.view addSubview:mainScrollview];
    mainScrollview.userInteractionEnabled = YES;
    
    
    
    NSString *maximumTitle = detailsItem.title;
    //bound your title with maximum size
    if([maximumTitle length]>70){
        maximumTitle=[maximumTitle substringToIndex:67];
        maximumTitle = [maximumTitle stringByAppendingString:@"..."];
    }
    
    
    UIFont *titleFont = [UIFont boldSystemFontOfSize:13.0f];
    CGRect titleTextFrame = [self calculateMaxSize:maximumTitle with:titleFont];
    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, titleTextFrame.size.height)];
//    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    titleLabel.numberOfLines = 0;
//    [titleLabel setFont:titleFont];
//    [titleLabel setTextColor:[UIColor sidraFlatDarkGrayColor]];
//    [titleLabel setText:maximumTitle];
//    [mainScrollview addSubview:titleLabel];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, 300, titleTextFrame.size.height)];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 2;
    [titleLabel setFont:titleFont];
    [titleLabel setTextColor:[UIColor sidraFlatDarkGrayColor]];
    [titleLabel setText:maximumTitle];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [mainScrollview addSubview:titleLabel];
    
    
    NSString *dateTitle = @"";
    if (detailsItem.isLongTermOffer) {
        dateTitle = @"Always available: ";
    }
    else{
        dateTitle = @"Available until: ";
    }
    UILabel *dateTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height + 9, 260, 10)];
    [dateTitleLabel setText:[dateTitle stringByAppendingString:[[CommonHelperClass sharedConstants] getDateNameFormat:[NSString stringWithFormat:@"%@",detailsItem.validPeriod]]]];
    [dateTitleLabel setTextColor:[UIColor sidraFlatRedColor]];
    [dateTitleLabel setFont:[UIFont systemFontOfSize:10.0f]];
    [dateTitleLabel setBackgroundColor:[UIColor clearColor]];
    [mainScrollview addSubview:dateTitleLabel];
    //
    
    UIButton *bookmarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bookmarkButton setFrame:CGRectMake(dateTitleLabel.frame.origin.x + dateTitleLabel.frame.size.width, dateTitleLabel.frame.origin.y - 9 , 40, 40)];
    [bookmarkButton addTarget:self
                       action:@selector(bookmarkAction:)
             forControlEvents:UIControlEventTouchUpInside];
    [bookmarkButton setImage:[UIImage imageNamed:[self getBookmarkedImageName:detailsItem.isBookmarked]] forState:UIControlStateNormal];
    [mainScrollview addSubview:bookmarkButton];
    
    
    //Create image View
    CGRect newCreateFrame = CGRectMake(titleLabel.frame.origin.x, dateTitleLabel.frame.origin.y + dateTitleLabel.frame.size.height + 15, titleLabel.frame.size.width, 160);
    
    //Create Details View
    [self createDetailsSubview:CGRectMake(newCreateFrame.origin.x, newCreateFrame.origin.y + newCreateFrame.size.height + 25, newCreateFrame.size.width+4, FLT_MAX)];
    
    //Add Photo Scroller
    newCreateFrame = CGRectMake(0, dateTitleLabel.frame.origin.y + dateTitleLabel.frame.size.height + 15,
                                mainScrollview.frame.size.width, 160);
    [self addPhotoScrollView:newCreateFrame];
    
    
}

#pragma mark - Photo Carousel
- (void)addPhotoScrollView:(CGRect)frame{
    
    photosArray = [NSMutableArray array];
    [detailsItem.photos enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        [photosArray addObject:[dic objectForKey:@"photo"]];
    }];
    if ([photosArray count]==0) {
        [photosArray addObject:detailsItem.companyThumb];
    }
    
    XIBPhotoScrollView *photoScrollView = [[XIBPhotoScrollView alloc] initWithFrame:frame withPhotos:photosArray];
    photoScrollView.delegate = self;
    [mainScrollview addSubview:photoScrollView];
}

#pragma mark - Button Action

-(IBAction)bookmarkAction:(id)sender{
    [[ServerManager sharedManager] favoriteOffersAndPromotions:detailsItem.itemID isFavorite:detailsItem.isBookmarked?@"0":@"1" completion:^(BOOL success) {
        if (success) {
            UIButton *temp = (UIButton *)sender;
            detailsItem.isBookmarked = !detailsItem.isBookmarked;
            [temp setImage:[UIImage imageNamed:[self getBookmarkedImageName:detailsItem.isBookmarked]] forState:UIControlStateNormal];
        }
    }];
}


-(NSString *)getBookmarkedImageName:(BOOL)isBookmarked{
    NSString *bookmarkedImageName = @"";
    if (isBookmarked) {
        bookmarkedImageName = @"star_icon.png";
    }
    else{
        bookmarkedImageName = @"star_gray_icon.png";
    }
    return bookmarkedImageName;
}




#pragma mark - View delegate

-(void)createDetailsSubview:(CGRect)frame{
    UIView *detailsSubview = [[UIView alloc] init];
    [detailsSubview setBackgroundColor:[UIColor whiteColor]];
    detailsSubview.layer.borderColor = kViewBorderColor;
    detailsSubview.layer.borderWidth = kViewBorderWidth;
    detailsSubview.layer.cornerRadius = kSubViewCornerRadius;
    detailsSubview.layer.masksToBounds = YES;
    [mainScrollview addSubview:detailsSubview];
    
    
//    NSString *titleStr =  detailsItem.title;
//    
//    UIFont *titleFont = [UIFont boldSystemFontOfSize:13.0f];
//    CGRect titleTextFrame = [self calculateMaxSize:titleStr with:titleFont];
//    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, 300, titleTextFrame.size.height)];
//    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    titleLabel.numberOfLines = 2;
//    [titleLabel setFont:titleFont];
//    [titleLabel setTextColor:[UIColor sidraFlatDarkGrayColor]];
//    [titleLabel setText:titleStr];
//    [titleLabel setBackgroundColor:[UIColor clearColor]];
//    [detailsSubview addSubview:titleLabel];
    

    NSString *descriptionStr = detailsItem.a_description;
    
    
    UIFont *desFont = [UIFont systemFontOfSize:12.5f];
    CGRect desTextFrame = [self calculateMaxSize:descriptionStr with:desFont];


    UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, 280, desTextFrame.size.height)];
    desLabel.lineBreakMode = NSLineBreakByWordWrapping;
    desLabel.numberOfLines = 0;
    [desLabel setFont:desFont];
    [desLabel setBackgroundColor:[UIColor clearColor]];
    [desLabel setTextColor:[UIColor sidraFlatGrayColor]];
    [desLabel setText:descriptionStr];
    [detailsSubview addSubview:desLabel];
    
    
    CGFloat height = desLabel.frame.size.height + desLabel.frame.origin.y + 10;
    CGFloat newHeight = (SCREEN_SIZE.height - frame.origin.y);
    
    [detailsSubview setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, MAX(height, newHeight))];

    [mainScrollview setContentSize:CGSizeMake(detailsSubview.frame.size.width, detailsSubview.frame.origin.y + detailsSubview.frame.size.height + 100)];
}





-(CGRect)createTitleImageView:(CGRect)frame{
    
    UIView *imageBgSubview = [[UIView alloc] initWithFrame:frame];
    [imageBgSubview setBackgroundColor:[UIColor whiteColor]];
    imageBgSubview.layer.borderColor = [UIColor sidraFlatGrayColor].CGColor;
    imageBgSubview.layer.borderWidth = 1.0f;
    [mainScrollview addSubview:imageBgSubview];
    
    UIImageView *titleImageview = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, imageBgSubview.frame.size.width-10, imageBgSubview.frame.size.height-10)];
    [titleImageview setImage:[UIImage imageNamed:detailsItem.imageUrl]];
    [imageBgSubview addSubview:titleImageview];
    
    return imageBgSubview.frame;
}









#pragma mark - Common method
-(CGRect)calculateMaxSize:(NSString *)maxText with:(UIFont *)desFont{
    
    
    CGSize maximumLabelSize = CGSizeMake(280, FLT_MAX);
    
    //fetch expected label frame size
    CGRect expectedLabelSize = [maxText boundingRectWithSize:maximumLabelSize
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{
                                                               NSFontAttributeName: desFont
                                                               }
                                                     context:nil];
    
    return expectedLabelSize;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - FULLSCREEN VIEW

#pragma mark - XIBPhotoScrollView delegate
- (void)imageTap:(int)index{
    XLog(@"%d",index);
    [self showFullScreenView:index];
}


#pragma mark - FullScreenView
- (void)showFullScreenView:(int)index{
    //MediaItem *item = (MediaItem*)[photosArray objectAtIndex:index];
    //NSLog(@"SHow full view - %@",item.itemID);
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
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







/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
