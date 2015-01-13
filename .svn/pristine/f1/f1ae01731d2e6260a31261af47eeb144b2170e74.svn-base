//
//  XIBUnderLinedButton.m
//  Pulse
//
//  Created by xibic on 6/11/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "XIBUnderLinedButton.h"

@implementation XIBUnderLinedButton


+ (XIBUnderLinedButton*) underlinedButton {
    XIBUnderLinedButton* button = [[XIBUnderLinedButton alloc] init];
    return button;
}

- (void) drawRect:(CGRect)rect {
    CGRect textRect = self.titleLabel.frame;
    
    // need to put the line at top of descenders (negative value)
    CGFloat descender = self.titleLabel.font.descender;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // set to same colour as text
    CGContextSetStrokeColorWithColor(contextRef, self.titleLabel.textColor.CGColor);
    
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender + 1.5 );
    
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender + 1.5);
    
    CGContextClosePath(contextRef);
    
    CGContextDrawPath(contextRef, kCGPathStroke);
}

-(void)setSelectedButtonTitleColorChange{
    [self setSelected:YES];
    [self setTitleColor:[UIColor sidraFlatBlueColor] forState:UIControlStateNormal];

    
}

-(void)setDeSelectedButtonTitleColorChange{
    [self setSelected:NO];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}


@end
