//
//  OffersAndPromotionsCell.h
//  Pulse
//
//  Created by Supran on 6/18/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OfferItem.h"


@interface OffersAndPromotionsCell : UITableViewCell{
    UIView *mainBGView;
}
@property (nonatomic, strong) UIButton *bookmarkButton;
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier with:(OfferItem *)model;

-(AsyncImageView *)createTitleImageView:(NSString *)thumbs;
-(UILabel *)createTitleView:(NSString *)title previousView:(AsyncImageView *)titleImageview;
-(void)createDateTitleView:(BOOL)isLongTermOffer validPariod:(NSString *)validPeriod preView:(UILabel *)titleLabel;
-(void)createBookmarkedButton;
@end
