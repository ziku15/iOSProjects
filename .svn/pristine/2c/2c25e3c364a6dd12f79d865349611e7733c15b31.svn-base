//
//  AllClassifiedCell.h
//  Pulse
//
//  Created by Supran on 7/8/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#if (TARGET_OS_EMBEDDED || TARGET_OS_IPHONE)
#import <CoreText/CoreText.h>
#else
#import <AppKit/AppKit.h>
#endif

#import "ClassifiedItem.h"
#import <UIKit/UIKit.h>

@interface AllClassifiedCell : UITableViewCell

@property (nonatomic, strong) UIView *mainBGView;
@property (nonatomic, strong) UIButton *delButton;

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier with:(ClassifiedItem *)model;
-(UILabel *)createTitleView:(NSString *)title;
-(UILabel *)createDateView:(UILabel *)previousView with:(NSString *)date_time;
-(UIView *)createPostedByView:(UILabel *)previousView with:(NSString *)createdBy with:(NSArray *)_ownerInfo;
-(UILabel *)createDescriptionView:(UIView *)previousView with:(NSString *)description_text;
@end
