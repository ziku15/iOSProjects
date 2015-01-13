//
//  StaffTableViewCell.m
//  Pulse
//
//  Created by Atomix on 6/25/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "StaffTableViewCell.h"

@implementation StaffTableViewCell

@synthesize nameLabel;
@synthesize grayBorder;
@synthesize grayArrow;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        reuseID = reuseIdentifier;
        
        
         nameLabel = [[UILabel alloc] init];
        [nameLabel setTextColor:[UIColor darkGrayColor]];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setFont:[UIFont systemFontOfSize:14]];
        [nameLabel setTextAlignment:NSTextAlignmentLeft];
        [nameLabel setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.contentView addSubview:nameLabel];
        
        
        grayArrow = [[UIImageView alloc] init];
        grayArrow.image = [UIImage imageNamed:@"arrow_gray.png"];
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
