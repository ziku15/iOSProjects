//
//  AnnouncementCell.h
//  Pulse
//
//  Created by Supran on 6/17/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XIBFlatButtons.h"
#import "AnnouncementItem.h"
#import "CommonDynamicCellModel.h"


@interface AnnouncementCell : UITableViewCell

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier with:(AnnouncementItem *)dataModel;

+(CommonDynamicCellModel *)calculateMaxSize:(NSString *)maximumTitle;

-(UILabel *)createTitleView:(NSString *)_title;
-(UILabel *)createDateView:(NSString *)dateString previousView:(UILabel *)titleLabel;
-(void)createXIBFlatButton:(NSString *)cat_name previousView:(UILabel *)dateLabel;
@end
