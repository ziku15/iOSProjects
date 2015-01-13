//
//  StayInformedTableCell.m
//  Pulse
//
//  Created by Atomix on 7/10/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "StayInformedTableCell.h"

@implementation StayInformedTableCell

@synthesize itemName;
@synthesize roundArrow;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        reuseID = reuseIdentifier;
        
        
        itemName = [[UILabel alloc] init];
        [itemName setTextColor:[UIColor darkGrayColor ]];
        [itemName setBackgroundColor:[UIColor clearColor]];
        [itemName setFont:[UIFont systemFontOfSize:14]];
        [itemName setTextAlignment:NSTextAlignmentLeft];
        [itemName setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.contentView addSubview:itemName];
        
        
        roundArrow = [[UIImageView alloc] init];
        roundArrow.image = [UIImage imageNamed:@"Round_arrow_right"];
        [self.contentView addSubview:roundArrow];
        
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
