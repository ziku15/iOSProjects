//
//  NewsViewController.m
//  Pulse
//
//  Created by Atomix on 7/10/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableCell.h"
#import "NewsItem.h"
#import "NewsWebViewController.h"


#define CELL_HEIGHT 85

@interface NewsViewController ()<UITableViewDataSource, UITableViewDelegate> {
    
    UITableView *newsTableView;
    NSMutableArray *newsDataArray;
}

@end

@implementation NewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"Sidra in the News";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    SCROLL_CONSIDER_HEIGHT = 00;
    //  demo Data
    
//    newsDataArray = [[NSMutableArray alloc] init];
//    
//    for (int i = 0; i< 10; i++) {
//        
//        NewsItem *item = [[NewsItem alloc] init];
//        
//        item.headline = [NSString stringWithFormat:@"Tapping on any of these items opens the selected link in an internal web-browser %d",i];
//        item.releaseDate = @"Sunday, April 12, 2014";
//        item.sourcePublication = @"CNN";
//        item.link = @"http://www.google.com";
//        
//        [newsDataArray addObject:item];
//        item = nil;
//    }
    
    
    // news Table ViewTable View
    newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - 73)];
    
    [newsTableView setBackgroundColor:[UIColor clearColor]];
    [newsTableView setDelegate:self];
    [newsTableView setDataSource:self];
    [newsTableView setScrollEnabled:YES];
     newsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     newsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:newsTableView];
    
    [[ServerManager sharedManager] fetchSidraInNews:@"" scrollDirection:@"" completion:^(BOOL success, NSMutableArray *resultDataArray) {
        if (success) {
            newsDataArray = resultDataArray;
            [newsTableView reloadData];
        }
    }];
    
}

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
    
    if ([newsDataArray count]==0) {
        return 0;
    }
    else
        return [newsDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell";
    
    NewsTableCell *cell = (NewsTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // If there is no cell to reuse, create a new one
    if(cell == nil){
        
        cell = [[NewsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.headLineText.frame = CGRectMake(15, 15, 290, 30);
        cell.releaseDate.frame = CGRectMake(15, 45 , 280, 12);
        cell.source.frame = CGRectMake(15, 61, 60, 12);
        cell.sourceName.frame = CGRectMake(66, 61, 200, 12);
        cell.bgView.frame =CGRectMake(10, 10, 300, 75);
        cell.backgroundColor = [UIColor clearColor];
    }
    
    
    NewsItem *item = (NewsItem *)[newsDataArray objectAtIndex:indexPath.row];
    
    cell.headLineText.text = item.headline;
    cell.releaseDate.text =  [[SettingsManager sharedManager] showPostedByFromDate:item.releaseDate];
    cell.sourceName.text = item.sourcePublication;
    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [newsTableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
    
    NewsItem *item = (NewsItem *)[newsDataArray objectAtIndex:indexPath.row];
    
    
    NewsWebViewController *_newsWebView = [[NewsWebViewController alloc] initWithNibName:@"NewsWebViewController" bundle:nil];
    _newsWebView.shouldShowRightMenuButton = YES ;
    _newsWebView.webLink = item.link;
    [self.navigationController pushViewController:_newsWebView animated:YES];
    _newsWebView = nil;
    
 
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  CELL_HEIGHT;
}
/*
- (void)pullDownToRefresh{
    [[ServerManager sharedManager] fetchSidraInNews:[NSString stringWithFormat:@"%d",pageNo] completion:^(BOOL success, NSMutableArray *resultDataArray) {
        //
        if (success) {
            [newsDataArray addObjectsFromArray:resultDataArray];
            [newsTableView reloadData];
        }else{
            pageNo = -1;//Mark that no more data is available
        }
        isLoading = NO;
    }];
    
}*/
#pragma mark - Pull Refresh
- (void)pullDownToRefresh{
    NewsItem *item = (NewsItem *)[newsDataArray objectAtIndex:0];
    lastElementID = [NSString stringWithFormat:@"%@",item.itemID];
    [[ServerManager sharedManager] fetchSidraInNews:[NSString stringWithFormat:@"%@",lastElementID] scrollDirection:@"0" completion:^(BOOL success, NSMutableArray *resultDataArray) {
        isLoading = NO;
        [loadingView dismisssView];
        if (success) {
            [resultDataArray addObjectsFromArray:newsDataArray];
            newsDataArray = resultDataArray;
            [newsTableView reloadData];
        }else{
        }
        
    }];
    
}
- (void)pullUpToRefresh{
    NewsItem *item = (NewsItem *)[newsDataArray objectAtIndex:newsDataArray.count-1];
    lastElementID = [NSString stringWithFormat:@"%@",item.itemID];
    [[ServerManager sharedManager] fetchSidraInNews:[NSString stringWithFormat:@"%@",lastElementID] scrollDirection:@"1" completion:^(BOOL success, NSMutableArray *resultDataArray) {
        isLoading = NO;
        [loadingView dismisssView];
        if (success) {
            [newsDataArray addObjectsFromArray:resultDataArray];
            [newsTableView reloadData];
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
    CGRect frame = CGRectMake(0, 65.0f, SCREEN_SIZE.width, 40.0f);
    loadingView.frame = frame;
    loadingView.alpha = 1.0f;
    [loadingView apeareLoadingView];
    
}


@end
