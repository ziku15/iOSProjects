//
//  OffersAndPromotionsCell.m
//  Pulse
//
//  Created by Supran on 6/18/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "OffersAndPromotionsCell.h"

@implementation OffersAndPromotionsCell
@synthesize bookmarkButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier //with:(OfferItem *)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        mainBGView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 310, 125)];
        [mainBGView setBackgroundColor:[UIColor whiteColor]];
        mainBGView.layer.borderColor = [UIColor sidraFlatGrayColor].CGColor;
        mainBGView.layer.borderWidth = kViewBorderWidth;
        mainBGView.layer.cornerRadius = kViewCornerRadius;
        [self addSubview:mainBGView];
        
        



    }
    return self;
}

-(AsyncImageView *)createTitleImageView:(NSString *)thumbs{
    [[self viewWithTag:999] removeFromSuperview];
    
    AsyncImageView *titleImageview = [[AsyncImageView alloc] initWithFrame:CGRectMake(5, 5, 115, 115)];
    [titleImageview setTag:999];
    [titleImageview setBackgroundColor:[UIColor clearColor]];
    titleImageview.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
    
    titleImageview.contentMode = kImageViewContentMode;
    titleImageview.image = [UIImage imageNamed:@"PlaceHolderImg.png"];
    titleImageview.clipsToBounds = YES;
    titleImageview.imageURL = [NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@",SERVER_BASE_IMAGE_URL,[NSString stringWithFormat:@"%@",thumbs]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [mainBGView addSubview:titleImageview];
    
    return titleImageview;
}

-(UILabel *)createTitleView:(NSString *)title previousView:(AsyncImageView *)titleImageview{
    [[self viewWithTag:1000] removeFromSuperview];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleImageview.frame.origin.x + 125, titleImageview.frame.origin.y , 170, 60)];
    [titleLabel setTag:1000];
    titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    titleLabel.numberOfLines = 0;
    titleLabel.adjustsFontSizeToFitWidth = NO;
    [titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [titleLabel setTextColor:[UIColor sidraFlatDarkGrayColor]];
    [titleLabel setText:title];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [mainBGView addSubview:titleLabel];
    
    return titleLabel;
}


-(void)createDateTitleView:(BOOL)isLongTermOffer validPariod:(NSString *)validPeriod preView:(UILabel *)titleLabel {
    NSString *dateTitle = @"";
    CGFloat width = 0.0f, width2 = 0.0f;

    
    [[self viewWithTag:1001] removeFromSuperview];
    [[self viewWithTag:1002] removeFromSuperview];
    
    if (isLongTermOffer) {
        dateTitle = @"Long Term Offer";
        width = 130.0f;
        width2 = 170.0f;
    }
    else{
        dateTitle = @"Available until:";
        width = 100.0f;
        width2 = 180.0f;
    }
    

    UILabel *dateTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height + 15, width, 20)];
    [dateTitleLabel setTag:1001];
    [dateTitleLabel setText:dateTitle];
    [dateTitleLabel setTextColor:[UIColor lightGrayColor]];
    [dateTitleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [dateTitleLabel setBackgroundColor:[UIColor clearColor]];
    [mainBGView addSubview:dateTitleLabel];
    
    if (!isLongTermOffer) {
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x , dateTitleLabel.frame.origin.y + 20, width2, 20)];
        [dateLabel setTag:1002];
        [dateLabel setText:[[CommonHelperClass sharedConstants] getDateNameFormat:validPeriod]];
        [dateLabel setTextColor:[UIColor colorWithRed:(214.0/255.0) green:(0.0/255.0) blue:(7.0/255.0) alpha:1.0]];
        [dateLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        [mainBGView addSubview:dateLabel];
    }
}

-(void)createBookmarkedButton{
    [bookmarkButton removeFromSuperview];
    bookmarkButton = nil;
    bookmarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bookmarkButton setFrame:CGRectMake(mainBGView.frame.size.width - 55.5 ,mainBGView.frame.size.height - 45.5, 45, 40)];
    [mainBGView addSubview:bookmarkButton];
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
