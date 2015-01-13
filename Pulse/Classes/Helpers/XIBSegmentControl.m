//
//  XIBSegmentControl.m
//  Pulse
//
//  Created by xibic on 6/3/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "XIBSegmentControl.h"

@interface XIBSegmentControl(){
    
    UIColor *controlStateNormalColor;
    UIColor *controlStateSelectedColor;
    UIColor *textColor;
    
    int numberOfItems;
    int selectedIndex;
    
    CGSize buttonSize;
    
}
@end

@implementation XIBSegmentControl

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
      segmentTitles:(NSArray*)segmentTitles
      selectedIndex:(int)sindex
          withColor:(UIColor*)dcolor
      withTextColor:(UIColor*)tcolor
   andSelectedColor:(UIColor*)scolor{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        controlStateNormalColor = dcolor;
        controlStateSelectedColor = scolor;
        textColor = tcolor;
        
        numberOfItems = (int)[segmentTitles count];
        selectedIndex = sindex;
        
        buttonSize = CGSizeMake((frame.size.width/numberOfItems)*1.0f, frame.size.height);
        
        for (int i=0; i<numberOfItems; i++) {
            [self addSubview:[self buttonForItem:[segmentTitles objectAtIndex:i] withIndex:i]];
        }
        
    }
    
    return self;
}

- (UIButton*)buttonForItem:(NSString*)title withIndex:(int)i{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTag:i];
    [button addTarget:self action:@selector(segmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[self buttonImageFromColor:(i==selectedIndex?controlStateSelectedColor:controlStateNormalColor)] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(i*buttonSize.width, 0.0f, buttonSize.width, buttonSize.height)];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.textColor = textColor;
    
    UIBezierPath *maskPath;
    
    if (i==0) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds
                                         byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerTopLeft)
                                               cornerRadii:CGSizeMake(3.0, 3.0)];
    }
    else if (i==numberOfItems-1) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds
                                         byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerTopRight)
                                               cornerRadii:CGSizeMake(3.0, 3.0)];
    }else {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds
                                         byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerTopLeft)
                                               cornerRadii:CGSizeMake(0.0, 0.0)];
    }
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = button.bounds;
    maskLayer.path = maskPath.CGPath;
    button.layer.mask = maskLayer;
    
    return button;
}

- (void)segmentButtonAction:(id)sender{
    UIButton *selectedButton = (UIButton *)sender;
    [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn.tag == selectedButton.tag) {
                [btn setBackgroundImage:[self buttonImageFromColor:controlStateSelectedColor] forState:UIControlStateNormal];
                
            }else{
                [btn setBackgroundImage:[self buttonImageFromColor:controlStateNormalColor] forState:UIControlStateNormal];
                [btn setTitleColor:textColor forState:UIControlStateNormal];
            }
        }
        
    }];
    //Delegate Call
    [self.delegate selectedButtonAtIndex:(int)selectedButton.tag];
}

- (UIImage *)buttonImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


@end

