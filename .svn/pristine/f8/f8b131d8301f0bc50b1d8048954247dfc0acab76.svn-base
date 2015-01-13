//
//  GalleryViewController.m
//  Pulse
//
//  Created by xibic on 6/11/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "GalleryViewController.h"
#import "GalleryAlbumDetailsViewController.h"
#import "SidraAlbumView.h"
#import "OffersAndPromotionsShowView.h"
#import "Categorytableview.h"
#import "AlbumYearItem.h"

@interface GalleryViewController ()<SidraAlbumViewDelegate,CategorytableviewDelegate>{
    NSMutableArray *dataArray;
    OffersAndPromotionsShowView *yearDropDownView;
    Categorytableview *categoryTableView;
    __block SidraAlbumView *sidraAlbumView;
}


@end

@implementation GalleryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"Gallery";
        [self setNavigationCustomTitleView:@"Gallery" with:@"Browse Collections"];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    sidraAlbumView = [[SidraAlbumView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60)];
    sidraAlbumView.delegate = self;
    [self.view addSubview:sidraAlbumView];
    
    //Create show view
    yearDropDownView = [[OffersAndPromotionsShowView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [yearDropDownView.selectButton addTarget:self
                                   action:@selector(dropDownAction:)
                         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yearDropDownView];
    //Create Drop Down View
    [self createCategoryDropDownView];
    [self.view bringSubviewToFront:categoryTableView];
    
    [self populateDropDownList];
    
    dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
    dispatch_async(backgroundQueue, ^{
        //Clear bubble notification = 4 == Gallery type
        [[ServerManager sharedManager] updateBubbleNotificationStatus:@"4" completion:^(BOOL success) {
            if (success) {
            }
        }];
    });
    
    
}


#pragma mark - AlbumView delegate
- (void)clickedAlbum:(AlbumItem *)albumItem{
    XLog(@"Category: %@",albumItem.itemID);
    GalleryAlbumDetailsViewController *detailsView= [[GalleryAlbumDetailsViewController alloc] initWithNibName:@"GalleryAlbumDetailsViewController" bundle:nil];
    detailsView.albumItem = albumItem;
    detailsView.shouldShowRightMenuButton = YES;
    [self.navigationController pushViewController:detailsView animated:YES];
    //detailsView = nil;
}




#pragma mark - DropDown View

-(void)populateDropDownList{
    
    
    [[ServerManager sharedManager] fetchGalleryAlbumYearList:^(BOOL success, NSMutableArray *resultDataArray) {
        if (success) {
            //Call Drop Down Value Api Here
            //[categoryTableView setDataArrayValueForAlbum:resultDataArray];
            
            NSMutableArray *dropDownArray = [NSMutableArray array];
            
            //-------- get date from device
            NSCalendar *cal = [NSCalendar currentCalendar];
            NSDateComponents *components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
            
            for (int i=0; i<resultDataArray.count; i++) {
                AlbumYearItem *item = (AlbumYearItem *)[resultDataArray objectAtIndex:i];
                CategoryItem *drop_item = [[CategoryItem alloc] init];
                drop_item.cat_name = [NSString stringWithFormat:@"%@ (%@ albums)",item.galleryYear,item.numberOfAlbum];
                drop_item.cat_id = [NSString stringWithFormat:@"%@",item.galleryYear];
                
                if ([components year] == [item.galleryYear integerValue]) {
                    drop_item.date_value = item.galleryYear;
                }
                else{
                    drop_item.date_value = @"";
                }
                
                [dropDownArray addObject:drop_item];
            }
            
            //Call Drop Down Value Api Here
            [categoryTableView setDataArrayValueForAlbum:dropDownArray];
            
        }
    }];

    
}

-(void)createCategoryDropDownView{
    
    categoryTableView= [[Categorytableview alloc] initMethodGeneral:CGRectMake(yearDropDownView.frame.origin.x, yearDropDownView.frame.origin.y + yearDropDownView.frame.size.height - 10, yearDropDownView.frame.size.width, SCREEN_SIZE.height) with:self];
    [self.view addSubview:categoryTableView];
    [categoryTableView setHidden:YES];
    
    
}



#pragma mark - Drop Down Delegate

-(void)categorySelect:(NSString *)categoryName withCatId:(NSInteger)cat_id{
    [self closeCategoryTableview];

    [yearDropDownView.showTextField setText:categoryName];
    [yearDropDownView.showTextField setTag:cat_id];
    [[ServerManager sharedManager] fetchGalleryAlbumList:@"1" year:[NSString stringWithFormat:@"%i",cat_id] completion:^(BOOL success, NSMutableArray *resultDataArray) {
        if (success) {
            [sidraAlbumView addAlbumViews:resultDataArray];
            
        }else{
            
        }
    }];
}

-(void)closeCategoryTableview{
    //If category tableview open then close it
    if (!categoryTableView.hidden) {
        [self dropDownAction:yearDropDownView.selectButton];
    }
}
#pragma mark -Drop Down Show Button Action

-(IBAction)dropDownAction:(id)sender{
    if (categoryTableView.hidden) {
        [categoryTableView openCategoryView];
    }
    else{
        [categoryTableView closeCategoryView];
    }
}


#pragma mark - Pull Refresh

- (void)pullDownToRefresh{
    
    
   /* AnnouncementItem *item = (AnnouncementItem*)[dataArray objectAtIndex:0];
    lastElementID = [NSString stringWithFormat:@"%@",item.itemID];
    [[ServerManager sharedManager] fetchAnnouncements:[NSString stringWithFormat:@"%@",lastElementID] scrollDirection:@"0" completion:^(BOOL success, NSMutableArray *resultDataArray) {
        isLoading = NO;
        //loadingView.alpha = 0.0f;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [loadingView dismisssView];
        });
        
        
        if (success) {
            [resultDataArray addObjectsFromArray:dataArray];
            dataArray = resultDataArray;
            [self.announcementTableview reloadData];
            
        }else{
        }
        
    }];*/
    
}
- (void)pullUpToRefresh{
    
    /*AnnouncementItem *item = (AnnouncementItem*)[dataArray objectAtIndex:dataArray.count-1];
    lastElementID = [NSString stringWithFormat:@"%@",item.itemID];
    [[ServerManager sharedManager] fetchAnnouncements:[NSString stringWithFormat:@"%@",lastElementID] scrollDirection:@"1" completion:^(BOOL success, NSMutableArray *resultDataArray) {
        isLoading = NO;
        //loadingView.alpha = 0.0f;
        dispatch_async(dispatch_get_main_queue(), ^{
            [loadingView dismisssView];
        });
        if (success) {
            [dataArray addObjectsFromArray:resultDataArray];
            [self.announcementTableview reloadData];
        }else{
        }
        XLog(@"----%@-----",lastElementID);
    }];*/
    
}

-(void)loadingPullUpView{
    [super loadingPullUpView];
    CGRect frame = CGRectMake(0, SCREEN_SIZE.height-40.0f, SCREEN_SIZE.width, 40.0f);
    loadingView.frame = frame;
    loadingView.alpha = 1.0f;
    [loadingView apeareLoadingView];
}

-(void) loadingPullDownView{
    [super loadingPullDownView];
    CGRect frame = CGRectMake(0, 63.0f, SCREEN_SIZE.width, 40.0f);
    loadingView.frame = frame;
    loadingView.alpha = 1.0f;
    [loadingView apeareLoadingView];
    
}





@end
