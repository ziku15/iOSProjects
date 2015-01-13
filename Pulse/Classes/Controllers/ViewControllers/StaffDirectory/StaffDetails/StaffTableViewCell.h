//
//  StaffTableViewCell.h
//  Pulse
//
//  Created by Atomix on 6/25/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaffTableViewCell : UITableViewCell

{
    NSString *reuseID;
}

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *grayBorder;
@property (nonatomic, strong) UIImageView *grayArrow;

@end
