//
//  AnnouncementViewController.h
//  Pulse
//
//  Created by xibic on 6/11/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "AnnouncementCell.h"
#import "AnnouncementDetailsViewController.h"
#import "AnnouncementItem.h"



@interface AnnouncementViewController : CommonViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *announcementTableview;

@end
