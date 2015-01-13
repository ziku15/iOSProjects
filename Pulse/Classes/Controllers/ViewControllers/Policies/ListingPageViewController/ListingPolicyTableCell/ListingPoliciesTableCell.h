//
//  ListingPoliciesTableCell.h
//  Pulse
//
//  Created by Atomix on 7/7/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListingPoliciesTableCell : UITableViewCell

{
    NSString *reuseID;
}

@property (nonatomic, strong) UILabel *titleName;
@property (nonatomic, strong) UILabel *policyNo;
@property (nonatomic, strong) UIImageView *grayArrow;

@end
