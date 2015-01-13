//
//  EventsCell.h
//  Pulse
//
//  Created by Supran on 6/25/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventDateSubview.h"
#import "EventItem.h"

@interface EventsCell : UITableViewCell{
    UIView *bgView;
}
@property (nonatomic, strong) UIButton *bookmarkButton;
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier with:(EventItem *)_dataModel;


-(EventDateSubview *)createEventDateView:(NSString *)startDate with:(NSString *)endDate;
-(void)createRightView:(EventDateSubview *)eventDateView withEventTitle:(NSString *)_eventTitle venue:(NSString *)_venue eventDescription:(NSString *)_eventDescription;
@end
