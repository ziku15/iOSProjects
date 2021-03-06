//
//  AnnouncementDetailsViewController.h
//  Pulse
//
//  Created by Supran on 6/17/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDynamicCellModel.h"
#import "AnnouncementItem.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface AnnouncementDetailsViewController : CommonViewController<MFMailComposeViewControllerDelegate>
@property(nonatomic, retain) AnnouncementItem *detailsItem;
@property(nonatomic) NSInteger selectedIndex;

-(id)init:(AnnouncementItem *)item with:(NSInteger)index;

@end
