//
//  EventsTabbarButton.m
//  Pulse
//
//  Created by Supran on 6/23/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "EventsTabbarButton.h"

@implementation EventsTabbarButton{
    UIImageView *bubbleImage;
    UILabel *bubbleLabel;
    
    BOOL isClassified;
}


#pragma mark - For Classified

- (id)initForClassified:(CGRect)frame with:(int)button_tag
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        isClassified = YES;
        [self setTagForClassified:button_tag];
    }
    return self;
}
-(void)setTagForClassified:(NSInteger)tag{
    [super setTag:tag];
    
    [self customSetTextForClassified:tag];
    if (tag == 0) {
        self.layer.cornerRadius = 3;//half of the width
        [self setCustomBorder:UIRectCornerTopLeft | UIRectCornerBottomLeft with:self.layer.cornerRadius];
    }
    else{
        self.layer.cornerRadius = 3;
        [self setCustomBorder:UIRectCornerTopRight | UIRectCornerBottomRight with:self.layer.cornerRadius];
    }
}

//set text
-(void)customSetTextForClassified:(NSInteger)index{
    NSString *title = @"";
    if (index == 0) {
        title = @"All Classified";
    }
    else {
        title = @"Posted by Me";
    }
    
    //set font size
    [self.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self setTitle:title forState:UIControlStateNormal];
}

#pragma mark - For Events

- (id)initWithFrame:(CGRect)frame with:(int)button_tag shouldShowBubble:(BOOL)shouldShowBubble withLastIndex:(NSUInteger)lIndex{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setTag:button_tag withEndIndex:lIndex];
        
        if (shouldShowBubble) {
           [self setSelectedBubbleView:frame.size];
        }
        bubbleImage.hidden = YES;
        
    }
    return self;
}



-(void)setSelectedBubbleView:(CGSize)size{
    bubbleImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-12, -10, 20, 20)];
    [self addSubview:bubbleImage];
    
    bubbleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-12, -11, 20, 20)];
    //[bubbleLabel setText:@"1223"];
    [bubbleLabel setTextAlignment:NSTextAlignmentCenter];
    [bubbleLabel setBackgroundColor:[UIColor clearColor]];
    [bubbleLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    bubbleLabel.numberOfLines = 1;
    bubbleLabel.adjustsFontSizeToFitWidth = YES;
    bubbleLabel.center = CGPointMake(size.width/2.0f,size.height/2.0f);
    [self addSubview:bubbleLabel];

}

-(void)setTag:(NSInteger)tag withEndIndex:(NSInteger)lastTag{
    [super setTag:tag];
    
    [self customSetText:tag];
    if (tag == 0) {
        self.layer.cornerRadius = 3;//half of the width
        [self setCustomBorder:UIRectCornerTopLeft | UIRectCornerBottomLeft with:self.layer.cornerRadius];
    }
    else if (tag == lastTag){
        self.layer.cornerRadius = 3;
        [self setCustomBorder:UIRectCornerTopRight | UIRectCornerBottomRight with:self.layer.cornerRadius];
    }else{
        [self setCustomBorder:UIRectCornerAllCorners with:0.0f];
    }
}

-(void)setTag:(NSInteger)tag{
    [super setTag:tag];
    
    [self customSetText:tag];
    if (tag == 0) {
        self.layer.cornerRadius = 3;//half of the width
        [self setCustomBorder:UIRectCornerTopLeft | UIRectCornerBottomLeft with:self.layer.cornerRadius];
    }
    else if (tag == 1){
        
        [self setCustomBorder:UIRectCornerAllCorners with:0.0f];
    }
    else if (tag == 2){
        self.layer.cornerRadius = 3;
        [self setCustomBorder:UIRectCornerTopRight | UIRectCornerBottomRight with:self.layer.cornerRadius];
    }
}


//set Border
-(void)setCustomBorder:(UIRectCorner)corners with:(CGFloat)radius{
    UIBezierPath *shapePath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                    byRoundingCorners:corners
                                                          cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = shapePath.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = kViewBorderColor;
    shapeLayer.lineWidth = kViewBorderWidth;
    [self.layer addSublayer:shapeLayer];
}

//set text
-(void)customSetText:(NSInteger)index{
    NSString *title = @"";
    if (index == 0) {
        title = @"Upcoming";
    }
    else if (index == 1) {
        title = @"My Events";
    }
    else {
        title = @"Past";
    }

    //set font size
    [self.titleLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [self setTitle:title forState:UIControlStateNormal];
}

-(void)changeButtonColor:(UIColor*)color{
    UIRectCorner corners;
    CGFloat radius;
    if (self.tag == 0) {
        corners = UIRectCornerTopLeft | UIRectCornerBottomLeft;
        radius = 3.0f;
    }
    else if(self.tag == 1){
        corners = UIRectCornerAllCorners;
        radius = 0.0f;
        
        if (isClassified) {
            corners = UIRectCornerTopRight | UIRectCornerBottomRight;
            radius = 3.0f;
        }
    }
    else{
        corners = UIRectCornerTopRight | UIRectCornerBottomRight;
        radius = 3.0f;
    }
    
    UIBezierPath *shapePath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                    byRoundingCorners:corners
                                                          cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = shapePath.CGPath;
    shapeLayer.fillColor = color.CGColor;
    shapeLayer.strokeColor = kViewBorderColor;
    shapeLayer.lineWidth = kViewBorderWidth;
    [self.layer addSublayer:shapeLayer];
    [self bringSubviewToFront:self.titleLabel];

}
//set selected condition
-(void)setSelectedButtonViewChange{
    [self setSelected:YES];
//    [self setBackgroundColor:[UIColor sidraFlatTurquoiseColor]];
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self changeButtonColor:[UIColor sidraFlatTurquoiseColor]];
    
    if (bubbleLabel != nil) {
        [bubbleLabel setTextColor:[UIColor sidraFlatRedColor]];
        [bubbleImage setImage:[UIImage imageNamed:@"events_selected_bubble.png"]];
    }

}


//set deselected condition
-(void)setDeselectedButtonViewChange{
    [self setSelected:NO];
//    [self setBackgroundColor:[UIColor whiteColor]];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self changeButtonColor:[UIColor whiteColor]];


    if (bubbleLabel != nil) {
        [bubbleLabel setTextColor:[UIColor whiteColor]];
        [bubbleImage setImage:[UIImage imageNamed:@"events_unselected_bubble.png"]];
    }

}

//hide bubble
-(void)hideBubble{
    [bubbleLabel setHidden:YES];
    [bubbleImage setHidden:YES];
}
//show bubble
-(void)showBubble{
    [bubbleLabel setHidden:NO];
    [bubbleImage setHidden:NO];
}

-(void)setBubbleText:(NSString *)text{
    [bubbleLabel setText:text];
}
@end
