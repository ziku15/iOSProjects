//
//  EventsViewController.m
//  Pulse
//
//  Created by xibic on 6/11/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "EventsViewController.h"


static NSInteger dropDown_Row_index=0;
@interface EventsViewController (){
    EventsTabbarView *tabView;
    OffersAndPromotionsShowView *monthShowView;
    UITableView *eventsTableView;
    NSMutableArray *dataArray;
    
    Categorytableview *categoryTableView;
    EventsDetailsViewController *eventDetailsViewController;
    
    UILabel *noEventsLabel,*noPostLabel;
}

@end

@implementation EventsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dataArray = [[NSMutableArray alloc] init];
        eventDetailsViewController = nil;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.view setBackgroundColor:[UIColor sidraFlatLightGrayColor]];
    //Create tab panel
    
    SCROLL_CONSIDER_HEIGHT = 00;
    
    
    noPostLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f,
                                                              self.eventsScrollview.frame.size.height/3.0f,
                                                              self.eventsScrollview.frame.size.width-20.0f, 100.0f)];
    [noPostLabel setTextAlignment:NSTextAlignmentCenter];
    [noPostLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [noPostLabel setNumberOfLines:0];
    [noPostLabel setTextColor:[UIColor sidraFlatDarkGrayColor]];
    [noPostLabel setFont:[UIFont systemFontOfSize:20.0f]];
    [noPostLabel setBackgroundColor:[UIColor clearColor]];
    
    [noPostLabel setText:NO_DATA_MESSAGE];
    [self.eventsScrollview addSubview:noPostLabel];
    noPostLabel.alpha = 0.0f;
    [self.eventsScrollview sendSubviewToBack:noPostLabel];
    
    
    
    tabView = [[EventsTabbarView alloc] initWithFrame:CGRectMake(0, 0, 320, 50) with:self];
    [tabView setBackgroundColor:[UIColor whiteColor]];
    [self.eventsScrollview addSubview:tabView];
    
    
    //Create show view
    monthShowView = [[OffersAndPromotionsShowView alloc] initWithFrame:CGRectMake(tabView.frame.origin.x, tabView.frame.origin.y + tabView.frame.size.height, tabView.frame.size.width, 50)];
    [monthShowView.selectButton addTarget:self
                                      action:@selector(dropDownAction:)
                            forControlEvents:UIControlEventTouchUpInside];
    [self.eventsScrollview addSubview:monthShowView];
    

    
    //Create Feed Table view
    [self createEventsFeedView];
    

    //Create Drop Down View
    [self createCategoryDropDownView];
    
    //Call initialize data entry api
    [self callApiDropDownValue];
    
    dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
    dispatch_async(backgroundQueue, ^{
        //Clear bubble notification = 3 == Events type
        [[ServerManager sharedManager] updateBubbleNotificationStatus:@"3" completion:^(BOOL success) {
            if (success) {
            }
        }];
    });
    
    
}
/*
-(void)viewWillAppear:(BOOL)animated{

    if (eventDetailsViewController != nil) {

        noPostLabel.alpha = 0.0f;
        
        [self createEventsFeedView];
        
        
        NSLog(@"drop down index  %ld",(long)dropDown_Row_index);
        
        
        //[self callApiDropDownValue];
        [self callApiDropDownValue_After_Details ];
        
    }
}
*/
-(void)viewWillAppear:(BOOL)animated{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [loadingView dismisssView];
    });
    if (eventDetailsViewController != nil) {
        
        noPostLabel.alpha = 0.0f;
        
         NSLog(@"drop down index  %ld",(long)categoryTableView.categroyDataArray.count);
        
        [self createEventsFeedView];
        [self callApiDropDownValue_After_Details];
        
        
       
        
        /*for (int i=0; categoryTableView.categroyDataArray.count; i++) {
            if(i==dropDown_Row_index){
                CategoryItem *item = (CategoryItem*)[categoryTableView.categroyDataArray objectAtIndex:i];
                [self createEventsFeedView];
                [self callApiDropDownValue_After_Details];
              
               // [self categorySelect:item.cat_name withCatId:i];
                
            }
            
            
        }*/
    }
}




-(void)callApiDropDownValue{
    
    
    NSMutableArray *dropDownArray = [self getCategoryDateValue:[self returnType] == 3 ? NO : YES];
    
    //Call Drop Down Value Api Here
    [categoryTableView setDataArrayValueForEvent:dropDownArray];//] currentMonth:[currentMonth intValue]];
    
    
    //Find the selected event type (tabbar button)
    // [categoryTableView defineDataForEventByEventStuts:[self returnType]];
    
}


-(void)callApiDropDownValue_After_Details{

    
    NSMutableArray *dropDownArray = [[NSMutableArray alloc]init];

    dropDownArray=[categoryTableView.categroyDataArray mutableCopy];

    //Call Drop Down Value Api Here
    [categoryTableView setDataArrayValueForEvent_After_Details:dropDownArray index:(int)dropDown_Row_index];//] currentMonth:[currentMonth intValue]];
   

    //Find the selected event type (tabbar button)
   // [categoryTableView defineDataForEventByEventStuts:[self returnType]];
    
}

-(NSMutableArray *)getCategoryDateValue:(BOOL)isIncrement{

    //-------- get date from device
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
    
    NSDate *today = [cal dateFromComponents:components];
    
    
    
    int count = 0;
    NSMutableArray *dropDownArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 6; i ++) {
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        [dateComponents setMonth:count];
        
        NSDate *newDate = [cal dateByAddingComponents:dateComponents toDate:today options:0];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        NSString *dateString = [dateFormatter stringFromDate:newDate];
        
        
        if (isIncrement)
            count++;
        else
            count--;
         
        NSString *dateValue = [NSString stringWithFormat:@"%@-%@", [[CommonHelperClass sharedConstants] getRemoteYear:dateString],[[CommonHelperClass sharedConstants] getRemoteMonth:dateString]];
        
        
            CategoryItem *item = [[CategoryItem alloc] init];
             item.cat_id = [NSString stringWithFormat:@"%@", [[CommonHelperClass sharedConstants] getRemoteMonth:dateString]];
            item.date_value = dateValue;
            item.cat_name = [[CommonHelperClass sharedConstants] getRemoteMonthYear:dateValue];
            [dropDownArray addObject:item];
        
     
        
        
    }

    return dropDownArray;
}

-(NSDate *)getDateFromDateString :(NSString *)dateString {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
      [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

-(NSMutableArray *)getCategoryDateValue_After_Details:(BOOL)isIncrement{
    
    //-------- get date from device
    NSCalendar *cal = [NSCalendar currentCalendar];
    
 
    NSDateComponents *components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
    
    NSDate *today2 = [cal dateFromComponents:components];

    NSDate *today = [self getDateFromDateString:eventDetailsViewController.detailsItem.startDate];
    
 
    
    int count = 0;
    NSMutableArray *dropDownArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 6; i ++) {
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        [dateComponents setMonth:count];
        
        NSDate *newDate = [cal dateByAddingComponents:dateComponents toDate:today options:0];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        NSString *dateString = [dateFormatter stringFromDate:newDate];
        
        
        if (isIncrement)
            count++;
        else
            count--;
        
        NSString *dateValue = [NSString stringWithFormat:@"%@-%@", [[CommonHelperClass sharedConstants] getRemoteYear:dateString],[[CommonHelperClass sharedConstants] getRemoteMonth:dateString]];
        
        
        CategoryItem *item = [[CategoryItem alloc] init];
        
     
        item.cat_id = [NSString stringWithFormat:@"%@", [[CommonHelperClass sharedConstants] getRemoteMonth:dateString]];
        item.date_value = dateValue;
        item.cat_name = [[CommonHelperClass sharedConstants] getRemoteMonthYear:dateValue];
        [dropDownArray addObject:item];
        
        
    }
    
    return dropDownArray;
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



#pragma mark - DropDown View

-(void)createCategoryDropDownView{
    
    categoryTableView= [[Categorytableview alloc] initForEvents:CGRectMake(monthShowView.frame.origin.x, monthShowView.frame.origin.y + monthShowView.frame.size.height - 10, monthShowView.frame.size.width, 300) with:self];
    [self.eventsScrollview addSubview:categoryTableView];
    [categoryTableView setHidden:YES];
    
    
}

#pragma mark - Drop Down Delegate

-(void)categorySelect:(NSString *)categoryName withCatId:(NSInteger)cat_id{
    [self closeCategoryTableview];
    [monthShowView.showTextField setText:categoryName];
    [monthShowView.showTextField setTag:cat_id];
    dataArray = nil;
    
    dropDown_Row_index=cat_id;
    
    //Call api by Category Select
    [self callApiForFeed:@"" direction:@""];
}

#pragma mark - Api Calling

-(void)callApiForFeed:(NSString*)elementID direction:(NSString*)direction{
//    XLog(@"%i", monthShowView.showTextField.tag);
    CategoryItem *categoryItem = [categoryTableView.categroyDataArray objectAtIndex:monthShowView.showTextField.tag];

    NSString *date = [NSString stringWithFormat:@"%@", categoryItem.date_value];
    NSString *type = [NSString stringWithFormat:@"%i", [self returnType]];
    //NSString *page_number = [NSString stringWithFormat:@"%i", 1];

    [[ServerManager sharedManager] fetchEvents:elementID type:type date:date scrollDirection:direction completion:^(BOOL success, NSMutableArray *resultDataArray) {

        [self setNavigationTitle];
        
        if (success) {
//            if ([type isEqualToString:@"2"]) {
//                noEventsLabel.alpha = 0.0f;
//            }
            if ([direction isEqualToString:@"1"] || [direction isEqualToString:@""]) {
                if (dataArray == NULL || dataArray.count <= 0) {
                    dataArray = resultDataArray;
                }else{
                    [dataArray addObjectsFromArray:resultDataArray];
                }
            }else{
                [resultDataArray addObjectsFromArray:dataArray];
                dataArray = resultDataArray;
            }
        }else{
//            noEventsLabel.alpha = 1.0f;
//            if ([type isEqualToString:@"2"]) {
//                noEventsLabel.alpha = 1.0f;
//            }
        }
        
        isLoading = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
        
                [self resizeView];
                [loadingView dismisssView];
        });

        
    }];
    
    //first parameter - page number
}

-(void)setNavigationTitle{
    //Set navigation bar title text
    NSString *titleText = @"Events";
    NSString *subTitleText = [self returnSubtitleText:[self returnType]];

    [super setNavigationCustomTitleView:titleText with:subTitleText];
}

-(int)returnType{
    //type : 1 = upcoming
    //type : 2 = my events
    //type : 3 = past
    int button_tag = 0;
    for (EventsTabbarButton *btn in tabView.buttonArray) {
        if (btn.selected) {
            button_tag = (int)btn.tag;
            break;
        }
    }
    return button_tag+1;
}
#pragma mark - Events tabbar delegate

-(void)tabButtonAction:(int)button_tag{
    noPostLabel.alpha = 0.0f;
    //Change upcoming tabbar button bubble text
    //[tabView setUpcomingBubbleText:[NSString stringWithFormat:@"%i",arc4random()%10+1]];
    [self createEventsFeedView];
    //Find the selected event type (tabbar button)
//    [categoryTableView defineDataForEventByEventStuts:[self returnType]];
    //Call api by tabbar item click
    [self callApiDropDownValue];
}

-(NSString *)returnSubtitleText:(int)identity{
    NSString *tempStr = @"";
    if (identity == 1) {
        tempStr = @"Listing Upcoming Events";
        [noEventsLabel removeFromSuperview];
        noEventsLabel = nil;
    }
    else if (identity == 2){
        tempStr = @"Events Bookmarked By You";
        noEventsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f,
                                                                  self.eventsScrollview.frame.size.height/2.0f,
                                                                  self.eventsScrollview.frame.size.width-20.0f, 100.0f)];
        [noEventsLabel setTag:1029];
        [noEventsLabel setTextAlignment:NSTextAlignmentCenter];
        [noEventsLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [noEventsLabel setNumberOfLines:0];
        [noEventsLabel setTextColor:[UIColor sidraFlatDarkGrayColor]];
        [noEventsLabel setFont:[UIFont systemFontOfSize:20.0f]];
        [noEventsLabel setBackgroundColor:[UIColor clearColor]];
        
        [noEventsLabel setText:@"Add an upcoming event to \"My Events\" to bookmark it and receive push notification reminders before the event starts."];
        [self.eventsScrollview addSubview:noEventsLabel];
        noEventsLabel.alpha = 0.0f;
        [self.eventsScrollview sendSubviewToBack:noEventsLabel];
        
    }
    else{
        tempStr = @"Listing Past Events";
        [noEventsLabel removeFromSuperview];
        noEventsLabel = nil;
    }
    
    return tempStr;
}



#pragma mark - Method for category table view close

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self closeCategoryTableview];
}


-(void)closeCategoryTableview{
    //If category tableview open then close it
    if (!categoryTableView.hidden) {
        [self dropDownAction:monthShowView.selectButton];
    }
}


#pragma mark - Events Feed View

-(void)createEventsFeedView{
    [dataArray removeAllObjects];
    
    [eventsTableView removeFromSuperview];
    eventsTableView = nil;
    
    eventsTableView = [[UITableView alloc] initWithFrame:CGRectMake(monthShowView.frame.origin.x, monthShowView.frame.origin.y+monthShowView.frame.size.height, monthShowView.frame.size.width, 350)];
    [eventsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [eventsTableView setBackgroundColor:[UIColor clearColor]];
    [eventsTableView setScrollEnabled:NO];
    [eventsTableView setDelegate:self];
    [eventsTableView setDataSource:self];
    [eventsTableView setTag:100];
    [self.eventsScrollview addSubview:eventsTableView];
    
    
    [self.eventsScrollview bringSubviewToFront:categoryTableView];
}


#pragma mark - Resize Tableview
-(void)resizeView{
    [eventsTableView reloadData];
    
    CGFloat newHeight = dataArray.count * 116;
    newHeight<=0?(noPostLabel.alpha = 1.0f):(noPostLabel.alpha = 0.0f);
    for (UIView *view in self.eventsScrollview.subviews) {
        if (view.tag == 100) {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, newHeight)];
            [self.eventsScrollview setContentSize:CGSizeMake(view.frame.size.width, view.frame.size.height + view.frame.origin.y + 10)];
        }
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
    if([dataArray count]>0){
        noPostLabel.alpha = 0.0f;
        return [dataArray count];
    }else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 116;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell"; //[NSString stringWithFormat:@"Cell%i", indexPath.row];
    
    EventsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    cell = nil;
    if (cell == nil) {
        cell = [[EventsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    EventItem *dataModel = [dataArray objectAtIndex:indexPath.row];
    EventDateSubview *eventDateView = [cell createEventDateView:[NSString stringWithFormat:@"%@",dataModel.startDate]
                                                           with:[NSString stringWithFormat:@"%@",dataModel.endDate]];

    [cell createRightView:eventDateView
           withEventTitle:[NSString stringWithFormat:@"%@",dataModel.eventTitle]
                    venue:[NSString stringWithFormat:@"%@",dataModel.venue]
         eventDescription:[NSString stringWithFormat:@"%@",dataModel.eventDescription]];

//    NSLog(@"%i",[self returnType]);
    if ([self returnType] != 3) {
        [cell.bookmarkButton setTag:indexPath.row];
        [cell.bookmarkButton addTarget:self
                                action:@selector(bookmarkAction:)
                      forControlEvents:UIControlEventTouchUpInside];
        [cell.bookmarkButton setImage:[UIImage imageNamed:[[CommonHelperClass sharedConstants] getBookmarkedImageName:dataModel.isBookmarked]] forState:UIControlStateNormal];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self closeCategoryTableview];

    EventItem *dataModel = [dataArray objectAtIndex:indexPath.row];
    eventDetailsViewController = nil;
    eventDetailsViewController = [[EventsDetailsViewController alloc] init:dataModel with:indexPath.row];
    eventDetailsViewController.shouldShowRightMenuButton = YES;
    
    if ([self returnType] == 3)
        eventDetailsViewController.isBookmarkedVisible = NO;
    else
        eventDetailsViewController.isBookmarkedVisible = YES;
    
    [self.navigationController pushViewController:eventDetailsViewController animated:YES];
}



#pragma mark - button action

-(IBAction)bookmarkAction:(id)sender{
    
    
    
    UIButton *temp = (UIButton *)sender;
    
    EventItem *dataModel = [dataArray objectAtIndex:temp.tag];
    
    
    [[ServerManager sharedManager] favoriteEvent:dataModel.isBookmarked?@"0":@"1" eventID:dataModel.itemID completion:^(BOOL success){
        if (success) {
            dataModel.isBookmarked = !dataModel.isBookmarked;
            [temp setImage:[UIImage imageNamed:[[CommonHelperClass sharedConstants] getBookmarkedImageName:dataModel.isBookmarked]] forState:UIControlStateNormal];
            [dataArray replaceObjectAtIndex:temp.tag withObject:dataModel];
            
            NSString *type = [NSString stringWithFormat:@"%i", [self returnType]];
            //if this is in my event then remove this from data array
            if ([type intValue] == 2) {
                [dataArray removeObjectAtIndex:temp.tag];
            }
            [self resizeView];
            
            // added by Mehedi to show Alert msg
            if (dataModel.isBookmarked ==YES) {
                
                [self setLocalNotify:dataModel.startDate eventTitle:dataModel.eventTitle eventId:dataModel.itemID]; // active Local notification
                
                dispatch_async(dispatch_get_main_queue(), ^{

                    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/10.0, [UIScreen mainScreen].bounds.size.height/5.0 , 200, 80);
                    
                    NSString *msg = @"Event bookmarked under “My Events” tab. You’ll be reminded 3 hours before event starts";
                    AlertPopView *alertMsg = [[AlertPopView alloc] initWithFrame:frame alertMsg:msg];
                    [self.view addSubview:alertMsg];
                    alertMsg = nil;
                });
                
            }
            else {
                
                [self deleteLocalNotify:dataModel.itemID]; // Delete Local notification
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/10.0, [UIScreen mainScreen].bounds.size.height/5.0 , 200, 50);
                    NSString *msg = @"Event has been removed from your list of bookmarked events";
                    AlertPopView *alertMsg = [[AlertPopView alloc] initWithFrame:frame alertMsg:msg];
                    [self.view addSubview:alertMsg];
                    alertMsg = nil;
                });
            }
            
        }
    }];
    
}



#pragma mark - Local Notification Method

-(void)setLocalNotify:(NSString *)dateString eventTitle:(NSString*)eventName eventId:(NSString*)ID{
    
    //*Local Date Conversion START*//
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:s"];
    NSDate * dateNotFormatted = [dateFormatter dateFromString:dateString];
    
    //Create a date string in the local timezone
    dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:[NSTimeZone localTimeZone].secondsFromGMT];
    NSString *localDateString = [dateFormatter stringFromDate:dateNotFormatted];
    //XLog(@"date = %@", localDateString);
    NSDate *localeDate = [dateFormatter dateFromString:localDateString];
    //*Local Date Conversion END*//
    
    XLog(@"Local date is   : %@", localeDate);
    
    NSDate *currentTime = [NSDate date]; // get current time for testing
    XLog(@"Current Time is : %@", currentTime);
    
//    NSDate *fireTime = [localeDate dateByAddingTimeInterval:-60*60*2];  // 1 = 1 hours, 2 = 2 hours, 3 = 3 hours
    
    NSDate *fireTime = [localeDate dateByAddingTimeInterval:-60*3];  // 1 = 1 hours, 2 = 2 hours, 3 = 3 hours
    XLog(@"Fire Time is    : %@", fireTime);
    
    
    if ([fireTime compare:currentTime] == NSOrderedDescending) {
        //XLog(@"fire Time is Big than current time");
        
        NSString *eventAlertbody = [NSString stringWithFormat:@"Upcoming Events: %@",eventName];
        
        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
        if (localNotif == nil)
            return;
        
        localNotif.fireDate = fireTime;
        localNotif.timeZone = [NSTimeZone defaultTimeZone];
        localNotif.alertBody = eventAlertbody; // Notification details
        localNotif.alertAction = @"View"; // Set the action button
        
        // Specify custom data for the notification
        NSDictionary *infoDict = [NSDictionary dictionaryWithObject:ID forKey:@"PulseEventNotification"];
        localNotif.userInfo = infoDict;
        
        // Schedule the notification
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
        
        
    } else if ([fireTime compare:currentTime] == NSOrderedAscending) {
        XLog(@"fire Time is small than Current Time");
        
    } else {
        XLog(@"dates are the same");
        
    }
    

}


-(void)deleteLocalNotify:(NSString*)ID{
    

    NSArray *arrayOfLocalNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications] ;
    
    for (UILocalNotification *localNotification in arrayOfLocalNotifications) {
        
        NSString *idToDelete = [localNotification.userInfo objectForKey:@"PulseEventNotification"];
        NSString *eventIdString = [NSString stringWithFormat:@"%@",ID];
        NSString *idToDeleteString = [NSString stringWithFormat:@"%@",idToDelete];
        
        if ([eventIdString isEqualToString:idToDeleteString]){
            [[UIApplication sharedApplication]cancelLocalNotification:localNotification];
            break;
        }
        
//        if ([localNotification.alertBody isEqualToString:savedTitle]) {
//            XLog(@"the notification this is canceld is %@", localNotification.alertBody);
//
//            [[UIApplication sharedApplication] cancelLocalNotification:localNotification] ; // delete the notification from the system
//
//        }
    }
    
}

#pragma mark - Pull Refresh
- (void)pullDownToRefresh{
    EventItem *item = (EventItem*)[dataArray objectAtIndex:0];
    lastElementID = [NSString stringWithFormat:@"%@",item.itemID];
    
    [self callApiForFeed:lastElementID direction:@"0"];
    
}
- (void)pullUpToRefresh{
    EventItem *item = (EventItem*)[dataArray objectAtIndex:dataArray.count-1];;
    lastElementID = [NSString stringWithFormat:@"%@",item.itemID];
    
    [self callApiForFeed:lastElementID direction:@"1"];
    
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
