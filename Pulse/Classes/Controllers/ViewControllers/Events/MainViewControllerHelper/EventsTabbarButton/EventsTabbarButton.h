//
//  EventsTabbarButton.h
//  Pulse
//
//  Created by Supran on 6/23/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsTabbarButton : UIButton
-(void)setSelectedButtonViewChange;
-(void)setDeselectedButtonViewChange;
-(void)hideBubble;
-(void)showBubble;

- (id)initWithFrame:(CGRect)frame with:(int)button_tag shouldShowBubble:(BOOL)shouldShowBubble withLastIndex:(NSUInteger)lIndex;

-(void)setBubbleText:(NSString *)text;


//Classified
- (id)initForClassified:(CGRect)frame with:(int)button_tag;
@end
