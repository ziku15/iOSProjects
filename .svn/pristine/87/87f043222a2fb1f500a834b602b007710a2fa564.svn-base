//
//  PopupView.m
//  Pulse
//
//  Created by Supran on 7/7/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//
#import "Constants.h"
#import "PopupView.h"

@implementation PopupView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame with:(id)instance
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        
        popupGoToFrame = CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height);
        popupGoFromFrame = CGRectMake(0, SCREEN_SIZE.height, SCREEN_SIZE.width, SCREEN_SIZE.height);
        
        [self setFrame:popupGoFromFrame];
        [self setDelegate:instance];
        [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.4f]];
        
        
        CGFloat alert_width = 280;
        CGFloat alert_height = 180;
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - alert_width/2, self.frame.size.height/2 - alert_height/2, alert_width, alert_height)];
        [alertView setBackgroundColor:[UIColor whiteColor]];
        alertView.layer.borderWidth = 1.0f;
        alertView.layer.borderColor = [UIColor sidraFlatGrayColor].CGColor;
        alertView.layer.cornerRadius = 3.0f;
        [self addSubview:alertView];
        
        
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, alertView.frame.size.width, 50)];
        [titleLabel setText:@"Confirm Navigation"];
        titleLabel.layer.borderWidth = 1.0f;
        titleLabel.layer.borderColor = [UIColor blackColor].CGColor;
        [titleLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
        [titleLabel setBackgroundColor:[UIColor whiteColor]];
        titleLabel.layer.cornerRadius = 3;
        [self setCustomBorder: UIRectCornerTopLeft|UIRectCornerTopRight with:titleLabel.layer.cornerRadius];
        [alertView addSubview:titleLabel];
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        closeButton.clipsToBounds = YES;
        [closeButton setBackgroundColor:[UIColor clearColor]];
        [closeButton setFrame:CGRectMake(titleLabel.frame.size.width - 37.0f, 0.0f, 50.0f,50.0f)];
        [closeButton setImage:[UIImage imageNamed:@"cla_close_btn.png"] forState:UIControlStateNormal];
        [closeButton addTarget:self
                        action:@selector(popupCloseButtonClick:)
              forControlEvents:UIControlEventTouchUpInside];
        [alertView addSubview:closeButton];
        
        
        UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.frame.size.height, alertView.frame.size.width, 80)];
        [desLabel setText:@"You have not posted the item yet. What do you want to do before leaving this page ? "];
        desLabel.lineBreakMode = NSLineBreakByWordWrapping;
        desLabel.numberOfLines = 0;
        desLabel.textAlignment = NSTextAlignmentCenter;
        [desLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        desLabel.textColor = [UIColor sidraFlatDarkGrayColor];
        [desLabel setBackgroundColor:[UIColor whiteColor]];
        [alertView addSubview:desLabel];
        
        
        
        //Create Cancle Button
        OBShapedButton *cancleButton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
        [cancleButton setBackgroundColor:[UIColor whiteColor]];
        [cancleButton setFrame:CGRectMake(0, desLabel.frame.origin.y + desLabel.frame.size.height + 10, alertView.frame.size.width / 2, 40)];
        [cancleButton addTarget:self
                         action:@selector(popupDiscardAction:)
               forControlEvents:UIControlEventTouchUpInside];
        [cancleButton setTitle:@"Discard" forState:UIControlStateNormal];
        [cancleButton setTitleColor:[UIColor sidraFlatDarkGrayColor] forState:UIControlStateNormal];
        //[cancleButton setImage:[UIImage imageNamed:@"cla_discard_btn.png"] forState:UIControlStateNormal];
        cancleButton.layer.cornerRadius = 3;
        [self setCustomBorder: UIRectCornerBottomLeft with:cancleButton.layer.cornerRadius];
        cancleButton.layer.borderWidth = 2.0f;
        cancleButton.layer.borderColor = [UIColor sidraFlatLightGrayColor].CGColor;
        [cancleButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [alertView addSubview:cancleButton];
        
        //Create Cancle Button
        OBShapedButton *saveButton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
        [saveButton setBackgroundColor:[UIColor whiteColor]];
        [saveButton setFrame:CGRectMake(cancleButton.frame.size.width, cancleButton.frame.origin.y, cancleButton.frame.size.width, cancleButton.frame.size.height)];
        [saveButton addTarget:self
                       action:@selector(popupSaveAction:)
             forControlEvents:UIControlEventTouchUpInside];
        [saveButton setTitle:@"Save" forState:UIControlStateNormal];
        [saveButton setTitleColor:[UIColor sidraFlatDarkGrayColor] forState:UIControlStateNormal];
 //       [saveButton setImage:[UIImage imageNamed:@"cla_save_btn.png"] forState:UIControlStateNormal];
        
        saveButton.layer.cornerRadius = 3;
        [self setCustomBorder: UIRectCornerBottomRight with:saveButton.layer.cornerRadius];
        saveButton.layer.borderWidth = 2.0f;
        saveButton.layer.borderColor = [UIColor sidraFlatLightGrayColor].CGColor;
        [saveButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [alertView addSubview:saveButton];
        
        
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
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

//****************************
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





#pragma mark - Button Action

-(IBAction)popupDiscardAction:(id)sender{
//    [self removeFromSuperview];
    [self.delegate popupDiscardAction];
}
-(IBAction)popupSaveAction:(id)sender{
//    [self removeFromSuperview];
    [self closePopupAnimation];
    [self.delegate popupSaveAction];
}
-(IBAction)popupCloseButtonClick:(id)sender{
    [self closePopupAnimation];
}


#pragma mark - Create Leave Popup view
-(void)openPopupAnimation{
    [UIView animateWithDuration:0.6f animations:^{
        [self setFrame:popupGoToFrame];
    } completion:^(BOOL finished) {
    }];
    
}

-(void)closePopupAnimation{
    [UIView animateWithDuration:0.6f animations:^{
        [self setFrame:popupGoFromFrame];
    } completion:^(BOOL finished) {
    }];
}

@end
