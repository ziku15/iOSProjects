//
//  ListingPolicyViewController.m
//  Pulse
//
//  Created by Atomix on 7/8/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "ListingPolicyViewController.h"
#import "ListingPoliciesTableCell.h"
#import "PolicyItem.h"
#import "PolicyDetailsViewController.h"
#import "CategoryItem.h"



#define CELL_HEIGHT 80

@interface ListingPolicyViewController () <UITableViewDataSource,UITableViewDelegate> {
    
    NSMutableArray *listingPolicyDataArray;
    UITableView *listingPolicyTableView;
    NSMutableArray *CatListDataArray;
    UILabel * noPostLabel;
}


@end

@implementation ListingPolicyViewController


@synthesize department;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    noPostLabel = [[UILabel alloc] initWithFrame:CGRectMake(00, self.view.frame.size.height/4, self.view.frame.size.width, 200)];
    [noPostLabel setText:NO_DATA_MESSAGE];
    [noPostLabel setFont:[UIFont boldSystemFontOfSize:23.5f]];
    [noPostLabel setTextAlignment:NSTextAlignmentCenter];
    noPostLabel.alpha = 0.0f;
    [self.view addSubview:noPostLabel];
    NSString * titleStr = self.department.cat_name;
    if(titleStr.length>20){
        titleStr = [[titleStr substringToIndex:15] stringByAppendingString:@"..."];
    }
    [self setNavigationCustomTitleView:@"Listing Policies for Department:" with:titleStr];
    
    
    // ----  Table View To Show Policy By Department -----
    
    listingPolicyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - 65)];
    
    [listingPolicyTableView setBackgroundColor:[UIColor clearColor]];
    [listingPolicyTableView setDelegate:self];
    [listingPolicyTableView setDataSource:self];
    [listingPolicyTableView setScrollEnabled:YES];
    //listingPolicyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    listingPolicyTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:listingPolicyTableView];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [[ServerManager sharedManager] fetchPolicyDetails:self.department.cat_id completion:^(BOOL success, NSMutableArray *resultDataArray) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                listingPolicyDataArray = resultDataArray;
                if ([listingPolicyDataArray count]==0) {
                    noPostLabel.alpha = 1.0f;
                }
                else{
                    noPostLabel.alpha = 0.0f;
                    [listingPolicyTableView reloadData];
                }

            });
            
        }else{
            noPostLabel.alpha = 1.0f;
        }
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Parent View Controller delegate (Navigation Title)

//set title and subtitle text to the navigation bar
-(void)setNavigationCustomTitleView:(NSString *)titleText with:(NSString *)subtitleText{
    //First Remove previous view
    for (UIView *view in self.navigationItem.titleView.subviews) {
        [view removeFromSuperview];
    }
    
    
    //Create view and add to the title view
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -5, 0, 0)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:13];
    titleLabel.text = titleText;
    [titleLabel sizeToFit];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 0, 0)];
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.textColor = [UIColor whiteColor];
    subTitleLabel.font = [UIFont boldSystemFontOfSize:16];
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
    
    
        return [listingPolicyDataArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell";
    
    ListingPoliciesTableCell *cell = (ListingPoliciesTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // If there is no cell to reuse, create a new one
    if(cell == nil){
        
        cell = [[ListingPoliciesTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.titleName.frame = CGRectMake(10, 5, 300, 40);
        cell.policyNo.frame = CGRectMake(10, 55, 300, 15);
    }
    
    PolicyItem *item = (PolicyItem *)[listingPolicyDataArray objectAtIndex:indexPath.row];
    
    cell.titleName.text = item.title;
    cell.policyNo.text = [NSString stringWithFormat:@"Policy Number : %@", item.PolicyNO];
    
    return cell;
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PolicyItem *item = (PolicyItem *)[listingPolicyDataArray objectAtIndex:indexPath.row];

    PolicyDetailsViewController *_goPolicyDetailsView = [[PolicyDetailsViewController alloc] initWithNibName:@"PolicyDetailsViewController" bundle:nil];
    _goPolicyDetailsView.itemArray = item;
    _goPolicyDetailsView.shouldShowRightMenuButton = YES;
    [self.navigationController pushViewController:_goPolicyDetailsView animated:YES];

     [listingPolicyTableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  CELL_HEIGHT;
}

@end
