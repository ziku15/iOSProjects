//
//  DeptTableCell.m
//  Pulse
//
//  Created by Atomix on 6/26/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "DeptTableCell.h"

@implementation DeptTableCell

@synthesize userName;
@synthesize positionTitle;
@synthesize userDepartmentName;

@synthesize favourateBtn;

@synthesize email;
@synthesize office;
@synthesize mobile;

@synthesize emailBtn;
@synthesize officeBtn;
@synthesize mobileBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        reuseID = reuseIdentifier;
        
        
        userName = [[UILabel alloc] init];
        [userName setTextColor:[UIColor darkGrayColor]];
        [userName setBackgroundColor:[UIColor clearColor]];
        [userName setFont:[UIFont boldSystemFontOfSize:14]];
        [userName setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.contentView addSubview:userName];
        
        
        positionTitle = [[UILabel alloc] init];
        [positionTitle setTextColor:[UIColor lightGrayColor]];
        [positionTitle setBackgroundColor:[UIColor clearColor]];
        [positionTitle setFont:[UIFont systemFontOfSize:14]];
        [positionTitle setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.contentView addSubview:positionTitle];
        
        
        userDepartmentName = [[UILabel alloc] init];
        [userDepartmentName setTextColor:[UIColor lightGrayColor]];
        [userDepartmentName setBackgroundColor:[UIColor clearColor]];
        [userDepartmentName setFont:[UIFont systemFontOfSize:14]];
        [userDepartmentName setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.contentView addSubview:userDepartmentName];
        
        
        favourateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView addSubview:favourateBtn];
        
        
        _highlightedgrayBG = [[UIView alloc] init];
        _highlightedgrayBG.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_highlightedgrayBG];
        
        email = [[UILabel alloc] init];
        [email setText:@"Email :"];
        [email setTextColor:[UIColor whiteColor]];
        [email setBackgroundColor:[UIColor clearColor]];
        [email setFont:[UIFont systemFontOfSize:14]];
        [email setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.contentView addSubview:email];
        
        
        office = [[UILabel alloc] init];
        [office setText:@"Office :"];
        [office setTextColor:[UIColor whiteColor]];
        [office setBackgroundColor:[UIColor clearColor]];
        [office setFont:[UIFont systemFontOfSize:14]];
        [office setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.contentView addSubview:office];
        
        
        mobile = [[UILabel alloc] init];
        [mobile setText:@"Mobile :"];
        [mobile setTextColor:[UIColor whiteColor]];
        [mobile setBackgroundColor:[UIColor clearColor]];
        [mobile setFont:[UIFont systemFontOfSize:14]];
        [mobile setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.contentView addSubview:mobile];
        
        
        emailBtn = [XIBUnderLinedButton underlinedButton];
        [emailBtn setBackgroundColor:[UIColor clearColor]];
        emailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [[emailBtn titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:13]];
        [self.contentView addSubview:emailBtn];
        
        
        officeBtn = [XIBUnderLinedButton underlinedButton];
        [officeBtn setBackgroundColor:[UIColor clearColor]];
        officeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [[officeBtn titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:13]];
        [self.contentView addSubview:officeBtn];
        
        
        mobileBtn = [XIBUnderLinedButton underlinedButton];;
        [mobileBtn setBackgroundColor:[UIColor clearColor]];
        mobileBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [[mobileBtn titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:13]];
        
        [self.contentView addSubview:mobileBtn];

        
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
