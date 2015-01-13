//
//  StayInformedTableCell.h
//  Pulse
//
//  Created by Atomix on 7/10/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StayInformedTableCell : UITableViewCell

{
    NSString *reuseID;
}

@property (nonatomic, strong) UILabel *itemName;
@property (nonatomic, strong) UIImageView *roundArrow;

@end
