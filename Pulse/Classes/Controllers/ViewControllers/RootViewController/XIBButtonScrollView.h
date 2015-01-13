//
//  XIBButtonScrollView.h
//  Pulse
//
//  Created by xibic on 5/30/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol XIBButtonScrollViewDelegate <NSObject>

@optional
-(void)buttonClicked:(int)buttonId;
@end


@interface XIBButtonScrollView : UIView

@property (retain) id<XIBButtonScrollViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame withButtons:(NSArray*)buttonsArray andButtonSize:(CGSize)buttonSize;

- (void)showButtonNotificationsForButton:(int)buttonId withNumber:(int)number;
- (void)hideButtonNotificationsForButton:(int)buttonId;

@end
