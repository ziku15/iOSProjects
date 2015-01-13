 //
//  StaffTableView.m
//  InheritUiView
//
//  Created by MEHEDI HASAN on 7/6/14.
//  Copyright (c) 2014 MEHEDI.hasan. All rights reserved.
//

#import "StaffTableView.h"
#import "DeptTableCell.h"


#define SHOW_CELL_HEIGHT 190
#define STAFF_CELL_HEIGHT 100

@interface StaffTableView() <UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate> {
    NSMutableArray *staffListData;
    UITableView *tableViewStaffList;
    NSIndexPath *holdPreviousIndexPath; // use for collapse
    UILabel * noPostLabel;
}

@property (nonatomic, strong) NSMutableArray *selectedIndexPaths;

@end


@implementation StaffTableView


- (id)initWithFrame:(CGRect)frame withArray:(NSArray *)arrayData{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        staffListData  = [[NSMutableArray alloc] initWithArray:arrayData];
        
        //XLog(@"\nStaff List Data: %@\n",staffListData);
        //XLog(@"total count Array: %d", arrayData.count);
        //----- Add Table View -----
        
        tableViewStaffList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [tableViewStaffList setBackgroundColor:[UIColor clearColor]];
        [tableViewStaffList setDelegate:self];
        [tableViewStaffList setDataSource:self];
        [tableViewStaffList setScrollEnabled:YES];
        // deptListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableViewStaffList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:tableViewStaffList];

        holdPreviousIndexPath = nil; // initialize
        
        
        //for all saved contacts
        
        noPostLabel = [[UILabel alloc] initWithFrame:CGRectMake(00, frame.size.height/4, frame.size.width, 200)];
        [noPostLabel setText:@"List currently empty. You can save contacts by tapping the star next to their names"];
        noPostLabel.numberOfLines = 2;
        [noPostLabel setFont:[UIFont boldSystemFontOfSize:14.5f]];
        [noPostLabel setTextAlignment:NSTextAlignmentCenter];
        noPostLabel.alpha = 0.0f;
        [self addSubview:noPostLabel];
    }
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)layoutSubviews {
    [super layoutSubviews];
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
    
    return [staffListData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   static NSString *cellIdentifier = @"Cell";
        
   DeptTableCell *cell = (DeptTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        // If there is no cell to reuse, create a new one
    if(cell == nil)
        {
      cell = [[DeptTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
            //--- Visible Frame Section
            
            cell.userName.frame = CGRectMake(15, 17, 200, 15);
            cell.positionTitle.frame = CGRectMake(cell.userName.frame.origin.x, cell.userName.frame.origin.y + 25, cell.userName.frame.size.width, cell.userName.frame.size.height);
            cell.userDepartmentName.frame = CGRectMake(cell.positionTitle.frame.origin.x, cell.positionTitle.frame.origin.y + 25, cell.positionTitle.frame.size.width, cell.positionTitle.frame.size.height);
            
            cell.favourateBtn.frame = CGRectMake(self.frame.size.width - 60, cell.userName.frame.origin.y/3 + 18, 50, 50);
            
            //--- Email Btn
           // cell.emailBtn = [XIBUnderLinedButton underlinedButton];
            [cell.emailBtn addTarget:self
                              action:@selector(emailBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            
            //--- Office Btn
            // cell.officeBtn = [XIBUnderLinedButton underlinedButton];
            [cell.officeBtn addTarget:self
                               action:@selector(officeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            
            //---  Mobile btn
             //cell.mobileBtn = [XIBUnderLinedButton underlinedButton];
            [cell.mobileBtn addTarget:self
                               action:@selector(mobileBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            
            //--- favourate Button Action
            [cell.favourateBtn addTarget:self
                                  action:@selector(favoriteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.emailBtn.frame  = CGRectMake(0, 0 ,0, 0);
            cell.officeBtn.frame = CGRectMake(0, 0 ,0, 0);
            cell.mobileBtn.frame = CGRectMake(0, 0 ,0, 0);
            
            
    }
    
    
    // Tag Number Assign
    
    cell.mobileBtn.tag    = indexPath.row;
    cell.emailBtn.tag     = indexPath.row;
    cell.officeBtn.tag    = indexPath.row;
    cell.favourateBtn.tag = indexPath.row;
    
    
    // Show Data in cell
    
    StaffItem *item = (StaffItem *)[staffListData objectAtIndex:indexPath.row];
    
    cell.userName.text = [NSString stringWithFormat:@"%@",item.name];//item.name;
    cell.positionTitle.text = [NSString stringWithFormat:@"%@",item.designation];//item.designation;
    cell.userDepartmentName.text = [NSString stringWithFormat:@"%@",item.departmentName];//item.departmentName;
    
    NSString *zzzEmail = [NSString stringWithFormat:@"%@",item.email];
    NSString *zzzOffice = [NSString stringWithFormat:@"%@",item.office];
    NSString *zzzMobile = [NSString stringWithFormat:@"%@",item.mobile];
    
    
    [cell.emailBtn setTitle:[NSString stringWithFormat:@"%@",([zzzEmail isEqualToString:@""]?@"unavailable":zzzEmail)]
                   forState:UIControlStateNormal];
    
    [cell.officeBtn setTitle:[NSString stringWithFormat:@"%@",([zzzOffice isEqualToString:@""]?@"unavailable":zzzOffice)]
                    forState:UIControlStateNormal];
    
    [cell.mobileBtn setTitle:[NSString stringWithFormat:@"%@",([zzzMobile isEqualToString:@""]?@"unavailable":zzzMobile)]
                    forState:UIControlStateNormal];
    
    //----
    
    [cell.favourateBtn setImage:(item.isSaved?[UIImage imageNamed:@"star_icon"]:[UIImage imageNamed:@"star_gray_icon"]) forState:UIControlStateNormal];
    


    // Table View Expand Yes ? NO
    
    BOOL isSelected = [self.selectedIndexPaths containsObject:indexPath];
    
    if (isSelected==1) {
        cell.highlightedgrayBG.frame = CGRectMake(0, 70+30, self.frame.size.width, 90);
        cell.email.frame = CGRectMake(15, 80+30, 50, 15);
        cell.office.frame = CGRectMake(cell.email.frame.origin.x, cell.email.frame.origin.y + 25, cell.email.frame.size.width , cell.email.frame.size.height);
        cell.mobile.frame = CGRectMake(cell.email.frame.origin.x, cell.email.frame.origin.y + 50, cell.email.frame.size.width +5, cell.email.frame.size.height);
        cell.emailBtn.frame =  CGRectMake( 80, cell.email.frame.origin.y , 220, cell.email.frame.size.height);
        cell.officeBtn.frame = CGRectMake( 80, cell.office.frame.origin.y , 220, cell.office.frame.size.height);
        cell.mobileBtn.frame = CGRectMake( 80, cell.mobile.frame.origin.y , 220, cell.mobile.frame.size.height);
    }
    
    else if (isSelected==0) {
        cell.highlightedgrayBG.frame = CGRectMake(0, 0, 0, 0);
        cell.email.frame     = CGRectMake(0, 0, 0, 0);
        cell.office.frame    = CGRectMake(0, 0, 0 ,0);
        cell.mobile.frame    = CGRectMake(0, 0, 0, 0);
        cell.emailBtn.frame  = CGRectMake(0, 0 ,0, 0);
        cell.officeBtn.frame = CGRectMake(0, 0 ,0, 0);
        cell.mobileBtn.frame = CGRectMake(0, 0 ,0, 0);
    }
    
    cell.emailBtn.contentMode=UIViewContentModeRedraw;
     cell.officeBtn.contentMode=UIViewContentModeRedraw;
     cell.mobileBtn.contentMode=UIViewContentModeRedraw;
    //---- END
    
    return cell;
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableViewStaffList deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    [self addOrRemoveSelectedIndexPath:indexPath];

  
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    BOOL isSelected = [self.selectedIndexPaths containsObject:indexPath];
        
    CGFloat maxHeight = SHOW_CELL_HEIGHT;
    CGFloat minHeight = STAFF_CELL_HEIGHT;
    CGFloat constrainHeight = isSelected?maxHeight:minHeight;
        
    return constrainHeight;
        
        
}

- (void)addOrRemoveSelectedIndexPath:(NSIndexPath *)indexPath
{
    
    if (!self.selectedIndexPaths) {
        self.selectedIndexPaths = [NSMutableArray new];
    }
    
    if (holdPreviousIndexPath == nil) {
        holdPreviousIndexPath = indexPath;
    }
    
    else if (![holdPreviousIndexPath isEqual:indexPath]) {
        
        [self.selectedIndexPaths removeObject:holdPreviousIndexPath];
        [tableViewStaffList reloadRowsAtIndexPaths:@[holdPreviousIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
        holdPreviousIndexPath = indexPath;
    }
    
    // selected cell expand/collapse animation As usual
    BOOL containsIndexPath = [self.selectedIndexPaths containsObject:indexPath];
    
    if (containsIndexPath) {
        [self.selectedIndexPaths removeObject:indexPath];
    }else{
        [self.selectedIndexPaths addObject:indexPath];
    }
    
    [tableViewStaffList reloadRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationFade];

    // Table cell visible Area
    CGRect cellFrame = [tableViewStaffList rectForRowAtIndexPath:indexPath];
    if (cellFrame.origin.y<tableViewStaffList.contentOffset.y) { // the row is above visible rect
        [tableViewStaffList scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    else if(cellFrame.origin.y+cellFrame.size.height>tableViewStaffList.contentOffset.y+tableViewStaffList.frame.size.height-tableViewStaffList.contentInset.top-tableViewStaffList.contentInset.bottom){ // the row is below visible rect

        [tableViewStaffList scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.3];

    }
    
    
 
}


#pragma mark -  Button Action


- (void)emailBtnAction:(UIButton *)sender{
    
    StaffItem *item = (StaffItem *)[staffListData objectAtIndex:sender.tag];
    NSString *mailAddress = [NSString stringWithFormat:@"%@", item.email];
    [self sendMail:mailAddress];
}

- (void)officeBtnAction:(UIButton *)sender{
    
    StaffItem *item = (StaffItem *)[staffListData objectAtIndex:sender.tag];
    NSString *OfficeCall = [NSString stringWithFormat:@"%@", item.office];
    [self phoneCall:OfficeCall];
    
    
}


- (void)mobileBtnAction:(UIButton *)sender{
    
    StaffItem *item = (StaffItem *)[staffListData objectAtIndex:sender.tag];
    NSString *mobileCall = [NSString stringWithFormat:@"%@", item.mobile];
    [self phoneCall:mobileCall];
}


- (void)favoriteBtnAction:(UIButton *)sender{
    
  //  XLog(@"Save Contact Favourate Button tag: %ld", (long)sender.tag);
    
    UIButton *btn = (UIButton*)sender;
    __block StaffItem *item = (StaffItem *)[staffListData objectAtIndex:btn.tag];
    [[ServerManager sharedManager] favoriteStaff:item.itemID isBookmark:item.isSaved?@"0":@"1" completion:^(BOOL success) {
        if (success) {
            item.isSaved = !item.isSaved;
            [btn setImage:(item.isSaved?[UIImage imageNamed:@"star_icon"]:[UIImage imageNamed:@"star_gray_icon"]) forState:UIControlStateNormal];
            
            if (item.isSaved) {
               // [self saveContactToLocalDirectory:sender.tag];  // save favourate Contact To Local database
                [self saveContactAlertMsg:item.name]; // new Added
            }
            else {
              //  [self deleteContactToLocalDirectory:sender.tag];  // delete favourate Contact from Local database
                [self deleteContactAlertMsg:item.name];// new Added
            }
            
            [staffListData replaceObjectAtIndex:btn.tag withObject:item];
            [self.delegate updatedUIArrayDataForTableView:item];
            
            if (self.isSavedContactViewMode) {
                [staffListData removeObjectAtIndex:btn.tag];
            }
            
            //[tableViewStaffList reloadData];
            [self reloadDataTable];
        }
    }];
    
    
    //[self.delegate updatedUIArrayDataForTableView:item];  // send item data to change department List UI
    
    //[tableViewStaffList reloadData]; // off 22.08.2014 for some UI issue
}

//phone call
-(void)phoneCall:(NSString*)phNo{
    
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView  *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}

//send Mail
-(void)sendMail:(NSString *)mailAddress {
    
    if ([MFMailComposeViewController canSendMail]) {
        
        NSArray *toRecipents = [NSArray arrayWithObject:mailAddress];
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        //[self presentViewController:mc animated:YES completion:NULL];
        
        [[AppManager sharedManager ] presentModelViewController:mc];
    }
    
    else {
        UIAlertView  *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Device is not configured to send mail" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
    
}

#pragma mark - Mail Delegate Methods

// -------------------------------------------------------------------------------
//	mailComposeController:didFinishWithResult:
//  Dismisses the email composition interface when users tap Cancel or Send.
//  Proceeds to update the message field with the result of the operation.
// -------------------------------------------------------------------------------
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			XLog(@"Result: Mail sending canceled") ;
			break;
		case MFMailComposeResultSaved:
			XLog(@"Result: Mail saved") ;
			break;
		case MFMailComposeResultSent:
			XLog(@"Result: Mail sent") ;
			break;
		case MFMailComposeResultFailed:
			XLog(@"Result: Mail sending failed") ;
			break;
		default:
			XLog( @"Result: Mail not sent");
			break;
	}
    
	//[self dismissViewControllerAnimated:YES completion:NULL];
    
    [[AppManager sharedManager]dismissModelViewController];
}


-(void)saveContactToLocalDirectory:(int)index {
    
    StaffItem *item = (StaffItem *)[staffListData objectAtIndex:index];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:item];
    
    //---- Array to save conatct --------
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *SaveContactToLocalDatabase= [defaults objectForKey:kSavedContact];
    NSMutableArray *CopySaveContact = [[NSMutableArray alloc] initWithArray:SaveContactToLocalDatabase];
    
    [CopySaveContact addObject:myEncodedObject];
    [defaults setObject:CopySaveContact forKey:kSavedContact];
    
    [defaults synchronize];
    
    //--------------- end ----------------------------------
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Contact has been added to 'Saved Contacts' section'" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    });

}


-(void)deleteContactToLocalDirectory:(int) index {
    
    StaffItem *dataArrayItem = (StaffItem *)[staffListData objectAtIndex:index];
    //  XLog(@"Staff item ID : %@", dataArrayItem.itemID);
    
    // get all Save contact from array
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *SaveContactArray= [defaults objectForKey:kSavedContact];
    NSMutableArray *CopySaveContact = [[NSMutableArray alloc] initWithArray:SaveContactArray];
    
    [defaults synchronize];
    
    
    for (int i=0; i<CopySaveContact.count; i++) {
        
        NSData *decodeObject = [SaveContactArray objectAtIndex:i];
        StaffItem *item = [NSKeyedUnarchiver unarchiveObjectWithData:decodeObject];
        
        if ([dataArrayItem.itemID integerValue] == [item.itemID integerValue]) {
            
            [CopySaveContact removeObjectAtIndex:i];
            [defaults setObject:CopySaveContact forKey:kSavedContact];
            [defaults synchronize];
            
            break;
        }
        
        
    }
    
    //---------------------- End ----------------------------
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Contact has been removed from 'Saved Contacts' section'" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
        
    });

}


- (void)refreshArrayData: (NSMutableArray *)newArrayData {

    //XLog(@"total count Array: %d", newArrayData.count);
    
    if (newArrayData.count<=0) {
        /*
        CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/10.0,
                                  [UIScreen mainScreen].bounds.size.height/4.0 , 220, 105);
        NSString *msg = @"List currently empty. You can save contacts by tapping the star next to their names";
        AlertPopView *alertMsg = [[AlertPopView alloc] initWithFrame:frame alertMsg:msg withDelay:1.5];
        [[UIApplication sharedApplication].keyWindow addSubview:alertMsg];
        alertMsg = nil;
         */
    }
    staffListData = newArrayData;
    [self reloadDataTable];
    
}

-(void) reloadDataTable{
    
    if (staffListData.count<=0) {
        noPostLabel.alpha = 1.0f;
    }else
        noPostLabel.alpha = 0.0f;
    [tableViewStaffList reloadData];
}


-(void)saveContactAlertMsg:(NSString *)name {
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Contact has been added to 'Saved Contacts' section'" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        alert = nil;
        CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/10.0, [UIScreen mainScreen].bounds.size.height/6.0 , 200, 50);
        NSString *msg = [NSString stringWithFormat:@"%@ has been been added to 'Saved Contacts'",name];
        AlertPopView *alertMsg = [[AlertPopView alloc] initWithFrame:frame alertMsg:msg];
        [self addSubview:alertMsg];
        alertMsg = nil;
    });
}

-(void)deleteContactAlertMsg:(NSString *)name {
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Contact has been removed from 'Saved Contacts' section'" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        alert = nil;
        CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/10.0, [UIScreen mainScreen].bounds.size.height/6.0 , 200, 50);
        NSString *msg = [NSString stringWithFormat:@"%@ has been been removed from 'Saved Contacts'",name];
        AlertPopView *alertMsg = [[AlertPopView alloc] initWithFrame:frame alertMsg:msg];
        [self addSubview:alertMsg];
        alertMsg = nil;
    });
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.delegate scrollViewScroll:scrollView];
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.delegate scrollViewDidEndDecelerating:scrollView];
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
        [self.delegate scrollViewDidEndDecelerating:scrollView];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

}

@end
