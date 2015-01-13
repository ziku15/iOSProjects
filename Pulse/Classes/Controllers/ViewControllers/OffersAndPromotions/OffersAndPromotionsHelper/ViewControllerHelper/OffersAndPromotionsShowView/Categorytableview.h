//
//  Categorytableview.h
//  Pulse
//
//  Created by Supran on 6/19/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#define CLOSE_HEIGHT 0.0f
#define OPEN_HEIGHT 200.0f
#import <UIKit/UIKit.h>
#import "CategoryItem.h"

@protocol CategorytableviewDelegate <NSObject>
@optional
-(void)categorySelect:(NSString *)categoryName withCatId:(NSInteger)cat_id;
@end

@interface Categorytableview : UIView<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *radioTableview;

    NSMutableArray *allEventDataArray;
    int currentMonthIndex;
    BOOL isEvent;
}
@property (nonatomic, strong)     NSMutableArray *categroyDataArray;
@property (strong) id <CategorytableviewDelegate> delegate;
//- (id)initWithFrame:(CGRect)frame with:(NSMutableArray *)_dataArray with:(id)parentInstance;
- (id)initWithFrame:(CGRect)frame with:(id)parentInstance;
-(void)setDataArrayValue:(NSMutableArray *)_data_array;

-(void)callDelegate:(NSInteger)cell_index;
-(void)openCategoryView;
-(void)closeCategoryView;


//Events
- (id)initForEvents:(CGRect)frame with:(id)parentInstance;
-(void)setDataArrayValueForEvent:(NSMutableArray *)_data_array;// currentMonth:(int)_current_month;

-(void)setDataArrayValueForEvent_After_Details:(NSMutableArray *)_data_array index:(int)index;

    
//-(void)defineDataForEventByEventStuts:(int)_event_status;
-(void)setDataArrayValueForAlbum:(NSMutableArray *)_data_array ;
//Classified
-(void)setDataArrayValueForClassified:(NSMutableArray *)_data_array cat_id:(int)_cat_id;
-(void)setDataArrayValueForMainClassified:(NSMutableArray *)_data_array;
//--------------------
-(id)initMethodGeneral:(CGRect)frame with:(id)parentInstance;
@end
