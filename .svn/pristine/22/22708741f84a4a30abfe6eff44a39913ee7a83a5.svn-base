//
//  XIBCheckBox.m
//  Pulse
//
//  Created by xibic on 6/4/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "XIBCheckBox.h"

@implementation XIBCheckBox{
    UIButton *button;
}

- (id)initWithFrame:(CGRect)frame withSelector:(SEL)selector andTarget:(id)targetController{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:arc4random()%100];
        [button addTarget:targetController action:selector forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
        [button setFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        [self addSubview:button];
    }
    return self;
}

- (void)setCheckBoxSelected:(BOOL)selected{
    if (selected) {
        self.isSelected = YES;
        [button setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
    }else{
        self.isSelected = NO;
        [button setBackgroundImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    }
}

@end
