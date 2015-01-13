//
//  FooterView.h
//  Pulse
//
//  Created by Supran on 7/7/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FooterViewDelegate <NSObject>

@optional
-(void)leftButtonAction;
-(void)rightButtonMethod;
@end


@interface FooterView : UIView
@property (nonatomic,retain) id<FooterViewDelegate>delegate;

@property (nonatomic, weak) UIButton *rightButton;
- (id)initWithFrame:(CGRect)frame withIdentity:(int)parentIdentity withParent:(id)instance;

@end
