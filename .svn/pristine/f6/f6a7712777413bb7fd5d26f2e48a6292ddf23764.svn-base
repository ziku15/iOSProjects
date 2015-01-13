//
//  EventsTabbarView.m
//  Pulse
//
//  Created by Supran on 6/23/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "EventsTabbarView.h"

@implementation EventsTabbarView
@synthesize buttonArray;
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame with:(id)parentReferece withButtonTitle:(NSArray *)buttonTitles withLastIndex:(int)lastIndex{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setDelegate:parentReferece];
        buttonArray = [[NSMutableArray alloc] init];
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.showsHorizontalScrollIndicator = scrollView.showsVerticalScrollIndicator = NO;
        //scrollView.pagingEnabled = YES;
        scrollView.clipsToBounds = YES;
        [self addSubview:scrollView];
        
        CGFloat x = 10;
        for (int i = 0; i < [buttonTitles count]; i ++) {
            EventsTabbarButton *tempButton = [[EventsTabbarButton alloc] initWithFrame:CGRectMake(x, 10, 100, 30) with:i shouldShowBubble:i==[buttonTitles count]-1?YES:NO withLastIndex:lastIndex];
            [tempButton setDeselectedButtonViewChange];
            [tempButton addTarget:self
                           action:@selector(tabbedAction:)
                 forControlEvents:UIControlEventTouchUpInside];
            
            [tempButton.titleLabel setFont:[UIFont systemFontOfSize:11.0f]];
            [tempButton setTitle:[buttonTitles objectAtIndex:i] forState:UIControlStateNormal];
            
            [scrollView addSubview:tempButton];
            scrollView.contentSize = CGSizeMake(scrollView.contentSize.width + tempButton.frame.size.width, scrollView.frame.size.height);
            
            [buttonArray addObject:tempButton];
            
            x = x+tempButton.frame.size.width;
        }
        
        //        [self tabbedAction:[buttonArray objectAtIndex:0]];
        EventsTabbarButton *tempButton = [buttonArray objectAtIndex:0];
        if (!tempButton.selected) {
            [self resetButtonCondition:(int)tempButton.tag];
        }
        
        
        UIView *endLineView = [[UIView alloc] init];
        [endLineView setBackgroundColor:[UIColor sidraFlatLightGrayColor]];
        [endLineView setFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
        [self addSubview:endLineView];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame with:(id)parentReferece
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setDelegate:parentReferece];
        buttonArray = [[NSMutableArray alloc] init];
        
        
        CGFloat x = 10;
        for (int i = 0; i < 3; i ++) {
            EventsTabbarButton *tempButton = [[EventsTabbarButton alloc] initWithFrame:CGRectMake(x, 10, 100, 30) with:i shouldShowBubble:NO withLastIndex:2];
            [tempButton setDeselectedButtonViewChange];
            [tempButton addTarget:self
                           action:@selector(tabbedAction:)
                 forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:tempButton];
            [buttonArray addObject:tempButton];
            
            x = x+tempButton.frame.size.width;
        }
        
//        [self tabbedAction:[buttonArray objectAtIndex:0]];
        EventsTabbarButton *tempButton = [buttonArray objectAtIndex:0];
        if (!tempButton.selected) {
            [self resetButtonCondition:(int)tempButton.tag];
        }
        
        
        UIView *endLineView = [[UIView alloc] init];
        [endLineView setBackgroundColor:[UIColor sidraFlatLightGrayColor]];
        [endLineView setFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
        [self addSubview:endLineView];
    }
    return self;
}

-(void)setUpcomingBubbleText:(NSString *)text{
    EventsTabbarButton *tempButton = [buttonArray objectAtIndex:0];
    [tempButton setBubbleText:text];
}

-(void)showBubbleNumber:(int)bubbleCount atButtonIndex:(int)buttonIndex{
    EventsTabbarButton *tempButton = [buttonArray objectAtIndex:buttonIndex];
    [tempButton showBubble];
    [tempButton setBubbleText:[NSString stringWithFormat:@"%d",bubbleCount]];
}
-(void)hideBubbleAtButtonIndex:(int)buttonIndex{
    EventsTabbarButton *tempButton = [buttonArray objectAtIndex:buttonIndex];
    [tempButton hideBubble];
}

-(IBAction)tabbedAction:(id)sender{
    
    EventsTabbarButton *tempButton = ( EventsTabbarButton *)sender;
    if (!tempButton.selected) {
        [self resetButtonCondition:(int)tempButton.tag];
        
        [self.delegate tabButtonAction:(int)tempButton.tag];
    }
//    else{
//        [self.delegate tabButtonAction:tempButton.tag];
//    }

}

-(void)resetButtonCondition:(int)button_tag{
    for (int i = 0; i < buttonArray.count ; i ++ ) {
        EventsTabbarButton *button = [buttonArray objectAtIndex:i];
        
        if (button.tag == button_tag) {
            [button setSelectedButtonViewChange];
        }
        else{
            [button setDeselectedButtonViewChange];
        }
        
        [buttonArray replaceObjectAtIndex:i withObject:button];
    }
}
@end
