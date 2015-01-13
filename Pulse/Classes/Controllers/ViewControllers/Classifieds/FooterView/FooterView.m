//
//  FooterView.m
//  Pulse
//
//  Created by Supran on 7/7/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "FooterView.h"

@implementation FooterView
@synthesize delegate;
@synthesize rightButton;

- (id)initWithFrame:(CGRect)frame withIdentity:(int)parentIdentity withParent:(id)instance
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        

        [self setDelegate:instance];
        
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(5, 5.0, 149, 40);
        [leftButton addTarget:self
                          action:@selector(leftButtonAction:)
                forControlEvents:UIControlEventTouchUpInside];
        if (parentIdentity == 0) {
            [leftButton setImage:[UIImage imageNamed:@"classified_discard_btn.png"] forState:UIControlStateNormal];
        }
        else if (parentIdentity == 1){
            [leftButton setImage:[UIImage imageNamed:@"classified_edit_btn.png"] forState:UIControlStateNormal];
        }
        else if (parentIdentity == 2){
            [leftButton setBackgroundImage:[UIImage imageNamed:@"cla_cancel_btn.png"] forState:UIControlStateNormal];
            leftButton.frame = CGRectMake(leftButton.frame.origin.x , leftButton.frame.origin.y, leftButton.frame.size.width , self.frame.size.height - 5);
        }

        [self addSubview:leftButton];
        
        rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(leftButton.frame.origin.x + leftButton.frame.size.width + 10, leftButton.frame.origin.y, leftButton.frame.size.width, leftButton.frame.size.height);
        [rightButton addTarget:self
                       action:@selector(rightButtonMethod:)
             forControlEvents:UIControlEventTouchUpInside];
        if (parentIdentity == 0) {
            [rightButton setImage:[UIImage imageNamed:@"classified_next_btn.png"] forState:UIControlStateNormal];
        }
        else if (parentIdentity == 1){
            [rightButton setImage:[UIImage imageNamed:@"classified_post_btn.png"] forState:UIControlStateNormal];
        }
        else if (parentIdentity == 2){
            [rightButton setBackgroundImage:[UIImage imageNamed:@"cla_ok_btn.png"] forState:UIControlStateNormal];
            rightButton.frame = CGRectMake(rightButton.frame.origin.x , rightButton.frame.origin.y, rightButton.frame.size.width , self.frame.size.height - 5);
        }

        [self addSubview:rightButton];
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

#pragma mark - button Action

-(IBAction)leftButtonAction:(id)sender{
//    [popupView openPopupAnimation];
    [self.delegate leftButtonAction];
}
-(IBAction)rightButtonMethod:(id)sender{
    [self.delegate rightButtonMethod];
}


@end
