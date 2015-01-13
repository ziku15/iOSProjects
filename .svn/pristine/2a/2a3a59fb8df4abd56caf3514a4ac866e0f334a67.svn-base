//
//  ClassifiedTabbarView.m
//  Pulse
//
//  Created by Supran on 7/7/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "ClassifiedTabbarView.h"

@implementation ClassifiedTabbarView
@synthesize buttonArray;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame with:(id)parentReferece
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setDelegate:parentReferece];
        buttonArray = [[NSMutableArray alloc] init];
        
        CGFloat x = 10;
        for (int i = 0; i < 2; i ++) {
            EventsTabbarButton *tempButton = [[EventsTabbarButton alloc] initForClassified:CGRectMake(x, 10, 150, 30) with:i];
            [tempButton setDeselectedButtonViewChange];
            [tempButton addTarget:self
                           action:@selector(tabbedClassifiedAction:)
                 forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:tempButton];
            
            [buttonArray addObject:tempButton];
            
            x = x+tempButton.frame.size.width;
        }
        
        
        EventsTabbarButton *tempButton = [buttonArray objectAtIndex:0];
        if (!tempButton.selected) {
            [self resetButtonCondition:tempButton.tag];
        }
        
        UIView *endLineView = [[UIView alloc] init];
        [endLineView setBackgroundColor:[UIColor lightGrayColor]];
        [endLineView setFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
        [self addSubview:endLineView];
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

-(IBAction)tabbedClassifiedAction:(id)sender{
    
    EventsTabbarButton *tempButton = ( EventsTabbarButton *)sender;
    if (!tempButton.selected) {
        [self resetButtonCondition:tempButton.tag];
        
        [self.delegate tabbedClassifiedAction:tempButton.tag];
    }
    
}

-(void)resetButtonCondition:(int)button_tag{
    for (int i = 0; i < buttonArray.count ; i ++ ) {
        EventsTabbarButton *button = [buttonArray objectAtIndex:i];
        
        if (button.tag==button_tag) {
            [button setSelectedButtonViewChange];
            [CommonHelperClass sharedConstants].classifiedTypeSelected = (button_tag == 0?1:0);
        }
        else{
            [button setDeselectedButtonViewChange];
        }
        
        [buttonArray replaceObjectAtIndex:i withObject:button];
    }
}

@end
