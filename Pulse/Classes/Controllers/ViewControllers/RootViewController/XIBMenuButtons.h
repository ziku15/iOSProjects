//
//  XIBMenuButtons.h
//  Pulse
//
//  Created by xibic on 5/30/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XIBMenuButtons : UIView
- (id)initWithFrame:(CGRect)frame withTitle:(NSString*)title andIcon:(NSString*)icon withSelector:(SEL)selector andTarget:(id)targetController;

- (void)showBadgeIconWithNumber:(int)n;
- (void)hideBadgeIcon;

@end
