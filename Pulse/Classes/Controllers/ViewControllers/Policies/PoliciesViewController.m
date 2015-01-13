//
//  PoliciesViewController.m
//  Pulse
//
//  Created by xibic on 6/11/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "PoliciesViewController.h"
#import "PoliciesLandingCell.h"
#import "CategoryItem.h"
#import "ListingPolicyViewController.h"

#define CELL_HEIGHT 50

@interface PoliciesViewController () <UITableViewDataSource,UITableViewDelegate> {
    
    UITableView *tableViewDeptList;    // For Browse
    NSMutableArray *CatListDataArray;
}


@end

@implementation PoliciesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"Policies";
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigationCustomTitleView:@"Policies" with:@"Listing Departments"];
    
    // ----  Table View To Show Cat List -----
    
    tableViewDeptList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - 65)];
    
    [tableViewDeptList setBackgroundColor:[UIColor clearColor]];
    [tableViewDeptList setDelegate:self];
    [tableViewDeptList setDataSource:self];
    [tableViewDeptList setScrollEnabled:YES];
    //deptListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableViewDeptList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableViewDeptList];
    
    [[ServerManager sharedManager] fetchPolicyDepartments:^(BOOL success, NSMutableArray *resultDataArray) {
        if (success) {
            CatListDataArray = resultDataArray;
            [tableViewDeptList reloadData];
        }
    }];
    
    
}



#pragma mark - Parent View Controller delegate (Navigation Title)

//set title and subtitle text to the navigation bar
-(void)setNavigationCustomTitleView:(NSString *)titleText with:(NSString *)subtitleText{
    //First Remove previous view
    for (UIView *view in self.navigationItem.titleView.subviews) {
        [view removeFromSuperview];
    }
    
    
    //Create view and add to the title view
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.text = titleText;
    [titleLabel sizeToFit];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 0, 0)];
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.textColor = [UIColor whiteColor];
    subTitleLabel.font = [UIFont systemFontOfSize:10];
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if ([CatListDataArray count]==0) {
        return 0;
    }
    else
        return [CatListDataArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell";
    
    PoliciesLandingCell *cell = (PoliciesLandingCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // If there is no cell to reue, create a new one
    if(cell == nil){
        
        cell = [[PoliciesLandingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.deptName.frame = CGRectMake(15, 15, 200, 20);
        cell.grayArrow.frame =CGRectMake(self.view.frame.size.width - 35, 17, 10, 15);
    }
    
    CategoryItem *item = (CategoryItem *)[CatListDataArray objectAtIndex:indexPath.row];
    cell.deptName.text = item.cat_name;
    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableViewDeptList deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    CategoryItem *item = (CategoryItem *)[CatListDataArray objectAtIndex:indexPath.row];
    
    ListingPolicyViewController *goPolicyList = [[ListingPolicyViewController alloc] initWithNibName:@"ListingPolicyViewController" bundle:nil];
    goPolicyList.shouldShowRightMenuButton = YES ;
    goPolicyList.department = item;
    [self.navigationController pushViewController:goPolicyList animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  CELL_HEIGHT;
}
@end
