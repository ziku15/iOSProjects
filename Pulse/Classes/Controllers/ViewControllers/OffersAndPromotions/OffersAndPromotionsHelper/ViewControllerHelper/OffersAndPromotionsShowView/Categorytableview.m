//
//  Categorytableview.m
//  Pulse
//
//  Created by Supran on 6/19/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "Categorytableview.h"

@implementation Categorytableview
@synthesize delegate;
@synthesize categroyDataArray;

#pragma mark - All Except Event and OFfer

-(id)initMethodGeneral:(CGRect)frame with:(id)parentInstance
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setDelegate:parentInstance];
        [self setBackgroundColor:[UIColor clearColor]];
        self.userInteractionEnabled = YES;
        
        categroyDataArray = [[NSMutableArray alloc] init];
        
        [self createTableview];
    }
    return self;
}

#pragma mark - Events

//Events initialize method
- (id)initForEvents:(CGRect)frame with:(id)parentInstance
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setDelegate:parentInstance];
        [self setBackgroundColor:[UIColor clearColor]];
        self.userInteractionEnabled = YES;
        
        categroyDataArray = [[NSMutableArray alloc] init];
//        allEventDataArray = [[NSMutableArray alloc] init];
        
        [self createTableview];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self closeCategoryView];
}


-(void)setDataArrayValueForEvent:(NSMutableArray *)_data_array {
    [categroyDataArray removeAllObjects];
    
    for (CategoryItem *category_item in _data_array) {
        [categroyDataArray addObject:category_item];
    }
    
    [radioTableview reloadData];
    
    isEvent = true;
    [self callDelegate:0];
    
}

-(void)setDataArrayValueForEvent_After_Details:(NSMutableArray *)_data_array index:(int)index {
    [categroyDataArray removeAllObjects];
    
    for (CategoryItem *category_item in _data_array) {
        [categroyDataArray addObject:category_item];
    }
    
    [radioTableview reloadData];
    
    isEvent = true;
    [self callDelegate:index];
    
}



//-(NSMutableArray *)returnExpectedIndex:(int)integer past:(BOOL)isPast{
//    int index, x, count;
//    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
//    
//    index = integer;
//    count = 0;
//    
//    if (isPast)
//        x= index + 1;
//    else
//        x=index-1;
//
//    while (count < 6) {
//        
//        if (isPast)
//            x=(x-1)<0?11:x-1;
//        else
//            x=(x+1)%12;
//        
//        [tempArray addObject:[NSString stringWithFormat:@"%i", x]];
////        NSLog(@"= %i", x);
//        
//        count ++;
//        
//    }
//    
//    return tempArray;
////    index = 0;
////    x= index + 1;
////    count = 0;
////    while (count < 6) {
////        x=(x-1)<0?11:x-1;
////        NSLog(@"= %i", x);
////        count ++;
////    }
//}
//-(void)defineDataForEventByEventStuts:(int)_event_status{
//    [categroyDataArray removeAllObjects];
//    if (_event_status == 1 || _event_status == 2) {
//        //Upcoming
////        for (int i = currentMonthIndex; i < allEventDataArray.count; i++) {
////            CategoryItem *category_item = [allEventDataArray objectAtIndex:i];
////            [categroyDataArray addObject:category_item];
////        }
//        NSMutableArray *seletedMonthIndexArray = [self returnExpectedIndex:currentMonthIndex past:NO];
//
//        for (int i = 0; i < seletedMonthIndexArray.count ; i++) {
//
//            NSString *monthIndex = [seletedMonthIndexArray objectAtIndex:i];
//            CategoryItem *category_item = [allEventDataArray objectAtIndex:[monthIndex integerValue]];
//            [categroyDataArray addObject:category_item];
//
//        }
//        
//
//    }
////    else if(_event_status == 2){
////        //my event
////        for (CategoryItem *category_item in allEventDataArray) {
////            [categroyDataArray addObject:category_item];
////        }
////    }
//    else
//    {
//        //past
////        for (int i = 0; i <= currentMonthIndex; i++) {
////            CategoryItem *category_item = [allEventDataArray objectAtIndex:i];
////            [categroyDataArray addObject:category_item];
////        }
//        NSMutableArray *seletedMonthIndexArray = [self returnExpectedIndex:currentMonthIndex past:YES];
//        
//        for (int i = 0; i < seletedMonthIndexArray.count ; i++) {
//            
//            NSString *monthIndex = [seletedMonthIndexArray objectAtIndex:i];
//            CategoryItem *category_item = [allEventDataArray objectAtIndex:[monthIndex integerValue]];
//            [categroyDataArray addObject:category_item];
//            
//        }
//
//    }
//    
//    [radioTableview reloadData];
//    
//    if (categroyDataArray.count > 0) {
//        
//        int _index = 0;
////        if (_event_status == 1 || _event_status == 2) {
////            _index = 0;
////        }
////        else if(_event_status == 2){
////            _index = currentMonthIndex;
////        }
////        else{
////            _index = categroyDataArray.count - 1;
////        }
//        
//        CategoryItem *category_item = [categroyDataArray objectAtIndex:_index];
//        [self.delegate categorySelect:category_item.cat_name withCatId:_index];
//    }
//    
//}

-(void)setDataArrayValueForAlbum:(NSMutableArray *)_data_array{
    
    int index = 0;
    for (int i = 0 ; i < _data_array.count ; i ++) {
        CategoryItem *category_item = [_data_array objectAtIndex:i];
        [categroyDataArray addObject:category_item];
        
        NSString *dateValue = [NSString stringWithFormat:@"%@",category_item.date_value];
        if (dateValue.length > 0) {
            index = i ;
        }
    }
    
    [radioTableview reloadData];
    
    [self callDelegate:index];
    
}

-(void)setDataArrayValueForMainClassified:(NSMutableArray *)_data_array{
    
    CategoryItem *category_item = [[CategoryItem alloc] init];
    category_item.cat_id = @"0";
    category_item.cat_name = @"All Categories";
    [categroyDataArray addObject:category_item];
    
    for (CategoryItem *category_item in _data_array) {
        [categroyDataArray addObject:category_item];
    }
    
    [radioTableview reloadData];
    
    [self callDelegate:0];
    
}

-(void)setDataArrayValueForClassified:(NSMutableArray *)_data_array cat_id:(int)_cat_id{
    int selectedIndex = 0;
    
    CategoryItem *category_item = [[CategoryItem alloc] init];
    category_item.cat_id = @"0";
    category_item.cat_name = @"None";
    [categroyDataArray addObject:category_item];
    
    for (CategoryItem *category_item in _data_array) {
        [categroyDataArray addObject:category_item];
    }
    
    //find selected item
    for (int i = 0; i < categroyDataArray.count ; i ++) {
        CategoryItem *category_item = [categroyDataArray objectAtIndex:i];
        if ([[NSString stringWithFormat:@"%@",category_item.cat_id] isEqualToString:[NSString stringWithFormat:@"%i",_cat_id]]) {
            selectedIndex = i;
        }
    }
    
    [radioTableview reloadData];
    
    [self callDelegate:selectedIndex];
    
}

#pragma mark - Offer and Promotion

//Offer and promotion
- (id)initWithFrame:(CGRect)frame with:(id)parentInstance
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setDelegate:parentInstance];
        [self setBackgroundColor:[UIColor clearColor]];
        
        categroyDataArray = [[NSMutableArray alloc] init];
        
        CategoryItem *category_item = [[CategoryItem alloc] init];
        category_item.cat_id = @"0";
        category_item.cat_name = @"Show All";
        
        [categroyDataArray addObject:category_item];
        
        [self createTableview];
    }
    return self;
}


-(void)setDataArrayValue:(NSMutableArray *)_data_array{
    //Sort Array Value alphabetically

    NSSortDescriptor *alphaDesc = [[NSSortDescriptor alloc] initWithKey:@"cat_name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    [_data_array sortUsingDescriptors:[NSMutableArray arrayWithObjects:alphaDesc, nil]];
    
    for (CategoryItem *category_item in _data_array) {
        [categroyDataArray addObject:category_item];
    }
    
    
    [radioTableview reloadData];
    
    [self callDelegate:0];
}

#pragma mark - Common

-(void)createTableview{
    radioTableview = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, 300, 200)];
    radioTableview.layer.cornerRadius = kViewCornerRadius;
    radioTableview.layer.masksToBounds = YES;
    radioTableview.layer.borderColor = [UIColor lightGrayColor].CGColor;
    radioTableview.layer.borderWidth = 1.0f;
    [radioTableview setDelegate:self];
    [radioTableview setDataSource:self];
    [self addSubview:radioTableview];
}


#pragma mark - Animarion Delegate
-(void)openCategoryView{
    [self setHidden:NO];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [radioTableview setFrame:CGRectMake(radioTableview.frame.origin.x, radioTableview.frame.origin.y, radioTableview.frame.size.width, OPEN_HEIGHT)];
                     }
                     completion:^(BOOL finished){
                     }];
}
-(void)closeCategoryView{
    [UIView animateWithDuration:0.2
                      animations:^{
                         [radioTableview setFrame:CGRectMake(radioTableview.frame.origin.x, radioTableview.frame.origin.y, radioTableview.frame.size.width, CLOSE_HEIGHT)];
                     }
                     completion:^(BOOL finished){
                         [self setHidden:YES];
                     }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([categroyDataArray count]>0)
        return [categroyDataArray count];
    else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    CategoryItem *category_item = [categroyDataArray objectAtIndex:indexPath.row];
    
    if([category_item.cat_name isKindOfClass:[NSString class]]){
    cell.textLabel.text = category_item.cat_name;
    } 
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:14.0f]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self callDelegate:indexPath.row];
}

-(void)callDelegate:(NSInteger)cell_index{
    if (isEvent) {
        CategoryItem *category_item = [categroyDataArray objectAtIndex:cell_index];
        [self.delegate categorySelect:category_item.cat_name withCatId:cell_index];
    }
    else{
        CategoryItem *category_item = [categroyDataArray objectAtIndex:cell_index];
        [self.delegate categorySelect:category_item.cat_name withCatId:[category_item.cat_id integerValue]];
    }
}
@end
