//
//  OffersAndPromotionsViewController.m
//  Pulse
//
//  Created by xibic on 6/11/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "OffersAndPromotionsViewController.h"
#import "CategoryItem.h"


static int selectedTabberBtn=0;

@interface OffersAndPromotionsViewController (){
    NSMutableArray *dataArray;
    Categorytableview *categoryTableView;
    OffersAndPromotionsShowView *categoryShowView;
    OffersAndPromotionsTabView *tabbarView;
    UILabel *noPostLabel;
    OfferAndPromotionsDetailsViewController *offerDetailsViewController;
    
    
}

@end

@implementation OffersAndPromotionsViewController
@synthesize offerTableview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"Offers";
        [self setNavigationCustomTitleView:@"Offers" with:@"Offers expiring in 30 Days"];
        dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}


-(void)createCategoryShowView{
    categoryShowView = [[OffersAndPromotionsShowView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [categoryShowView setBackgroundColor:[UIColor whiteColor]];
    [categoryShowView.selectButton addTarget:self
                                      action:@selector(selectAction:)
                            forControlEvents:UIControlEventTouchUpInside];
    [categoryShowView.showTextField setText:@"Show All"];
    [categoryShowView.showTextField setTag:0];
    [self.view addSubview:categoryShowView];
    //[self.offerScrollview bringSubviewToFront:categoryShowView];
}



//*************************************Navigation Bar UPdate Method*************************

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


//*******************************************************************************************




-(void)createCategoryDropDownView{

    categoryTableView= [[Categorytableview alloc] initWithFrame:CGRectMake(categoryShowView.frame.origin.x, categoryShowView.frame.origin.y + categoryShowView.frame.size.height - 10, categoryShowView.frame.size.width, 300) with:self];
    [self.view addSubview:categoryTableView];
    [categoryTableView setHidden:YES];

    
}
- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    SCROLL_CONSIDER_HEIGHT = 000;
    
    
    


    //Create show view
    [self createCategoryShowView];
    
    [self createNoPostLabel];
    
    //Create tab panel+
    tabbarView = [[OffersAndPromotionsTabView alloc] initWithFrame:CGRectMake(categoryShowView.frame.origin.x, categoryShowView.frame.origin.y+ categoryShowView.frame.size.height - 5, categoryShowView.frame.size.width, 40 ) with:self];
    [self.view addSubview:tabbarView];
    
    
    
    //Create Feed View
    [self createFeedView:tabbarView.frame];
    
    
    

    
    //Create Category Drop down view
    [self createCategoryDropDownView];
    [self.offerScrollview bringSubviewToFront:categoryTableView];


    

    //Call initialize data entry api
    [self callCategoryApiForTheFirstTime];
    
    dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
    dispatch_async(backgroundQueue, ^{
        //Clear bubble notification = 5 == Offers and Promotion type
        [[ServerManager sharedManager] updateBubbleNotificationStatus:@"5" completion:^(BOOL success) {
            if (success) {
            }
        }];
    });
}

-(void)viewWillAppear:(BOOL)animated{
    if (offerDetailsViewController != nil) {
        [dataArray replaceObjectAtIndex:offerDetailsViewController.selectedIndex withObject:offerDetailsViewController.detailsItem];
        offerDetailsViewController = nil;
        [self tabbedButtonAction:selectedTabberBtn];
        //[offerTableview reloadData];
        //[self refreshView];
    }
}


-(void) createNoPostLabel{
    noPostLabel = [[UILabel alloc] initWithFrame:CGRectMake(00, self.view.bounds.size.height/3, self.view.bounds.size.width, 200)];
    [noPostLabel setText:NO_DATA_MESSAGE];
    [noPostLabel setFont:[UIFont boldSystemFontOfSize:23.5f]];
    [noPostLabel setTextAlignment:NSTextAlignmentCenter];
    noPostLabel.alpha = 0.0f;
    [self.view addSubview:noPostLabel];
}


#pragma mark - api call 
-(void)callApiParser:(NSString *)cat_id with:(NSString *)type with:(NSString *)elementID direction:(NSString*)direction{
    //Server Data Parsing
   
    [[ServerManager sharedManager] fetchOffersAndPromotions:elementID category:cat_id type:type scrollDirection:direction completion:^(BOOL success, NSMutableArray *resultDataArray) {
        
        if (success) {
            dataArray = resultDataArray;
        }
        else{
            [dataArray removeAllObjects];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [loadingView dismisssView];
            [self refreshView];
        });
    }];
}

-(void)callApiBy{
    int catID = (int)categoryShowView.showTextField.tag;
    
//    if (catID==3) {
//        catID = 4;
//    }else if(catID==4){
//        catID = 3;
//    }else{
//        catID = categoryShowView.showTextField.tag;
//    }
    
    
    NSString *cat_id = [NSString stringWithFormat:@"%i", catID];
    NSString *type = [NSString stringWithFormat:@"%i", [self returnTabbadButtonSelection]];
    
    [self callApiParser:cat_id with:type with:@""  direction:@""];
    
}

-(void)callCategoryApiForTheFirstTime{
    
     self.view.userInteractionEnabled=NO;
    [[ServerManager sharedManager] fetchOffersAndPromotionsCategories:^(BOOL success, NSMutableArray *resultDataArray) {
        if (success) {
   
            
          
            dispatch_async(dispatch_get_main_queue(), ^{
                  [categoryTableView setDataArrayValue:resultDataArray];
                self.view.userInteractionEnabled=YES;
            });
        }
    }];
    
}


-(int)returnTabbadButtonSelection{
    //select type
    //1 = expiring soon, 2 - ........
    int button_tag = 0;
    for (OffersAndPromotionsButton *btn in tabbarView.buttonArray) {
        if (btn.selected) {
            button_tag = (int)btn.tag;
            break;
        }
    }
    
    int catID = button_tag+1;
    if (catID==3) {
        catID = 4;
    }else if(catID==4){
        catID = 3;
    }
    
    return catID;
}

#pragma mark - tabbar delegate
-(void)tabbedButtonAction:(int)button_tag{
      // [super scrollViewDidEndDecelerating:self.offerScrollview];
    
    selectedTabberBtn=button_tag;
    
    for (UIView *view in self.offerScrollview.subviews) {
        if (view.tag == 100) {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 0)];
            [self.offerScrollview setContentSize:CGSizeMake(0, 0 )];
            
        }
    }
    
      [super scrollViewDidEndDecelerating:self.offerScrollview];
    //[self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.6];

    if (button_tag==0) {
        [self setNavigationCustomTitleView:@"Offers" with:@"Offers expiring in 30 Days"];
    }else if (button_tag ==3){
        [self setNavigationCustomTitleView:@"Offers" with:@"Bookmarked Offers"];
    }else{
        [self setNavigationCustomTitleView:@"Offers" with:@""];
    }
    [self callApiBy];
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
     [super scrollViewDidEndDecelerating:self.offerScrollview];
    
    //[NSObject cancelPreviousPerformRequestsWithTarget:self];
    
}
#pragma mark - this view delegate

-(void)createFeedView:(CGRect)previousFrame{
    offerTableview = [[UITableView alloc] initWithFrame:CGRectMake(previousFrame.origin.x, previousFrame.origin.y+previousFrame.size.height, previousFrame.size.width, 350)];
    [offerTableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [offerTableview setBackgroundColor:[UIColor clearColor]];
    [offerTableview setScrollEnabled:NO];
    [offerTableview setDelegate:self];
    [offerTableview setDataSource:self];
    [offerTableview setTag:100];
    [self.offerScrollview addSubview:offerTableview];
}

-(void)refreshView{
    
    if(dataArray.count>0)
    [offerTableview reloadData];
    
    if(dataArray)
    dataArray.count<=0? (noPostLabel.alpha=1.0f):(noPostLabel.alpha = 0.0f);
    
    CGFloat newHeight = dataArray.count * 135;
    
    for (UIView *view in self.offerScrollview.subviews) {
        if (view.tag == 100) {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, newHeight)];
            [self.offerScrollview setContentSize:CGSizeMake(view.frame.size.width, view.frame.size.height + view.frame.origin.y + 10)];
         
        }
    }
    
}

#pragma mark - Category Table view
-(void)categorySelect:(NSString *)categoryName withCatId:(NSInteger)cat_id{
    [self closeCategoryTableview];
    [categoryShowView.showTextField setText:categoryName];
    [categoryShowView.showTextField setTag:cat_id];
    
    [self callApiBy];
}

#pragma mark - Method for category table view close

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self closeCategoryTableview];
    [self isDragging];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    

    [self stoppedDragging];
}
/*
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
       

}*/

-(void)closeCategoryTableview{
    //If category tableview open then close it
    if (!categoryTableView.hidden) {
        [self selectAction:categoryShowView.selectButton];
    }
}
#pragma mark - show view delegate

-(IBAction)selectAction:(id)sender{
    
//    UIButton *temp = (UIButton *) sender;
    if (categoryTableView.hidden) {
//        temp.selected = NO;
        [categoryTableView openCategoryView];
        
    }
    else{
//        temp.selected = YES;
        
        [categoryTableView closeCategoryView];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([dataArray count]>0)
        return [dataArray count];
    else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 135;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";//[NSString stringWithFormat:@"Cell%i", indexPath.row];
    
    OffersAndPromotionsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[OffersAndPromotionsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }

    if(dataArray.count>0){
    OfferItem *dataModel = [dataArray objectAtIndex:indexPath.row];
    
    AsyncImageView *titleImageview = [cell createTitleImageView:[NSString stringWithFormat:@"%@",dataModel.companyThumb]];
    UILabel *titleLabel = [cell createTitleView:[NSString stringWithFormat:@"%@",dataModel.title] previousView:titleImageview];

//    NSLog(@"%i",[self returnTabbadButtonSelection]);
    [cell createDateTitleView:dataModel.isLongTermOffer validPariod:[NSString stringWithFormat:@"%@",dataModel.validPeriod] preView:titleLabel];
    [cell createBookmarkedButton];
    
    [cell.bookmarkButton setTag:indexPath.row];
    [cell.bookmarkButton addTarget:self
                            action:@selector(bookmarkAction:)
                  forControlEvents:UIControlEventTouchUpInside];
    [cell.bookmarkButton setImage:[UIImage imageNamed:[self getBookmarkedImageName:dataModel.isBookmarked]] forState:UIControlStateNormal];
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"------------------------------------------- CLick ------------------------------------------");
    [self closeCategoryTableview];
    OfferItem *dataModel = [dataArray objectAtIndex:indexPath.row];
    offerDetailsViewController = nil;
    offerDetailsViewController = [[OfferAndPromotionsDetailsViewController alloc] init:dataModel with:indexPath.row];
    offerDetailsViewController.shouldShowRightMenuButton = YES;
    [self.navigationController pushViewController:offerDetailsViewController animated:YES];
}

#pragma mark - button action

-(IBAction)bookmarkAction:(id)sender{
    

    
    UIButton *temp = (UIButton *)sender;
    
    OfferItem *dataModel = [dataArray objectAtIndex:temp.tag];
    
    [[ServerManager sharedManager] favoriteOffersAndPromotions:dataModel.itemID isFavorite:dataModel.isBookmarked?@"0":@"1" completion:^(BOOL success) {
        if (success) {
            dataModel.isBookmarked = !dataModel.isBookmarked;
            [temp setImage:[UIImage imageNamed:[self getBookmarkedImageName:dataModel.isBookmarked]] forState:UIControlStateNormal];
            
            [dataArray replaceObjectAtIndex:temp.tag withObject:dataModel];
            [self refreshView];
            
            if (dataModel.isBookmarked) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Contact has been added to 'Saved Contacts' section'" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    //        [alert show];
                    //        alert = nil;
                    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/10.0, [UIScreen mainScreen].bounds.size.height/6.0 , 200, 50);
                    NSString *msg = @"Offer added to the My Favorites section";
                    AlertPopView *alertMsg = [[AlertPopView alloc] initWithFrame:frame alertMsg:msg];
                    [self.view addSubview:alertMsg];
                    alertMsg = nil;
                });
            }else{
                CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/10.0, [UIScreen mainScreen].bounds.size.height/6.0 , 200, 50);
                NSString *msg = @"Offer removed to the My Favorites section";
                AlertPopView *alertMsg = [[AlertPopView alloc] initWithFrame:frame alertMsg:msg];
                [self.view addSubview:alertMsg];
                alertMsg = nil;
                [self tabbedButtonAction:selectedTabberBtn];
            }
            
        }
    }];
    
    
}




#pragma mark - Common method

-(NSString *)getBookmarkedImageName:(BOOL)isBookmarked{
    NSString *bookmarkedImageName = @"";
    if (isBookmarked) {
        bookmarkedImageName = @"Offer_Promotion_star_black.png";
    }
    else{
        bookmarkedImageName = @"Offer_Promotion_star_gray.png";
    }
    return bookmarkedImageName;
}

#pragma mark - Pull Refresh

- (void)pullDownToRefresh{
    OfferItem *item = (OfferItem*)[dataArray objectAtIndex:0];
    lastElementID = [NSString stringWithFormat:@"%@",item.itemID];
    
    NSString *cat_id = [NSString stringWithFormat:@"%li", (long)categoryShowView.showTextField.tag];
    NSString *type = [NSString stringWithFormat:@"%i", [self returnTabbadButtonSelection]];
    
   
    
    [[ServerManager sharedManager] fetchOffersAndPromotions:lastElementID category:cat_id type:type scrollDirection:@"0" completion:^(BOOL success, NSMutableArray *resultDataArray) {
       
        if (success) {
            [resultDataArray addObjectsFromArray:dataArray];
            dataArray = resultDataArray;
           
        }
        else{

        }
        
        isLoading = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
          
            [loadingView dismisssView];
            [self refreshView];
              self.view.userInteractionEnabled=YES;
        });
    }];
 
}
- (void)pullUpToRefresh{
    OfferItem *item = (OfferItem*)[dataArray objectAtIndex:dataArray.count-1];
    lastElementID = [NSString stringWithFormat:@"%@",item.itemID];
    
    NSString *cat_id = [NSString stringWithFormat:@"%i", (int)categoryShowView.showTextField.tag];
    NSString *type = [NSString stringWithFormat:@"%i", [self returnTabbadButtonSelection]];
    
    
    
    [[ServerManager sharedManager] fetchOffersAndPromotions:lastElementID category:cat_id type:type scrollDirection:@"1" completion:^(BOOL success, NSMutableArray *resultDataArray) {
       
        
        if (success) {
            [dataArray addObjectsFromArray:resultDataArray];
        }
        else{
            
        }
        
        isLoading = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [loadingView dismisssView];
            [self refreshView];
            self.view.userInteractionEnabled=YES;
        });
    }];
    
}

-(void)isDragging{
    
    self.view.userInteractionEnabled=NO;

}

-(void)stoppedDragging{
    
    self.view.userInteractionEnabled=YES;
    
}



-(void)loadingPullUpView{
    [super loadingPullUpView];
     self.view.userInteractionEnabled=NO;
    CGRect frame = CGRectMake(0, SCREEN_SIZE.height-40.0f, SCREEN_SIZE.width, 40.0f);
    loadingView.frame = frame;
    loadingView.alpha = 1.0f;
    [loadingView apeareLoadingView];
}

-(void) loadingPullDownView{
     self.view.userInteractionEnabled=NO;
    [super loadingPullDownView];
    CGRect frame = CGRectMake(0, 60.0f+90.0f, SCREEN_SIZE.width, 40.0f);
    loadingView.frame = frame;
    loadingView.alpha = 1.0f;
    [loadingView apeareLoadingView];
    
}

#pragma scrollview delegate mathod



@end
