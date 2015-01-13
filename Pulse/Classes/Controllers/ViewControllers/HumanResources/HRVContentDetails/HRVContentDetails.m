//
//  HRVContentDetails.m
//  Pulse
//
//  Created by Atomix on 7/3/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "HRVContentDetails.h"
#import "SKSTableView.h"
#import "SKSTableViewCell.h"
#import "HRL2Item.h"

@interface HRVContentDetails ()<UIScrollViewDelegate>

@end

@implementation HRVContentDetails {
    
 //   NSMutableArray *questionDemo; // demo
 //   NSMutableArray *answerDemo;   // demo
    
//---------------------------------------------
    
    NSMutableArray *HRDetailsList;
}

@synthesize hrl1Item;


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
    
    [self setNavigationCustomTitleView:@"Human Resources" with:hrl1Item.catName];
    
    HRDetailsList = [[NSMutableArray alloc] init];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // Table View Cell separator Show Problem Solved
    
    NSString *hRCatIdString = hrl1Item.itemID;
    
    [[ServerManager sharedManager] fetchHRDetails:@"" hrType:hRCatIdString scrollDirection:@"" completion:^(BOOL success, NSMutableArray *resultDataArray) {
        if (success) {
            XLog(@"%@",resultDataArray);
            HRDetailsList  =resultDataArray;
            self.tableView.SKSTableViewDelegate = self; // use here for Bug Solved
            [self.tableView reloadData];
            
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - parent view controller delegate (Navigation Title)

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
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
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



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([HRDetailsList count]==0) {
        return 0;
    }
    else 
    return [HRDetailsList count];
    
 
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    HRL2Item *item = (HRL2Item *)[HRDetailsList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.question;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font =  [UIFont systemFontOfSize:15];
    
    cell.expandable = YES;
    
    
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
   HRL2Item *item = (HRL2Item *)[HRDetailsList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.answer;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0];
    
    return cell;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HRL2Item *item = (HRL2Item *)[HRDetailsList objectAtIndex:indexPath.row];
    NSString *cellText = item.question;
    UIFont *cellFont =  [UIFont systemFontOfSize:15];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    
    CGSize labelSize = [self frameForText:cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
    
    
    return labelSize.height + 25;
}

- (UIView *)tableView:(SKSTableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footerView =[[UIView alloc] initWithFrame:CGRectZero];
    return footerView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HRL2Item *item = (HRL2Item *)[ HRDetailsList objectAtIndex:indexPath.row];
    NSString *cellTextSubRow = item.answer;
    UIFont *cellFontSubRow = [UIFont fontWithName:@"Helvetica" size:13.0];
    CGSize constraintSizeSubRow = CGSizeMake(280.0f, MAXFLOAT);
    
    CGSize labelSizeSubRow = [self frameForText:cellTextSubRow sizeWithFont:cellFontSubRow constrainedToSize:constraintSizeSubRow lineBreakMode:NSLineBreakByWordWrapping];
    
    
    return labelSizeSubRow.height + 20;
}

#pragma mark - Table View delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
    
    
}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"Section: %d, Row:%d, Subrow:%d", indexPath.section, indexPath.row, indexPath.subRow);
}

// height calculation

-(CGSize)frameForText:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode  {
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    //NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    
    paragraphStyle.lineBreakMode = lineBreakMode;
    
    NSDictionary * attributes = @{NSFontAttributeName:font,
                                  NSParagraphStyleAttributeName:paragraphStyle
                                  };
    
    
    CGRect textRect = [text boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes
                                         context:nil];
    
    //Contains both width & height ... Needed: The height
    return textRect.size;
}

#pragma mark - Actions Close All Expandable Cell

- (void)collapseSubrows
{
    [self.tableView collapseCurrentlyExpandedIndexPaths];
}

#pragma mark - Pull Refresh
- (void)pullDownToRefresh{
    
}

- (void)pullUpToRefresh{
    
}


@end
