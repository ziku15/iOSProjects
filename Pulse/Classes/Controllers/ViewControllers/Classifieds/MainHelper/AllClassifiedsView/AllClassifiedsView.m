//
//  AllClassifiedsView.m
//  Pulse
//
//  Created by Supran on 7/7/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "AllClassifiedsView.h"

@implementation AllClassifiedsView


@synthesize dropDownShowView, dataArray;
@synthesize delegate;
@synthesize classifiedFeedTableview,isBookmarkedTabSelected;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        dataArray = [[NSMutableArray alloc] init];
        initialFrame = frame;
        [self createCategoryView];
        [self createCategoryDropDownView];
        [self createFeedView];
        

    }
    return self;
}

#pragma mark - Feed View
-(void)createFeedView{
    [classifiedFeedTableview removeFromSuperview];
    classifiedFeedTableview = nil;
    [dataArray removeAllObjects];
    CGRect feedViewFrame;
    switch (isBookmarkedTabSelected) {
        case YES:
            dropDownShowView.hidden = YES;
            feedViewFrame = CGRectMake(0, 0, dropDownShowView.frame.size.width, self.frame.size.height-dropDownShowView.frame.size.height);
            break;
            
        default:
            dropDownShowView.hidden = NO;
            feedViewFrame = CGRectMake(dropDownShowView.frame.origin.x, dropDownShowView.frame.origin.y+dropDownShowView.frame.size.height, dropDownShowView.frame.size.width, self.frame.size.height-dropDownShowView.frame.size.height);
            break;
    }

    classifiedFeedTableview = [[UITableView alloc] initWithFrame:feedViewFrame];//CGRectMake(dropDownShowView.frame.origin.x, dropDownShowView.frame.origin.y+dropDownShowView.frame.size.height, dropDownShowView.frame.size.width, self.frame.size.height-dropDownShowView.frame.size.height)];
    [classifiedFeedTableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [classifiedFeedTableview setBackgroundColor:[UIColor clearColor]];
    [classifiedFeedTableview setScrollEnabled:NO];
    [classifiedFeedTableview setDelegate:self];
    [classifiedFeedTableview setDataSource:self];
    [classifiedFeedTableview setTag:10000];
    [self addSubview:classifiedFeedTableview];
    

    [self bringSubviewToFront:categoryTableView];
}

-(void)refreshView{
    [classifiedFeedTableview reloadData];

    CGFloat newHeight = dataArray.count * TABLE_CELL_HEIGHT;
    
    for (UIView *view in self.subviews) {
        if (view.tag == 10000) {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, newHeight)];
            
            CGRect mainViewFrame = self.frame;
            CGFloat previousHeight = initialFrame.size.height;
            CGFloat newHeight = view.frame.origin.y + view.frame.size.height;

            mainViewFrame.size.height = newHeight > previousHeight ? newHeight:previousHeight;
            [self setFrame:mainViewFrame];
            
            [self.delegate dynamicallyChangeViewSize:self];
        }
    }
}

#pragma mark - Cell Delete Button Action
-(IBAction)deleteAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag < dataArray.count ) {
        UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:DELETE_MESSAGE message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        alert.tag = btn.tag;
        [alert show];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        
       
        ClassifiedItem *dataModel = [dataArray objectAtIndex:alertView.tag];
        [[ServerManager sharedManager] deleteItem:dataModel.itemID type:DELETE_CLASSIFIED_TYPE completion:^(BOOL success){
            if (success) {
                [dataArray removeObjectAtIndex:alertView.tag];
                [self refreshView];
            }
        }];
        
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
    return TABLE_CELL_HEIGHT;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";//[NSString stringWithFormat:@"Cell%i", indexPath.row];
    
    if ([CommonHelperClass sharedConstants].classifiedTypeSelected == 1) {
        AllClassifiedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        cell = nil;
        if (cell == nil) {
            cell = [[AllClassifiedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];// with:dataModel] ;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        
        cell.delButton = nil;
        ClassifiedItem *dataModel = [dataArray objectAtIndex:indexPath.row];
        UILabel *titleLabel = [cell createTitleView:[NSString stringWithFormat:@"%@",dataModel.title]];
        UILabel *dateLabel = [cell createDateView:titleLabel with:[NSString stringWithFormat:@"%@",dataModel.createdDate]];
        UIView *postedview = [cell createPostedByView:dateLabel with:[NSString stringWithFormat:@"%@", dataModel.createdBy] with:dataModel.ownerInfo];
        [cell createDescriptionView:postedview with:[NSString stringWithFormat:@"%@", dataModel.a_description]];
        
        if (cell.delButton != nil) {
            [cell.delButton setTag:indexPath.row];
            [cell.delButton addTarget:self
                               action:@selector(deleteAction:)
                     forControlEvents:UIControlEventTouchUpInside];
        }
        
        return cell;
    }
    else{
        PostedByMeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        cell = nil;
        if (cell == nil) {

            cell = [[PostedByMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ];//with:dataModel] ;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];

        }
        

        ClassifiedItem *dataModel = [dataArray objectAtIndex:indexPath.row];
        
        UIImageView *stateImageView = [cell createStatusView:dataModel.isDraft];
        UILabel *titleLabel = [cell createTitleView:stateImageView with:[NSString stringWithFormat:@"%@",dataModel.title]];
        UILabel *dateLabel = [cell createDateView:titleLabel with:[NSString stringWithFormat:@"%@",dataModel.createdDate]];
        [cell createDescriptionView:dateLabel with:[NSString stringWithFormat:@"%@",dataModel.a_description]];
       
        [cell.delButton setTag:indexPath.row];
        [cell.delButton addTarget:self
                           action:@selector(deleteAction:)
                 forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self closeCategoryTableview];
    
    ClassifiedItem *dataModel = [dataArray objectAtIndex:indexPath.row];
    [self.delegate allClassifiedCellSelection:dataModel index:indexPath.row];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark - Category View
-(void)createCategoryView{
    //Create show view
    dropDownShowView = [[OffersAndPromotionsShowView alloc] initForClassified:CGRectMake(0, 0, self.frame.size.width, 50)];
    [dropDownShowView.selectButton addTarget:self
                                   action:@selector(dropDownAction:)
                         forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:dropDownShowView];
    [self populateDropDownList];
    
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

#pragma mark - Call Api Method

-(void)populateDropDownList{
    [[ServerManager sharedManager] fetchClassifiedCategories:^(BOOL success, NSMutableArray *resultDataArray) {
        
        if (success) {
//            Call Drop Down Value Api Here
//            [categoryTableView setDataArrayValueForAlbum:resultDataArray];

            [categoryTableView setDataArrayValueForMainClassified:resultDataArray];
        }
        else{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [[[UIAlertView alloc] initWithTitle:@"Server Error, Please go previous page and try again" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
//            });
        }
    }];
}



-(void)populateClassifiedFeed:(NSString*)lastElementID direction:(NSString*)direction{
    
    NSString *cat_id = [NSString stringWithFormat:@"%li",(long)dropDownShowView.showTextField.tag];
    NSString *type = [NSString stringWithFormat:@"%i", [CommonHelperClass sharedConstants].classifiedTypeSelected];
    //NSString *page_number = [NSString stringWithFormat:@"%i", 1];
    if ([type isEqual:@"0"]) {
        if ([direction isEqualToString:@"1"]) {
            //
            ClassifiedItem *dataModel = [dataArray objectAtIndex:dataArray.count-1];
            lastElementID = [NSString stringWithFormat:@"%@",dataModel.itemID];
            [[ServerManager sharedManager] fetchClassifieds:lastElementID type:type category:@"0" scrollDirection:direction completion:^(BOOL success, NSMutableArray *resultDataArray){
                
                [delegate updateDataLoading:NO];
                
                
                if (success) {
                    [dataArray addObjectsFromArray:resultDataArray];
                }
                else{
                    //[dataArray removeAllObjects];
                }
                [self refreshView];
            }];
            
        }else if([direction isEqualToString:@"0"]){
            //
            if (dataArray.count>0) {
                ClassifiedItem *dataModel = [dataArray objectAtIndex:0];
                lastElementID = [NSString stringWithFormat:@"%@",dataModel.itemID];
                [[ServerManager sharedManager] fetchClassifieds:lastElementID type:type category:@"0" scrollDirection:direction completion:^(BOOL success, NSMutableArray *resultDataArray){
                    [delegate updateDataLoading:NO];
                    if (success) {
                        [resultDataArray addObjectsFromArray:dataArray];
                        dataArray = resultDataArray;
                    }
                    else{
                        //[dataArray removeAllObjects];
                    }
                    
                }];
                [self refreshView];
            }else {
                [delegate updateDataLoading:NO];
                dataArray = nil;
            }
            
            
        }else{
            [[ServerManager sharedManager] fetchClassifieds:lastElementID type:type category:@"0" scrollDirection:direction completion:^(BOOL success, NSMutableArray *resultDataArray){
                XLog(@"---------");
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [delegate updateDataLoading:NO];
                });
                
                if (success) {
                    
                    
                    [dataArray removeAllObjects];
                    dataArray = [resultDataArray mutableCopy];
                    [self refreshView];
                }
                else{
                    
                    [dataArray removeAllObjects];
                    [self refreshView];
                }
                
            }];
        }
    }else{
        if ([direction isEqualToString:@"1"]) {
            //
            ClassifiedItem *dataModel = [dataArray objectAtIndex:dataArray.count-1];
            lastElementID = [NSString stringWithFormat:@"%@",dataModel.itemID];
            [[ServerManager sharedManager] fetchClassifieds:lastElementID type:type category:cat_id scrollDirection:direction completion:^(BOOL success, NSMutableArray *resultDataArray){
                
                [delegate updateDataLoading:NO];
                
                
                if (success) {
                    [dataArray addObjectsFromArray:resultDataArray];
                }
                else{
                    //[dataArray removeAllObjects];
                }
                [self refreshView];
            }];
            
        }else if([direction isEqualToString:@"0"]){
            //
            if (dataArray.count>0) {
                ClassifiedItem *dataModel = [dataArray objectAtIndex:0];
                lastElementID = [NSString stringWithFormat:@"%@",dataModel.itemID];
                [[ServerManager sharedManager] fetchClassifieds:lastElementID type:type category:cat_id scrollDirection:direction completion:^(BOOL success, NSMutableArray *resultDataArray){
                    [delegate updateDataLoading:NO];
                    if (success) {
                        [resultDataArray addObjectsFromArray:dataArray];
                        dataArray = resultDataArray;
                    }
                    else{
                        //[dataArray removeAllObjects];
                    }
                    
                }];
                [self refreshView];
            }else {
                [delegate updateDataLoading:NO];
                dataArray = nil;
            }
            
            
        }else{
            [[ServerManager sharedManager] fetchClassifieds:lastElementID type:type category:cat_id scrollDirection:direction completion:^(BOOL success, NSMutableArray *resultDataArray){
                XLog(@"---------");
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [delegate updateDataLoading:NO];
                });
                
                if (success) {
                    
                    
                    [dataArray removeAllObjects];
                    dataArray = [resultDataArray mutableCopy];
                    [self refreshView];
                }
                else{
                    
                    [dataArray removeAllObjects];
                    [self refreshView];
                }
                
            }];
        }
    }
    
}



#pragma mark - DropDown View

-(void)createCategoryDropDownView{
    
    categoryTableView= [[Categorytableview alloc] initMethodGeneral:CGRectMake(self.frame.origin.x, dropDownShowView.frame.origin.y + dropDownShowView.frame.size.height - 10, self.frame.size.width, 300) with:self];
    [self addSubview:categoryTableView];
    [categoryTableView setHidden:YES];

}

#pragma mark - Drop Down Delegate

-(void)categorySelect:(NSString *)categoryName withCatId:(NSInteger)cat_id{
    [self closeCategoryTableview];
    [dropDownShowView.showTextField setText:categoryName];
    [dropDownShowView.showTextField setTag:cat_id];
    
    
    //Call api by Category Select
    [self populateClassifiedFeed:@"" direction:@""];
    
    [self.delegate categorySelectedText:categoryName];
}

-(void)closeCategoryTableview{
    //If category tableview open then close it
    if (!categoryTableView.hidden) {
        [self dropDownAction:dropDownShowView.selectButton];
    }
}
@end
