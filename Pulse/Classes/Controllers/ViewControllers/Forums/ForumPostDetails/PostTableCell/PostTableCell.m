//
//  PostTableCell.m
//  Pulse
//
//  Created by Atomix on 7/15/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "PostTableCell.h"

@implementation PostTableCell

@synthesize userPostWhiteBgView;
@synthesize postText;
@synthesize postedImgList;
@synthesize postedOn;
@synthesize postedOnDate;
@synthesize postedBy;
@synthesize postedByName;
@synthesize emailImg;
@synthesize phoneImg;
@synthesize emailBtn;
@synthesize phoneBtn;
@synthesize deleteBtn;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        reuseID = reuseIdentifier;
        
        
        // Background
        userPostWhiteBgView = [[UIView alloc] init];
        userPostWhiteBgView.backgroundColor = [UIColor whiteColor];
        [userPostWhiteBgView.layer setBorderColor:[[[UIColor sidraFlatGrayColor] colorWithAlphaComponent:1.0] CGColor]];
        [userPostWhiteBgView.layer setBorderWidth:kViewBorderWidth];
        userPostWhiteBgView.layer.cornerRadius = kViewCornerRadius;
        userPostWhiteBgView.clipsToBounds = YES;
        [self.contentView addSubview:userPostWhiteBgView];
        
        // post text
         postText = [[STTweetLabel alloc] init];
        [self.contentView addSubview:postText];
        
        
         postedOn = [[UILabel alloc] init];
        [postedOn setTextColor:[UIColor grayColor]];
         postedOn.text = @"Posted on :";
        [postedOn setBackgroundColor:[UIColor clearColor]];
        [postedOn setFont:[UIFont boldSystemFontOfSize:10]];
        postedOn.numberOfLines = 1;
        [postedOn setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.contentView addSubview:postedOn];
        
        
        postedOnDate = [[UILabel alloc] init];
        [postedOnDate setTextColor:[UIColor redColor]];
        [postedOnDate setBackgroundColor:[UIColor clearColor]];
        [postedOnDate setFont:[UIFont systemFontOfSize:10]];
        postedOnDate.numberOfLines = 1;
        [postedOnDate setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.contentView addSubview:postedOnDate];
        
        
        postedBy = [[UILabel alloc] init];
        [postedBy setTextColor:[UIColor grayColor]];
        postedBy.text = @"Posted by :";
        [postedBy setBackgroundColor:[UIColor clearColor]];
        [postedBy setFont:[UIFont boldSystemFontOfSize:10]];
        postedBy.numberOfLines = 1;
        [postedBy setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.contentView addSubview:postedBy];
        
        
        postedByName = [[UILabel alloc] init];
        [postedByName setTextColor:[UIColor sidraFlatTurquoiseColor]];
        [postedByName setBackgroundColor:[UIColor clearColor]];
        [postedByName setFont:[UIFont boldSystemFontOfSize:10]];
        postedByName.numberOfLines = 1;
        [postedByName setTranslatesAutoresizingMaskIntoConstraints:YES];
        [self.contentView addSubview:postedByName];
        
        
        deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setImage:[UIImage imageNamed:@"delete_icon"] forState:UIControlStateNormal];
        [self.contentView addSubview:deleteBtn];
        
        
        emailImg = [[UIImageView alloc] init];
        emailImg.image = [UIImage imageNamed:@"mass_icon"];
        [self.contentView addSubview:emailImg];
        
        
        emailBtn = [[UIButton alloc] init];
        [emailBtn setBackgroundColor:[UIColor clearColor]];
        [emailBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        emailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [[emailBtn titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:10]];
        [self.contentView addSubview:emailBtn];
        
        
        phoneImg = [[UIImageView alloc] init];
        phoneImg.image = [UIImage imageNamed:@"phone_icon"];
        [self.contentView addSubview:phoneImg];
        
        
        phoneBtn = [[UIButton alloc] init];
        [phoneBtn setBackgroundColor:[UIColor clearColor]];
        [phoneBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        phoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [[phoneBtn titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:10]];
        [self.contentView addSubview:phoneBtn];
        
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

- (void)addPhotoScrollerWithPhotos:(NSMutableArray*)photoArray frameSize: (CGRect)frame {
    
    self.postedImgList = [[XIBPhotoScrollView alloc] initWithFrame:frame withPhotos:photoArray];
    [self.contentView addSubview:self.postedImgList];
}




    
@end




