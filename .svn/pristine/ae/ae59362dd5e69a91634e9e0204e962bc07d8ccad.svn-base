//
//  PostedByMeCell.h
//  Pulse
//
//  Created by Supran on 7/9/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassifiedItem.h"

@interface PostedByMeCell : UITableViewCell{
    UIView *mainBGView;
}
@property (nonatomic, strong) UIButton *delButton;
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier with:(ClassifiedItem *)model;


-(UIImageView *)createStatusView:(int)isDraft;
-(UILabel *)createTitleView:(UIImageView *)previousView with:(NSString *)title;
-(UILabel *)createDateView:(UILabel *)previousView with:(NSString *)date_time;
-(void)createDescriptionView:(UILabel *)previousView with:(NSString *)description_text;
@end
