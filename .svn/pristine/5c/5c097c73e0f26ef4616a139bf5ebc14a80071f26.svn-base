//
//  AllClassifiedCell.m
//  Pulse
//
//  Created by Supran on 7/8/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "AllClassifiedCell.h"

@implementation AllClassifiedCell
@synthesize delButton;
@synthesize mainBGView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier// with:(ClassifiedItem *)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        mainBGView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 140)];
        [mainBGView setBackgroundColor:[UIColor whiteColor]];
        mainBGView.layer.cornerRadius = kViewCornerRadius;
        mainBGView.layer.masksToBounds = YES;
        //set border color
        mainBGView.layer.borderColor = [UIColor sidraFlatGreenColor].CGColor;
        mainBGView.layer.borderWidth = 2.0f;
        [self addSubview:mainBGView];
        
        
        
    }
    return self;
}

#pragma mark - Title View
-(UILabel *)createTitleView:(NSString *)title{

    
    [[mainBGView viewWithTag:9990] removeFromSuperview];
    
    if([title length]>45){
        title=[title substringToIndex:42];
        title = [title stringByAppendingString:@"..."];
    }
    //create title label with a temporary frame size
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 280, 20)];
    [titleLabel setTag:9990];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    [titleLabel setText:title];
    [titleLabel setTextColor:[UIColor sidraFlatDarkGrayColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [mainBGView addSubview:titleLabel];
    
    return titleLabel;

}

#pragma mark - Date View
-(UILabel *)createDateView:(UILabel *)previousView with:(NSString *)date_time{

    [[mainBGView viewWithTag:9991] removeFromSuperview];
    // Create date label
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(previousView.frame.origin.x, previousView.frame.origin.y+ previousView.frame.size.height + 2, previousView.frame.size.width, 18)];
    [dateLabel setTag:9991];
    [dateLabel setTextColor:[UIColor sidraFlatRedColor]];
    [dateLabel setFont:[UIFont systemFontOfSize:9.0f]];
    [dateLabel setText:[[CommonHelperClass sharedConstants] getDateNameFormat:date_time]];
    [dateLabel setBackgroundColor:[UIColor clearColor]];
    [mainBGView addSubview:dateLabel];
    
    return dateLabel;
}

#pragma mark - Posted View
-(UIView *)createPostedByView:(UILabel *)previousView with:(NSString *)createdBy with:(NSArray *)_ownerInfo{


    
    NSString *authorName = @"";
    UIColor *colorCode ;
    
//    XLog(@"%@ %@",[UserManager sharedManager].userID,createdBy );
    if ([[UserManager sharedManager].userID isEqualToString:[NSString stringWithFormat:@"%@",createdBy]]) {
        authorName = @"You";
        colorCode = [UIColor sidraFlatGreenColor];
        
        
        /*/set border color
        mainBGView.layer.borderColor = [UIColor sidraFlatGreenColor].CGColor;
        mainBGView.layer.borderWidth = 2.0f;
        */
        //set border color updated next season
        mainBGView.layer.borderColor = [UIColor sidraFlatGrayColor].CGColor;
        mainBGView.layer.borderWidth = 0.5f;
    }
    else{
        NSArray *ownerInfo = _ownerInfo;
        colorCode = [UIColor sidraFlatTurquoiseColor];
        if (ownerInfo.count > 0) {
            NSDictionary *ownerDic = [ownerInfo objectAtIndex:0];
            authorName = [ownerDic objectForKey:@"name"];
        }
        else{
            authorName = @"Other";
        }
        
        //set border color
        mainBGView.layer.borderColor = [UIColor sidraFlatGrayColor].CGColor;
        mainBGView.layer.borderWidth = 0.5f;
    }

    
    
    NSString *initialString = @"Posted by : ";
    
    CGFloat width = previousView.frame.size.width;
    if ([authorName isEqualToString:@"You"]) {
        width = width - 20;
        
        delButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [delButton setBackgroundColor:[UIColor clearColor]];
        [delButton setImage:[UIImage imageNamed:@"delete_icon.png"] forState:UIControlStateNormal];
        delButton.frame = CGRectMake(width+5, previousView.frame.origin.y+ previousView.frame.size.height, 20, 20);
        [mainBGView addSubview:delButton];
    }
    else{
        delButton = nil;
    }
    
    [[mainBGView viewWithTag:9992] removeFromSuperview];
    // Create date label
    UILabel *postedByLabel = [[UILabel alloc] initWithFrame:CGRectMake(previousView.frame.origin.x, previousView.frame.origin.y+ previousView.frame.size.height, width, 20)];
    [postedByLabel setTag:9992];
    [postedByLabel setTextColor:[UIColor lightGrayColor]];
    [postedByLabel setFont:[UIFont boldSystemFontOfSize:10.5f]];
    [postedByLabel setBackgroundColor:[UIColor clearColor]];
    [mainBGView addSubview:postedByLabel];
    
    
    initialString = [initialString stringByAppendingString:authorName];
    CGFloat textLength = authorName.length;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", initialString]];
    [attrStr addAttribute:NSForegroundColorAttributeName value:colorCode range:NSMakeRange(12, textLength)];
    postedByLabel.attributedText = attrStr;
    
    [[mainBGView viewWithTag:9993] removeFromSuperview];
    UIView *endLineView = [[UIView alloc] init];
    [endLineView setTag:9993];
    [endLineView setBackgroundColor:[UIColor sidraFlatLightGrayColor]];
    [endLineView setFrame:CGRectMake(postedByLabel.frame.origin.x, postedByLabel.frame.origin.y + postedByLabel.frame.size.height + 5, previousView.frame.size.width, 1)];
    [mainBGView addSubview:endLineView];
    
    return endLineView;
    
}

#pragma mark - Description View
-(UILabel *)createDescriptionView:(UIView *)previousView with:(NSString *)description_text{

    
    if([description_text length]>115){
        description_text=[description_text substringToIndex:112];
        description_text = [description_text stringByAppendingString:@"..."];
    }
    CGFloat textLength = description_text.length;
    description_text = [description_text stringByAppendingString:@"   Read More"];

    CommonDynamicCellModel *titleDetails = [[CommonHelperClass sharedConstants] calculateLabelMaxSize:description_text with:[UIFont systemFontOfSize:12.5f] with:previousView.frame.size.width];

    [[mainBGView viewWithTag:9994] removeFromSuperview];
    // Create date label
    STTweetLabel *desLabel = [[STTweetLabel alloc] initWithFrame:CGRectMake(previousView.frame.origin.x, previousView.frame.origin.y+ previousView.frame.size.height + 10, previousView.frame.size.width, titleDetails.maxSize.height > 50 ? 50 : titleDetails.maxSize.height)];
    [desLabel setTag:9994];
    desLabel.lineBreakMode = NSLineBreakByWordWrapping;
    desLabel.numberOfLines = 0;
    [desLabel setTextColor:[UIColor grayColor]];
    [desLabel setFont:titleDetails.maxFont];
    [desLabel setBackgroundColor:[UIColor clearColor]];
    [mainBGView addSubview:desLabel];
    [desLabel setDetectionBlock:^(STTweetHotWord hotWord, NSString *string, NSString *protocol, NSRange range) {
        //[self openExternalBrowserWithURL:string];
    }];

    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", description_text]];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(textLength, 12)];
    desLabel.attributedText = attrStr;
    
    return desLabel;
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
