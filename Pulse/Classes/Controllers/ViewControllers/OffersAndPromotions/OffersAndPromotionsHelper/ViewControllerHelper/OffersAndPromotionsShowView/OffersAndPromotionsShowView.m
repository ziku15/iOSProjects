//
//  OffersAndPromotionsShowView.m
//  Pulse
//
//  Created by Supran on 6/18/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "OffersAndPromotionsShowView.h"

@implementation OffersAndPromotionsShowView
@synthesize showTextField, selectButton;


- (id)initWithFrame:(CGRect)frame

{
    self = [super initWithFrame:frame];
    if (self) {

        
        // Initialization code
        
        UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, frame.size.width - 20, frame.size.height - 20)];
        [showView setBackgroundColor:[UIColor whiteColor]];
        showView.layer.cornerRadius = kViewCornerRadius;
        showView.layer.masksToBounds = YES;
        showView.layer.borderColor = kViewBorderColor;
        showView.layer.borderWidth = kViewBorderWidth;
        [self addSubview:showView];
        
        
        showTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 265, showView.frame.size.height)];
        [showTextField setBorderStyle:UITextBorderStyleNone];
        [showTextField setPlaceholder:@"Show All"];
        [showTextField setFont:[UIFont systemFontOfSize:14.0f]];
        showTextField.textColor = [UIColor lightGrayColor];
        [showView addSubview:showTextField];
        
        
        
        XIBFlatButtons *arrowButton = [XIBFlatButtons buttonWithType:UIButtonTypeCustom];
        arrowButton.frame = CGRectMake(showTextField.frame.origin.x + showTextField.frame.size.width, 0, 30, showTextField.frame.size.height);
        [arrowButton setImage:[UIImage imageNamed:@"dropdown_holdar.png"] forState:UIControlStateNormal];
        [showView addSubview:arrowButton];
        
        
        selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectButton setFrame:showView.frame];
        [self addSubview:selectButton];
        
        
        
    }
    return self;
}

- (id)initForClassified:(CGRect)frame

{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        // Initialization code
        
        UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, frame.size.width - 20, frame.size.height - 20)];
        [showView setBackgroundColor:[UIColor whiteColor]];
        showView.layer.cornerRadius = kViewCornerRadius;
        showView.layer.masksToBounds = YES;
        showView.layer.borderColor = kViewBorderColor;
        showView.layer.borderWidth = kViewBorderWidth;
        [self addSubview:showView];
        
        
        showTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, 265, showView.frame.size.height)];
        [showTextField setBorderStyle:UITextBorderStyleNone];
        [showTextField setPlaceholder:@"All Categories"];
        [showTextField setFont:[UIFont systemFontOfSize:14.0f]];
        showTextField.textColor = [UIColor lightGrayColor];
        [showView addSubview:showTextField];
        
        
        
        XIBFlatButtons *arrowButton = [XIBFlatButtons buttonWithType:UIButtonTypeCustom];
        arrowButton.frame = CGRectMake(showTextField.frame.origin.x + showTextField.frame.size.width, 0, 30, showTextField.frame.size.height);
        [arrowButton setImage:[UIImage imageNamed:@"dropdown_holdar.png"] forState:UIControlStateNormal];
        [showView addSubview:arrowButton];
        
        
        selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectButton setFrame:showView.frame];
        [self addSubview:selectButton];
        
        
        
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

@end
