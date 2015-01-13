//
//  AllClassifiedsView.h
//  Pulse
//
//  Created by Supran on 7/7/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "PostedByMeCell.h"
#import "AllClassifiedCell.h"
#import "Categorytableview.h"
#import "OffersAndPromotionsShowView.h"
#import <UIKit/UIKit.h>

#define TABLE_CELL_HEIGHT 150
@protocol AllClassifiedsViewDelegate <NSObject>
@optional
- (void)updateDataLoading:(BOOL)loading;
-(void)dynamicallyChangeViewSize:(id)reference;
-(void)allClassifiedCellSelection:(ClassifiedItem *)item index:(NSInteger)selIndex;
-(void)categorySelectedText:(NSString *)categoryName;
@end


@interface AllClassifiedsView : UIView<CategorytableviewDelegate, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>{
    Categorytableview *categoryTableView;


    
    CGRect initialFrame;
    
}


@property (strong) id <AllClassifiedsViewDelegate> delegate;
@property (nonatomic, strong) OffersAndPromotionsShowView *dropDownShowView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) UITableView *classifiedFeedTableview;
@property (assign) BOOL isBookmarkedTabSelected;

-(void)refreshView;
-(void)populateClassifiedFeed:(NSString*)lastElementID direction:(NSString*)direction;
-(void)createCategoryView;

-(void)createFeedView;
@end
