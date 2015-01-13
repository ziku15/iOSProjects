//
//  PoliciesLandingCell.m
//  Pulse
//
//  Created by Atomix on 7/7/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "PoliciesLandingCell.h"

@implementation PoliciesLandingCell

@synthesize deptName;
@synthesize grayArrow;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        reuseID = reuseIdentifier;
        
        
        deptName = [[UILabel alloc] init];
        [deptName setTextColor:[UIColor darkGrayColor ]];
        [deptName setBackgroundColor:[UIColor clearColor]];
        [deptName setFont:[UIFont systemFontOfSize:14]];
        [deptName setTextAlignment:NSTextAlignmentLeft];
        [deptName setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.contentView addSubview:deptName];
        
        
        grayArrow = [[UIImageView alloc] init];
        grayArrow.image = [UIImage imageNamed:@"arrow_gray"];
        [self.contentView addSubview:grayArrow];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
