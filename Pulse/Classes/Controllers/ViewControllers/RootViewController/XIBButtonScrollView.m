//
//  XIBButtonScrollView.m
//  Pulse
//
//  Created by xibic on 5/30/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "XIBButtonScrollView.h"
#import "XIBMenuButtons.h"

#define BLANK_SPACE_BETWEEN_BUTTONS_H 18
#define BLANK_SPACE_BETWEEN_BUTTONS_W 20

@interface XIBButtonScrollView()<UIScrollViewDelegate,UIGestureRecognizerDelegate>{
    UIScrollView *buttonContainerScrollView;
    CGSize _buttonSize;
    UIPageControl *pageController;
    
    NSMutableArray *menuButtonBin;
    
}

@end

@implementation XIBButtonScrollView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame withButtons:(NSArray*)buttonsArray andButtonSize:(CGSize)buttonSize{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.backgroundColor = [UIColor flatAlizarinColor];
        
        _buttonSize = buttonSize;
        
        //int numberOfButtons = [_buttonsArray count];
        //int buttonWidth = _buttonSize.width;
        //int buttonHeight = _buttonSize.height;
        int numberOfButtonPerRow = IPHONE_5?3:3;
        int numberOfButtonPerColumn = 2;
        
        int buttonIndex = 0;
        
        buttonContainerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        buttonContainerScrollView.showsHorizontalScrollIndicator = NO;
        buttonContainerScrollView.showsVerticalScrollIndicator = NO;
        buttonContainerScrollView.pagingEnabled = YES;
        buttonContainerScrollView.delegate = self;
        buttonContainerScrollView.bounces = NO;
        
        menuButtonBin = [[NSMutableArray alloc] initWithCapacity:[buttonsArray count]];
        
        int numberOfViews = 2;
        for (int i=0; i<numberOfViews; i++) {
            UIView *buttonContainerView = [[UIView alloc] initWithFrame:CGRectMake(i*buttonContainerScrollView.frame.size.width,
                                                                                   0.0f,
                                                                                   buttonContainerScrollView.frame.size.width,
                                                                                   buttonContainerScrollView.frame.size.height)];
            [buttonContainerScrollView addSubview:buttonContainerView];
            buttonContainerScrollView.contentSize = CGSizeMake(buttonContainerScrollView.contentSize.width+buttonContainerView.frame.size.width, buttonContainerScrollView.frame.size.height);
            
            
            for (int i=0; i<numberOfButtonPerRow; i++) {
                
                int yPoint = _buttonSize.height*i + BLANK_SPACE_BETWEEN_BUTTONS_H*i+BLANK_SPACE_BETWEEN_BUTTONS_H;
                yPoint -= (IPHONE_5?0:i*10);
                for (int j=0; j<numberOfButtonPerColumn; j++) {
                    int xPoint = _buttonSize.width*j + BLANK_SPACE_BETWEEN_BUTTONS_W*j+BLANK_SPACE_BETWEEN_BUTTONS_W;
                    //xPoint += (j==0?5:0);
                    if (buttonIndex<11) {
                        NSDictionary *dic = [buttonsArray objectAtIndex:buttonIndex++];
                        NSString *title = [[dic allKeys] objectAtIndex:0];
                        NSString *icon = [dic objectForKey:title];
                        
                        XIBMenuButtons *buttonView = [[XIBMenuButtons alloc]
                                                initWithFrame:CGRectMake(xPoint, yPoint, _buttonSize.width, _buttonSize.height)
                                                withTitle:title
                                                andIcon:icon
                                                withSelector:@selector(handleSingleTap:)
                                                andTarget:self
                                                      ];
                        buttonView.tag = buttonIndex;
                        
                        [buttonContainerView addSubview:buttonView];
                        [menuButtonBin addObject:buttonView];
                    }
                    
                }
            }
            
            
            
        }
        
        [self addSubview:buttonContainerScrollView];
        
        
        CGRect f = CGRectMake(40.0f, self.frame.size.height-(IPHONE_5?60.0f:90.0f), 240.0f, 20.0f);
        pageController = [[UIPageControl alloc] initWithFrame:f];
        pageController.numberOfPages = numberOfViews;
        pageController.currentPage = 0;
        if ([pageController respondsToSelector:@selector(setPageIndicatorTintColor:)]) {
            pageController.pageIndicatorTintColor = [UIColor grayColor];
            pageController.currentPageIndicatorTintColor = [UIColor whiteColor];
        }
        pageController.userInteractionEnabled = NO;
        [self addSubview:pageController];
        
        
    }
    return self;
}

#pragma mark - Button Tap Methods
- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    XIBMenuButtons *buttons = (XIBMenuButtons*)gestureRecognizer.view;
    [buttons hideBadgeIcon];
    [self.delegate buttonClicked:buttons.tag];
}

#pragma mark - upadate badge notification number
- (void)reloadButtonNotifications{
    [menuButtonBin enumerateObjectsUsingBlock:^(XIBMenuButtons *btn, NSUInteger idx, BOOL *stop) {
        if ([btn isKindOfClass:[XIBMenuButtons class]]) {
            [btn showBadgeIconWithNumber:arc4random()%200];
        }
        
    }];
}

- (void)showButtonNotificationsForButton:(int)buttonId withNumber:(int)number{
    [menuButtonBin enumerateObjectsUsingBlock:^(XIBMenuButtons *btn, NSUInteger idx, BOOL *stop) {
        if ([btn isKindOfClass:[XIBMenuButtons class]]) {
            if (btn.tag == buttonId) {
                [btn showBadgeIconWithNumber:number];
            }
        }
        
    }];
}

- (void)hideButtonNotificationsForButton:(int)buttonId{
    [menuButtonBin enumerateObjectsUsingBlock:^(XIBMenuButtons *btn, NSUInteger idx, BOOL *stop) {
        if ([btn isKindOfClass:[XIBMenuButtons class]]) {
            if (btn.tag == buttonId) {
                [btn hideBadgeIcon];
            }
        }
        
    }];
}


#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = buttonContainerScrollView.frame.size.width;
    int page = floor((buttonContainerScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageController.currentPage = page;
}


@end
