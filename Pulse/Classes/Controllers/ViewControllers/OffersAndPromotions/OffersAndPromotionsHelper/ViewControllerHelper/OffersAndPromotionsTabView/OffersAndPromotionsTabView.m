//
//  OffersAndPromotionsTabView.m
//  Pulse
//
//  Created by Supran on 6/18/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "OffersAndPromotionsTabView.h"

@implementation OffersAndPromotionsTabView
@synthesize delegate;
@synthesize buttonArray;

- (id)initWithFrame:(CGRect)frame with:(id)parentReference
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDelegate:parentReference];
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];

        buttonArray = [[NSMutableArray alloc] init];
        tabScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [tabScrollview setShowsHorizontalScrollIndicator:NO];
        [self addSubview:tabScrollview];
        
        CGFloat x = 10;
        for (int i = 0; i < 4; i ++) {
            OffersAndPromotionsButton *tempButton = [OffersAndPromotionsButton buttonWithType:UIButtonTypeCustom];
            [tempButton setTag:i];
            [tempButton customDiselected];
            [tempButton customSetText:i];
        
            //   tempButton.backgroundColor = [UIColor grayColor];
            tempButton.titleLabel.numberOfLines = 2;
            tempButton.titleLabel.font = [UIFont systemFontOfSize:11.0];
            tempButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            
//            CGFloat width = [self calculateMaxSize:tempButton.titleLabel.text];
//            if (width <= 100) {
//                width = 80;
//            }
//            tempButton.frame = CGRectMake(x, 0, width+20, frame.size.height - 5);
            tempButton.frame = CGRectMake(x, 0, (tabScrollview.frame.size.width-17)/4, frame.size.height - 5);
            [tempButton addTarget:self
                       action:@selector(tabbedAction:)
             forControlEvents:UIControlEventTouchUpInside];

            [tabScrollview addSubview:tempButton];
            [tabScrollview setContentSize:CGSizeMake(tempButton.frame.origin.x + tempButton.frame.size.width , tempButton.frame.size.height)];
            [buttonArray addObject:tempButton];
            
            
            if (i == 3) {
                break;
            }
            
            UIView *separetorLineView = [[UIView alloc] init];
            [separetorLineView setBackgroundColor:[UIColor colorWithRed:(64.0/255.0) green:(70.0/255.0) blue:(78.0/255.0) alpha:1.0]];
            [separetorLineView setFrame:CGRectMake(x+tempButton.frame.size.width - 1, 0, 1, tempButton.frame.size.height)];
            [tabScrollview addSubview:separetorLineView];
            x = separetorLineView.frame.origin.x - 1+ separetorLineView.frame.size.width;
        }
        
        UIView *endLineView = [[UIView alloc] init];
        [endLineView setBackgroundColor:[UIColor lightGrayColor]];
        [endLineView setFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
        [self addSubview:endLineView];
        
        
        //Initialy select First tab
        OffersAndPromotionsButton *tempButton = [buttonArray objectAtIndex:0];
        [self resetScrollviewContent:tempButton.tag];
    }
    return self;
}

-(IBAction)tabbedAction:(id)sender{

    OffersAndPromotionsButton *tempButton = ( OffersAndPromotionsButton *)sender;
    if (!tempButton.selected) {
        [self resetScrollviewContent:tempButton.tag];
        
        [self callDelegate:tempButton.tag];
    }

    
}

-(void)callDelegate:(int)button_tag{
    // NSLog(@"sender tag: %d", button_tag);
    [self.delegate tabbedButtonAction:button_tag];
}

-(void)resetScrollviewContent:(int)button_tag{
    for (int i = 0; i < buttonArray.count ; i ++ ) {
        OffersAndPromotionsButton *button = [buttonArray objectAtIndex:i];
        
        if (button.tag==button_tag) {
            [button customSelected];
        }
        else{
            [button customDiselected];
        }
        
        [buttonArray replaceObjectAtIndex:i withObject:button];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(CGFloat)calculateMaxSize:(NSString *)maxText{
    
    CGSize maximumLabelSize = CGSizeMake(FLT_MAX, FLT_MAX);
    
    //fetch expected label frame size
    CGRect expectedLabelSize = [maxText boundingRectWithSize:maximumLabelSize
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{
                                                               NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f]
                                                               }
                                                     context:nil];
    
    return expectedLabelSize.size.width;
}


@end
