//
//  PolicyDetailsTabbarView.h
//  Pulse
//
//  Created by Ziku-Atomix on 10/27/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolicyDetailsButton.h"

@protocol PolicyDetailsTabViewDelegate <NSObject>
@optional
-(void)tabbedButtonAction:(int)button_tag;
@end


@interface PolicyDetailsTabbarView : UIView{
    UIScrollView *tabScrollview;
    
}

@property (nonatomic, strong) NSMutableArray *buttonArray;
- (id)initWithFrame:(CGRect)frame with:(id)parentReference;
@property (strong) id <PolicyDetailsTabViewDelegate> delegate;
@end
