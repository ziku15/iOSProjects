//
//  PostedByMeCell.m
//  Pulse
//
//  Created by Supran on 7/9/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "PostedByMeCell.h"

@implementation PostedByMeCell
@synthesize delButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier //with:(ClassifiedItem *)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        mainBGView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 140)];
        [mainBGView setBackgroundColor:[UIColor whiteColor]];
        mainBGView.layer.cornerRadius = kViewCornerRadius;
        mainBGView.layer.masksToBounds = YES;
        mainBGView.layer.borderColor = kViewBorderColor;
        mainBGView.layer.borderWidth = kViewBorderWidth;
        
        [self addSubview:mainBGView];
        
    }
    return self;
}


#pragma mark - Description View
-(void)createDescriptionView:(UILabel *)previousView with:(NSString *)description_text{

    if([description_text length]>100){
        description_text=[description_text substringToIndex:97];
        description_text = [description_text stringByAppendingString:@"..."];
    }
    CGFloat textLength = description_text.length;
    description_text = [description_text stringByAppendingString:@" More..."];
    
    CGFloat desWidth = mainBGView.frame.size.width - 20;
    CommonDynamicCellModel *titleDetails = [[CommonHelperClass sharedConstants] calculateLabelMaxSize:description_text with:[UIFont boldSystemFontOfSize:12.0f] with:desWidth];

    [[mainBGView viewWithTag:102] removeFromSuperview];
    UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(previousView.frame.origin.x, previousView.frame.origin.y+ previousView.frame.size.height + 2, desWidth, titleDetails.maxSize.height > 50 ? 50 : titleDetails.maxSize.height)];
    [desLabel setTag:102];
    desLabel.lineBreakMode = NSLineBreakByWordWrapping;
    desLabel.numberOfLines = 0;
    [desLabel setTextColor:[UIColor grayColor]];
    [desLabel setFont:titleDetails.maxFont];
    [desLabel setBackgroundColor:[UIColor clearColor]];
    [mainBGView addSubview:desLabel];
    
    
    

    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", description_text]];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor sidraFlatDarkGrayColor] range:NSMakeRange(textLength, 8)];
    desLabel.attributedText = attrStr;
    

}

#pragma mark - Date View
-(UILabel *)createDateView:(UILabel *)previousView with:(NSString *)date_time
{
    [[mainBGView viewWithTag:101] removeFromSuperview];
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(previousView.frame.origin.x, previousView.frame.origin.y+ previousView.frame.size.height + 3, previousView.frame.size.width - 20 , 20)];
    [dateLabel setTag:101];
    [dateLabel setTextColor:[UIColor sidraFlatRedColor]];
    [dateLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [dateLabel setText:[[CommonHelperClass sharedConstants] getDateNameFormat:date_time]];
    [dateLabel setBackgroundColor:[UIColor clearColor]];
    [mainBGView addSubview:dateLabel];
    

    UIView *delButtonView = [[UIView alloc] initWithFrame:CGRectMake(dateLabel.frame.origin.x + dateLabel.frame.size.width, dateLabel.frame.origin.y, 20, 20)];
    [delButtonView setBackgroundColor:[UIColor clearColor]];
    [delButtonView setTag:101];
    [mainBGView addSubview:delButtonView];
    
    
    delButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [delButton setBackgroundColor:[UIColor clearColor]];
    [delButton setImage:[UIImage imageNamed:@"delete_icon.png"] forState:UIControlStateNormal];
    delButton.frame = CGRectMake(0, 0, delButtonView.frame.size.width, delButtonView.frame.size.height);
    [delButtonView addSubview:delButton];

    return dateLabel;
}



-(UIImageView *)createStatusView:(int)isDraft{
    NSString *imageName = @"";
    if (isDraft == 0) {
        imageName = @"cla_active_btn.png";
    }
    else if (isDraft == 1){
        imageName = @"cla_draft_btn.png";
    }
    
    [[mainBGView viewWithTag:99] removeFromSuperview];
    UIImageView *stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(mainBGView.frame.size.width - 73, 5, 63, 29)];
    [stateImageView setTag:99];
    [stateImageView setImage:[UIImage imageNamed:imageName]];
    [mainBGView addSubview:stateImageView];
    
    return stateImageView;
}

#pragma mark - Title View
-(UILabel *)createTitleView:(UIImageView *)previousView with:(NSString *)title{
    
    if([title length]>40){
        title=[title substringToIndex:37];
        title = [title stringByAppendingString:@"..."];
    }

    
    [[mainBGView viewWithTag:100] removeFromSuperview];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, previousView.frame.origin.y + previousView.frame.size.height + 5, mainBGView.frame.size.width - 20, 20)];
    [titleLabel setTag:100];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    [titleLabel setText:title];
    [titleLabel setTextColor:[UIColor sidraFlatDarkGrayColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [mainBGView addSubview:titleLabel];
    
    return titleLabel;
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
