//
//  XIBFlatButtons.m
//  Pulse
//
//  Created by xibic on 6/3/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "XIBFlatButtons.h"

@implementation XIBFlatButtons

- (id)init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    
    self.layer.cornerRadius = 3.5f;
    
}

@end
