//
//  EventsTabbarView.h
//  Pulse
//
//  Created by Supran on 6/23/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsTabbarButton.h"

@protocol EventsTabbarViewDelegate <NSObject>
@optional
-(void)tabButtonAction:(int)button_tag;
@end

@interface EventsTabbarView : UIView
@property (strong) id <EventsTabbarViewDelegate> delegate;
@property (nonatomic, strong)     NSMutableArray *buttonArray;
- (id)initWithFrame:(CGRect)frame with:(id)parentReferece;
- (id)initWithFrame:(CGRect)frame with:(id)parentReferece withButtonTitle:(NSArray *)buttonTitles withLastIndex:(int)lastIndex;
-(void)setUpcomingBubbleText:(NSString *)text;

-(void)showBubbleNumber:(int)bubbleCount atButtonIndex:(int)buttonIndex;
-(void)hideBubbleAtButtonIndex:(int)buttonIndex;

-(void)resetButtonCondition:(int)button_tag;

@end
