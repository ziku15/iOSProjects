//
//  XIBMenuButtons.m
//  Pulse
//
//  Created by xibic on 5/30/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "XIBMenuButtons.h"
#import "XIBBadge.h"

#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT


@interface XIBMenuButtons()<UIGestureRecognizerDelegate>{
    BOOL isDraggable;
    XIBBadge *badgeIcon;
}
@end

@implementation XIBMenuButtons

- (id)initWithFrame:(CGRect)frame withTitle:(NSString*)title andIcon:(NSString*)icon withSelector:(SEL)selector andTarget:(id)targetController{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.cornerRadius = kViewCornerRadius;
        self.layer.borderColor = kViewBorderColor;
        self.layer.borderWidth = kViewBorderWidth;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
        CGRect tempFrame = imageView.frame;
        tempFrame.size.width = 37.0f;
        tempFrame.size.height = 37.0f;
        tempFrame.origin.x = frame.size.width/2.0f - tempFrame.size.width/2.0f;
        tempFrame.origin.y = frame.size.height/2.0f - tempFrame.size.height/2.0f - 10.0f;
        imageView.frame = tempFrame;
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, imageView.frame.size.height+20.0f, frame.size.width-0.0f, frame.size.height/2.0f)];
        [label setTextAlignment:NSTextAlignmentCenter];
        label.font = [UIFont boldSystemFontOfSize:10.0f];
        label.textColor = [UIColor sidraFlatDarkGrayColor];
        label.numberOfLines = 0;
        
        SWITCH (title) {
            CASE (@"Offers & Promotions") {
                label.text = @"Offers";
                break;
            }
            CASE (@"Human Resources") {
                label.text = @"HR";
                break;
            }
            DEFAULT {
                label.text = title;
                break;
            }
        }
        
        label.font=[label.font fontWithSize:13];
        
        [self addSubview:label];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:targetController action:selector];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:targetController action:@selector(handleDoubleTap:)];

        /*
        UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
        if (isDraggable) {
            UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            [self addGestureRecognizer:panGesture];
        }
         
        [doubleTap setNumberOfTapsRequired:2];
        [twoFingerTap setNumberOfTouchesRequired:2]
         */
        
        [singleTap setNumberOfTapsRequired:1];
        [singleTap requireGestureRecognizerToFail:doubleTap];

        [self addGestureRecognizer:singleTap];
        
        [self addBadgeIconWithFrame:CGRectMake(imageView.frame.size.width*2, imageView.frame.size.height-14, 18, 18)];
        
        
    }
    return self;
}

#pragma mark - Badge
- (void)addBadgeIconWithFrame:(CGRect)frame{
    badgeIcon = [[XIBBadge alloc] initWithFrame:frame];
    [self addSubview:badgeIcon];
    badgeIcon.alpha = 0;
}

- (void)showBadgeIconWithNumber:(int)n{
    badgeIcon.textLabel.text = [NSString stringWithFormat:@"%d",n];
    badgeIcon.alpha = 1;
}

- (void)hideBadgeIcon{
    badgeIcon.textLabel.text = @"";
    badgeIcon.alpha = 0;
}

#pragma mark Gesture Handling methods
- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    //[self.xibImageDelegate imageClicked:imageName];
    //[self.xibImageDelegate imageClicked:imageName imageID:self.imageID imageCategory:self.imageCategory];
}

-(void)handleSwipeLeft:(id)sender{
    //[self.xibImageDelegate xibImageViewswipeLeftAction];
}

-(void)handleSwipeRight:(id)sender{
    //[self.xibImageDelegate xibImageViewswipeRightAction];
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    
}

- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {
    
}

-(void)handlePan:(UIPanGestureRecognizer *)recognizer{
    
}

#pragma mark - GestureRecognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
