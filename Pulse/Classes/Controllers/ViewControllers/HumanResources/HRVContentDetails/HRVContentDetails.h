//
//  HRVContentDetails.h
//  Pulse
//
//  Created by Atomix on 7/3/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRL1Item.h"
#import "SKSTableView.h"

@interface HRVContentDetails : CommonViewController <SKSTableViewDelegate>

@property (nonatomic, weak) HRL1Item *hrl1Item;

@property (nonatomic, weak) IBOutlet SKSTableView *tableView;

@end
