//
//  StayInformedViewController.m
//  Pulse
//
//  Created by xibic on 6/11/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "StayInformedViewController.h"
#import "StayInformedTableCell.h"
#import "PressRealeseViewController.h"
#import "NewsViewController.h"
#import "MediaViewController.h"

#define CELL_HEIGHT 50

@interface StayInformedViewController () <UITableViewDataSource,UITableViewDelegate> {
    
    NSArray *itemList;
    UITableView *tableViewStayInFormed;
    
}

@end

@implementation StayInformedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Stay Informed";
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //  Fixed Item List
    itemList = [[NSArray alloc] initWithObjects:@"Sidra In The News",@"Press Release", @"Social Media Channels", nil];
    
    //Stay In Formed Table View
    
    tableViewStayInFormed = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - 65)];
    
    [tableViewStayInFormed setBackgroundColor:[UIColor clearColor]];
    [tableViewStayInFormed setDelegate:self];
    [tableViewStayInFormed setDataSource:self];
    [tableViewStayInFormed setScrollEnabled:YES];
    //deptListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableViewStayInFormed.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableViewStayInFormed];
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
    
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell";
    
    StayInformedTableCell *cell = (StayInformedTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // If there is no cell to reuse, create a new one
    if(cell == nil){
        
        cell = [[StayInformedTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.itemName.frame = CGRectMake(15, 15, 200, 20);
        cell.roundArrow.frame =CGRectMake(self.view.frame.size.width - 30, 15, 20, 20);
    }
    
    
    cell.itemName.text = [itemList objectAtIndex:indexPath.row];
    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableViewStayInFormed deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    

    if (indexPath.row==0) {
        
        NewsViewController *_newsView = [[NewsViewController alloc] initWithNibName:@"NewsViewController" bundle:nil];
        _newsView.shouldShowRightMenuButton = YES ;
        [self.navigationController pushViewController:_newsView animated:YES];
    }
    
    else if (indexPath.row == 1){
        
        PressRealeseViewController *_pressRealeseView = [[PressRealeseViewController alloc] initWithNibName:@"PressRealeseViewController" bundle:nil];
        _pressRealeseView.shouldShowRightMenuButton = YES ;
       [self.navigationController pushViewController:_pressRealeseView animated:YES];
        
    }
    
    else {
        
        MediaViewController *_socialMediaView = [[MediaViewController alloc] initWithNibName:@"MediaViewController" bundle:nil];
        _socialMediaView.shouldShowRightMenuButton = YES ;
        [self.navigationController pushViewController:_socialMediaView animated:YES];
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  CELL_HEIGHT;
}


@end
