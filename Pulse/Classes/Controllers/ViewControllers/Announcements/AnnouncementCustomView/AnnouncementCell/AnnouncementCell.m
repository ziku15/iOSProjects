//
//  AnnouncementCell.m
//  Pulse
//
//  Created by Supran on 6/17/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "AnnouncementCell.h"

@implementation AnnouncementCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier// with:(AnnouncementItem *)dataModel
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        
        
    }
    return self;
}

-(UILabel *)createTitleView:(NSString *)_title{
    CommonDynamicCellModel *calculatedModel = [AnnouncementCell calculateMaxSize:_title];
    
    
    [[self viewWithTag:999] removeFromSuperview];
    //create title label with a temporary frame size
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, calculatedModel.maxSize.height+7.0f)];
    [titleLabel setTag:999];
    titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    titleLabel.numberOfLines = 2;
    [titleLabel setText:calculatedModel.maxTitle];
    [titleLabel setTextColor:[UIColor sidraFlatDarkGrayColor]];
    [titleLabel setFont:calculatedModel.maxFont];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:titleLabel];
    
    return titleLabel;
}


-(UILabel *)createDateView:(NSString *)dateString previousView:(UILabel *)titleLabel{
    [[self viewWithTag:1000] removeFromSuperview];
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height + 5, 3*(titleLabel.frame.size.width/4), 20.0f)];
    [dateLabel setTag:1000];
    [dateLabel setText:[[CommonHelperClass alloc] getDateNameFormat:dateString]];
    [dateLabel setTextColor:[UIColor lightGrayColor]];
    [dateLabel setFont:[UIFont boldSystemFontOfSize:11.5f]];
    [self addSubview:dateLabel];
    
    return dateLabel;
}

-(void)createXIBFlatButton:(NSString *)cat_name previousView:(UILabel *)dateLabel{

    [[self viewWithTag:1001] removeFromSuperview];
    XIBFlatButtons *categoryButton = [XIBFlatButtons buttonWithType:UIButtonTypeCustom];
    [categoryButton setTag:1001];
    [categoryButton setFrame:CGRectMake(dateLabel.frame.origin.x + dateLabel.frame.size.width + 20, dateLabel.frame.origin.y, dateLabel.frame.size.width/4, dateLabel.frame.size.height-5)];
    [categoryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [categoryButton setTitle:cat_name forState:UIControlStateNormal];
    [categoryButton setBackgroundColor:[self selectedCategoryColor:cat_name]];
    [categoryButton.titleLabel setFont:[UIFont boldSystemFontOfSize:10.0f]];
    [categoryButton setUserInteractionEnabled:NO];
    [self addSubview:categoryButton];
}

+(CommonDynamicCellModel *)calculateMaxSize:(NSString *)maximumTitle{

    UIFont *maxFont = [UIFont boldSystemFontOfSize:13.5f];//[UIFont fontWithName:@"ProximaNova-Semibold" size:15.0f];
    if([maximumTitle length]>100){
        maximumTitle=[maximumTitle substringToIndex:100];
        maximumTitle = [maximumTitle stringByAppendingString:@"..."];
    }
    
    CGSize maximumLabelSize = CGSizeMake(300, FLT_MAX);
    
    //fetch expected label frame size
    CGRect expectedLabelSize = [maximumTitle boundingRectWithSize:maximumLabelSize
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:@{
                                                                    NSFontAttributeName: maxFont
                                                                    }
                                                          context:nil];
    
    
    
    CommonDynamicCellModel *item = [[CommonDynamicCellModel alloc] init];
    item.maxTitle = maximumTitle;
    item.maxSize = expectedLabelSize.size;
    item.maxFont = maxFont;
    
    
    return item;
}

-(UIColor *)selectedCategoryColor:(NSString *)categoryName{
    if ([categoryName isEqualToString:@"OAM"]) {
        return [UIColor sidraFlatBlueColor];
    }
    else if ([categoryName isEqualToString:@"CEMC"]){
        return [UIColor sidraFlatGreenColor];
    }
    else{
        return [UIColor sidraFlatRedColor];
    }
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
