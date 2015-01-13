//
//  ListingPoliciesTableCell.m
//  Pulse
//
//  Created by Atomix on 7/7/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "ListingPoliciesTableCell.h"

@implementation ListingPoliciesTableCell

@synthesize titleName;
@synthesize policyNo;
@synthesize grayArrow;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        reuseID = reuseIdentifier;
        
        
        titleName = [[UILabel alloc] init];
        [titleName setTextColor:[UIColor darkGrayColor]];
        [titleName setBackgroundColor:[UIColor clearColor]];
        [titleName setFont:[UIFont systemFontOfSize:14]];
        [titleName setTextAlignment:NSTextAlignmentLeft];
         titleName.numberOfLines= 2;
        [titleName setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.contentView addSubview:titleName];
        
        
        policyNo = [[UILabel alloc] init];
        [policyNo setTextColor:[UIColor grayColor]];
        [policyNo setBackgroundColor:[UIColor clearColor]];
        [policyNo setFont:[UIFont systemFontOfSize:12]];
        [policyNo setTextAlignment:NSTextAlignmentLeft];
        [policyNo setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.contentView addSubview:policyNo];
        
        
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
