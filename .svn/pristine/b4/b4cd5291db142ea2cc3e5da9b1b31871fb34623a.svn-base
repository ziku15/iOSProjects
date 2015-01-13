//
//  AnnouncementViewController.m
//  Pulse
//
//  Created by xibic on 6/11/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "AnnouncementViewController.h"
#import "LoginViewController.h"
@interface AnnouncementViewController (){
    NSMutableArray *dataArray;
    AnnouncementDetailsViewController *announceDetails;
}

@end

@implementation AnnouncementViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Announcements";
        
        dataArray = [[NSMutableArray alloc] init];
        announceDetails = nil;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.announcementTableview.backgroundColor = [UIColor clearColor];
    SCROLL_CONSIDER_HEIGHT = 00;
    
    [self reloadtable];
    /*
    [[ServerManager sharedManager] fetchAnnouncements:@"" scrollDirection:@"" completion:^(BOOL success, NSMutableArray *resultDataArray) {
        if (success) {
            dataArray = resultDataArray;
            [self.announcementTableview reloadData];
            
        }else{
            //[self showLoginView];
        }
    }];
    */
    
    dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
    dispatch_async(backgroundQueue, ^{
        //Clear bubble notification = 1 == Announcment type
        [[ServerManager sharedManager] updateBubbleNotificationStatus:@"1" completion:^(BOOL success) {
            if (success) {
            }
        }];
    });
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (announceDetails != nil) {
        [dataArray replaceObjectAtIndex:announceDetails.selectedIndex withObject:announceDetails.detailsItem];
        announceDetails = nil;
        
        [self.announcementTableview reloadData];
    }
    
}


#pragma mark - reload method

-(void) reloadtable{
    [[ServerManager sharedManager] fetchAnnouncements:@"" scrollDirection:@"" completion:^(BOOL success, NSMutableArray *resultDataArray) {
        if (success) {
            dataArray = resultDataArray;
            [self.announcementTableview reloadData];
            
        }else{
            //[self showLoginView];
        }
    }];
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
    if(indexPath.row < [dataArray count])
    {
        AnnouncementItem *item = [dataArray objectAtIndex:indexPath.row];
        CommonDynamicCellModel *calculatedModel = [AnnouncementCell calculateMaxSize:item.title];
        
        return calculatedModel.maxSize.height + 40;
    }
    else{
        return 44;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";

    AnnouncementCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {

        cell = [[AnnouncementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]; //with:dataModel] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    AnnouncementItem *dataModel = [dataArray objectAtIndex:indexPath.row];
    
    UILabel *titleLabel = [cell createTitleView:[NSString stringWithFormat:@"%@",dataModel.title]];
    UILabel *dateLabel = [cell createDateView:[NSString stringWithFormat:@"%@",dataModel.createdDate] previousView:titleLabel];
    [cell createXIBFlatButton:[NSString stringWithFormat:@"%@",dataModel.cat_name] previousView:dateLabel];
    
    if (!dataModel.isRead) {
        [cell setBackgroundColor:[UIColor flatCloudsColor]];
    }
    else{
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    announceDetails = [[AnnouncementDetailsViewController alloc] init:[dataArray objectAtIndex:indexPath.row] with:indexPath.row];
    announceDetails.shouldShowRightMenuButton = YES;
    [self.navigationController pushViewController:announceDetails animated:YES];
    
}

#pragma mark - Pull Refresh

- (void)pullDownToRefresh{
    
    
    AnnouncementItem *item = (AnnouncementItem*)[dataArray objectAtIndex:0];
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
        
    }];
    
}
- (void)pullUpToRefresh{
    
    AnnouncementItem *item = (AnnouncementItem*)[dataArray objectAtIndex:dataArray.count-1];
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
    }];
    
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

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}





@end
