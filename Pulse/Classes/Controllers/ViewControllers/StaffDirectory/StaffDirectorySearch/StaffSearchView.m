//
//  StaffSearchView.m
//  Pulse
//
//  Created by xibic on 7/7/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "StaffSearchView.h"
#import "StaffTableView.h"

#define CANCEL_BTN_FRAME CGRectMake(0,5,44,44)

@interface StaffSearchView()<UISearchBarDelegate>{
    UISearchBar *xSearchBar;
    UIButton *cancleButton;
    NSString *searchString;
    StaffTableView *staffTable;
    UILabel *noResultsLabel;
    UILabel *resultsHeaderLabel ;
}

@end

@implementation StaffSearchView


@synthesize searchDept,delegate,savedContact;

- (id)initWithPlaceholderText:(NSString*)ptext{
    self = [super init];
    if (self) {
        
        CGRect frame = CGRectMake(0, SCREEN_SIZE.height-107, SCREEN_SIZE.width, SCREEN_SIZE.height);
        
        self.frame = frame;
        
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        [self addSearchBar:ptext];
        
        resultsHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, xSearchBar.frame.origin.y+xSearchBar.frame.size.height-5, self.frame.size.width, 50)];
        [self addSubview:resultsHeaderLabel];
     //   resultsHeaderLabel.hidden=no
        
        //[self addCancelButton];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withPlaceholderText:(NSString*)ptext{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        xSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //xSearchBar.searchBarStyle = UISearchBarStyleMinimal;
        [xSearchBar setBackgroundImage:[UIImage new]];
        xSearchBar.barTintColor = [UIColor clearColor];
        xSearchBar.placeholder = ptext;
        xSearchBar.delegate = self;
        [self addSubview:xSearchBar];
        
    
        
        
    }
    return self;
}



#pragma mark - Staff result header
- (void)addStaffSearchResultHeaderView:(NSString*)labelText arraycount:(int)count{
    
    resultsHeaderLabel.backgroundColor=[UIColor whiteColor];
    resultsHeaderLabel.text=[NSString stringWithFormat:@"%lu  result matching\n \"%@\"",(unsigned long)count,labelText];
    resultsHeaderLabel.textAlignment=NSTextAlignmentCenter;
    resultsHeaderLabel.font=[UIFont boldSystemFontOfSize:18.0f];
    resultsHeaderLabel.numberOfLines=2;
    
   
}



#pragma mark - Cancel Button

- (void)addCancelButton{
    //Create Cancle Button
    cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [cancleButton setBackgroundColor:[UIColor blackColor]];
    [cancleButton setImage:[UIImage imageNamed:@"cross_btn.png"] forState:UIControlStateNormal];
    [cancleButton setFrame:CGRectMake(self.frame.size.width - 34, 2, 34, 34)];
    [cancleButton addTarget:self
                     action:@selector(cancelButtonAction)
           forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancleButton];
    cancleButton.alpha = 0.0f;
}

- (void)cancelButtonAction{
    if ([self.searchDept isEqualToString:@"-1"]) {//Search within saved contact
        [self.delegate searchViewRemoved];
    }
    [xSearchBar resignFirstResponder];
    [self slideDownView];
    
}


#pragma mark - Search Bar
- (void)addSearchBar:(NSString*)ptext{
    xSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, -9, self.frame.size.width, 55)];
    //xSearchBar.searchBarStyle = UISearchBarStyleMinimal;
    int highlvalue = 48;
    int empty=highlvalue-ptext.length;
    if(empty>0){
        for (int i=0; i<empty; i++) {
            ptext=[ptext stringByAppendingString:@" "];
        }
        
    }
    
    [xSearchBar setBackgroundImage:[UIImage new]];
    xSearchBar.barTintColor = [UIColor clearColor];
    xSearchBar.placeholder = ptext;
    xSearchBar.delegate = self;
    resultsHeaderLabel.hidden = YES;
    //Hide text clear button
    for (UIView *subview in xSearchBar.subviews){
        if ([subview conformsToProtocol:@protocol(UITextInputTraits)]){
            [(UITextField *)subview setClearButtonMode:UITextFieldViewModeWhileEditing];
        }
    }
    
    
    [self addSubview:xSearchBar];
}

- (void)updatePlaceHolderText:(NSString *)placeHolderTxt{
    int highlvalue = 48;
    int empty=highlvalue - placeHolderTxt.length;
    if(empty>0){
        for (int i=0; i<empty; i++) {
            placeHolderTxt=[placeHolderTxt stringByAppendingString:@" "];
        }
        
    }
    xSearchBar.placeholder = placeHolderTxt;
}

#pragma mark - Search Delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self slideUpView];
    [self.delegate showingSearcViewOnScreen];
    
    
    /*
    [searchBar setShowsCancelButton:YES animated:YES];
    
    for (UIView* subView in [[xSearchBar.subviews objectAtIndex:0] subviews]) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton* cancelBtn = (UIButton*)subView;
            CGRect frame = cancelBtn.frame;
            frame.size.height = 22.0f;
            frame.origin.y = 16.0f;
            cancelBtn.frame = frame;
            XLog(@"Frame size: %f -- %f -- %f -- %f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
            cancelBtn.backgroundColor = [UIColor sidraFlatTurquoiseColor];
            [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:11.0f]];
            cancelBtn.layer.cornerRadius = 3.0f;
        }
    }
    */
    
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    //[self slideDownView];
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    searchString = [[NSString stringWithFormat:@"%@",searchBar.text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

/*
 
 - (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
 return YES;
 }
 
 */

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.text = @"";
    //[searchBar setShowsCancelButton:NO animated:YES];
    [xSearchBar resignFirstResponder];
    [self slideDownView];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //searchBar.text = @"";
    //[searchBar setShowsCancelButton:YES animated:YES];
    [xSearchBar resignFirstResponder];
    XLog(@"Search Text: %@",searchString);
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedString = [searchString stringByTrimmingCharactersInSet:charSet];
    if ([trimmedString isEqualToString:@""]) {
        // it's empty or contains only white spaces
          [self slideDownView];
           //[self.delegate searchViewRemoved];
    }
    else{
    
    
    if ([self.searchDept isEqualToString:@"-1"]) {//unsed Function -1
        [self searchTableView:searchString];
    }else{
        [[ServerManager sharedManager] fetchStaffSearchResults:searchString deptID:self.searchDept completion:^(BOOL success, NSMutableArray *resultDataArray) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([self.savedContact isEqualToString:@"NO"]) {
                    [self showSearchResultsView:resultDataArray];
                }
                else if([self.savedContact isEqualToString:@"YES"]){
                    [self SavedContactResult:resultDataArray];
                }
                
                
            });
        }];
    }
    }
    
}

#pragma mark - Search Result View
- (void)showSearchResultsView:(NSMutableArray *)resultDataArray{
    [staffTable removeFromSuperview];
    [noResultsLabel removeFromSuperview];
    staffTable = nil;
    noResultsLabel = nil;
    
    //XLog(@"%@",resultDataArray);
    
    if ([resultDataArray count]!=0) {
        staffTable = [[StaffTableView alloc] initWithFrame:CGRectMake(0, resultsHeaderLabel.frame.origin.y+resultsHeaderLabel.frame.size.height+3, self.frame.size.width, self.frame.size.height-100-(resultsHeaderLabel.frame.origin.y+resultsHeaderLabel.frame.size.height+3)) withArray:resultDataArray];
        [self addSubview:staffTable];
        [self addStaffSearchResultHeaderView:xSearchBar.text arraycount:(int)resultDataArray.count];
        resultsHeaderLabel.hidden=NO;
    }else{
        noResultsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height/3.0f, SCREEN_SIZE.width -10.0f, 50.0f)];
        noResultsLabel.font = [UIFont systemFontOfSize:15.0f];
        noResultsLabel.textColor = [UIColor sidraFlatDarkGrayColor];
        noResultsLabel.textAlignment = NSTextAlignmentCenter;
        noResultsLabel.numberOfLines = 2;
        noResultsLabel.text = [NSString stringWithFormat:@"No contacts matching the keyword were found."];
        [self addSubview:noResultsLabel];
        resultsHeaderLabel.hidden=YES;
    }
}

#pragma mark - Search Saved Contact
- (void) searchTableView:(NSString *)searchKey{
    
    NSString *searchText = searchKey;
    NSMutableArray *searchArray = [[NSMutableArray alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *SaveContactArray= [defaults objectForKey:kSavedContact];
    //NSData *decodeObject = [SaveContactArray objectAtIndex:indexPath.row];
    //StaffItem *item = [NSKeyedUnarchiver unarchiveObjectWithData:decodeObject];
    NSMutableArray *searchArraySource = [NSMutableArray arrayWithArray:SaveContactArray];
    
    NSInteger TotalNoOfRecords=[searchArraySource count];
    for (int i=0;i<TotalNoOfRecords;i++){
        NSData *decodeObject = [searchArraySource objectAtIndex:i];
        StaffItem *item = [NSKeyedUnarchiver unarchiveObjectWithData:decodeObject];
        
        [searchArray addObject:item];
    }
    
    NSMutableArray *searchResultArray = [[NSMutableArray alloc] init];
    
    for (StaffItem *sTemp in searchArray){
        
        NSRange titleResultsRange = [sTemp.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
        
        if (titleResultsRange.length > 0)
        {
            [searchResultArray addObject:sTemp];
        }
    }
    
    [self showSearchResultsView:searchResultArray];
    
    searchArray = nil;
}

#pragma mark - Presentation
- (void)slideUpView{
    self.backgroundColor = [UIColor sidraFlatLightGrayColor];
    CGRect viewFrame = self.frame;
    viewFrame.origin.y = 0;
    CGRect searchViewFrame = xSearchBar.frame;
    searchViewFrame.size.width = self.frame.size.width;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = viewFrame;
        xSearchBar.frame = searchViewFrame;
    } completion:^(BOOL finished) {
        cancleButton.alpha = 1.0f;
    }];
}
- (void)slideDownView{
    self.backgroundColor = [UIColor clearColor];
    resultsHeaderLabel.hidden = YES;
    [xSearchBar setShowsCancelButton:NO animated:YES];
    xSearchBar.text = @"";
    CGRect viewFrame = self.frame;
    viewFrame.origin.y = SCREEN_SIZE.height-107;
    CGRect searchViewFrame = xSearchBar.frame;
    searchViewFrame.size.width = self.frame.size.width;
    [UIView animateWithDuration:0.4 animations:^{
        self.frame = viewFrame;
        xSearchBar.frame = searchViewFrame;
    } completion:^(BOOL finished) {
        cancleButton.alpha = 0.0f;
        [staffTable removeFromSuperview];
        [noResultsLabel removeFromSuperview];
        staffTable = nil;
        noResultsLabel = nil;
    }];
}

#pragma mark -
#pragma mark - Hide Keyboard on BG Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //[self slideDownView];
    [self endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


#pragma mark-
#pragma mark - Saved Contact Result

-(void)SavedContactResult:(NSMutableArray*)resultdata {
    
    NSMutableArray *savedContactDataArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<resultdata.count; i++) {
        
        StaffItem *item = (StaffItem *)[resultdata objectAtIndex:i];
        
        if (item.isSaved == YES) {
            
            [savedContactDataArray addObject:item];
        }
        
    }
    
   [self showSearchResultsView:savedContactDataArray];
    
}
@end
