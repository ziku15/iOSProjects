//
//  StaffSearchViewController.h
//  Pulse
//
//  Created by xibic on 7/7/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XIBSearchBar.h"
#import "StaffTableView.h"
@interface StaffSearchViewController : CommonViewController<XIBSearchBarDelegate>{


XIBSearchBar *directorySearchBar;
    UILabel *resultHeaderView;
    StaffTableView *staffTable;
    UILabel *noResultsLabel ;
}

@property (nonatomic,strong) NSArray *staffArray;
@property (nonatomic,strong) NSString *searchKey;
@end
