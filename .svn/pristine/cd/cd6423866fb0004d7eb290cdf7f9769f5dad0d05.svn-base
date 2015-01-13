//
//  ClassifiedTabbarView.h
//  Pulse
//
//  Created by Supran on 7/7/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsTabbarButton.h"

@protocol ClassifiedTabbarViewDelegate <NSObject>
@optional
-(void)tabbedClassifiedAction:(int)button_tag;
@end

@interface ClassifiedTabbarView : UIView

@property (strong) id <ClassifiedTabbarViewDelegate> delegate;
@property (nonatomic, strong)     NSMutableArray *buttonArray;

- (id)initWithFrame:(CGRect)frame with:(id)parentReferece;
@end
