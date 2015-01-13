//
//  OffersAndPromotionsButton.m
//  Pulse
//
//  Created by Supran on 6/18/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "OffersAndPromotionsButton.h"

@implementation OffersAndPromotionsButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)changeButtonColor:(UIColor*)color{
    UIRectCorner corners;
    CGFloat radius;
    if (self.tag == 0) {
        corners = UIRectCornerTopLeft | UIRectCornerBottomLeft;
        radius = 3.0f;
    }
    else if(self.tag == 1 || self.tag == 2){
        corners = UIRectCornerAllCorners;
        radius = 0.0f;
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

-(void)customSelected{
    [self setSelected:YES];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self changeButtonColor:[UIColor sidraFlatTurquoiseColor]];
//    [self setBackgroundColor:[UIColor colorWithRed:(64.0/255.0) green:(70.0/255.0) blue:(78.0/255.0) alpha:1.0]];
}
-(void)customDiselected{
    [self setSelected:NO];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self changeButtonColor:[UIColor whiteColor]];
//    [self setBackgroundColor:[UIColor clearColor]];
}

-(void)customSetText:(NSInteger)index{
    NSString *title = @"";
    if (index == 0) {
        title = @"Expiring\nSoon";
    }
    else if (index == 1) {
        title = @"Latest\nAdded";
    }
    else if (index == 2) {
        title = @"Long-Term\nOffers";
    }
    else{
        title = @"My\nFavorites";
    }
    
    [self setTitle:title forState:UIControlStateNormal];
}


@end
