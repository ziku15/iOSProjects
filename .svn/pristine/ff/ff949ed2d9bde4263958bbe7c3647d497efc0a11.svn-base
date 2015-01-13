//
//  EventDateSubview.m
//  Pulse
//
//  Created by Supran on 6/25/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "EventDateSubview.h"

@implementation EventDateSubview

- (id)initWithFrame:(CGRect)frame with:(NSString *)start_date with:(NSString *)end_date
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 65, frame.size.height-20)];
        bgView.layer.cornerRadius = kViewCornerRadius;
        bgView.layer.masksToBounds = YES;
        bgView.layer.borderColor = kViewBorderColor;
        bgView.layer.borderWidth = kViewBorderWidth;
        [bgView setBackgroundColor:[UIColor sidraFlatLightGrayColor]];
        [self addSubview:bgView];
        
        
        //Multiple date Found
        CGRect startDateViewFrame = [self createTopDateView:CGRectMake(0, 0, bgView.frame.size.width, bgView.frame.size.height/2) with:start_date with:bgView];
        //Draw middle Line
        [self createMiddleLine:CGRectMake(startDateViewFrame.origin.x, startDateViewFrame.origin.y + startDateViewFrame.size.height, startDateViewFrame.size.width, 1) with:bgView];
        

        //Select which type view show
        NSMutableArray *dateArray = [[CommonHelperClass sharedConstants] findsDatesBetweenTwoSelectedDates:start_date endDay:end_date];
        if (dateArray.count > 1) {
            //Have difference between two date
            [self createBottomDateView:CGRectMake(startDateViewFrame.origin.x, startDateViewFrame.origin.y + startDateViewFrame.size.height + 1, startDateViewFrame.size.width, startDateViewFrame.size.height) with:end_date with:bgView];
        }
        else{
            //Same Date So create time view
            [self createBottomTimeView:CGRectMake(startDateViewFrame.origin.x, startDateViewFrame.origin.y + startDateViewFrame.size.height + 1, startDateViewFrame.size.width, startDateViewFrame.size.height) with:start_date with:end_date with:bgView];
        }
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

-(void)createMiddleLine:(CGRect)frame with:(UIView *)parentView{
    UIView *endLineView = [[UIView alloc] init];
    [endLineView setBackgroundColor:[UIColor sidraFlatGrayColor]];
    [endLineView setFrame:CGRectMake(frame.origin.x + 5, frame.origin.y, frame.size.width - 10, 1)];
    [parentView addSubview:endLineView];
}

-(void)createBottomTimeView:(CGRect)frame with:(NSString *)start_time with:(NSString *)end_time with:(UIView *)parentView{
    UIView *timeView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    [timeView setBackgroundColor:[UIColor clearColor]];
    [parentView addSubview:timeView];
    
    
    UILabel *topTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, timeView.frame.size.width, 15)];
    [topTimeLable setFont:[UIFont boldSystemFontOfSize:10.0f]];
    topTimeLable.textAlignment = NSTextAlignmentCenter;
    [topTimeLable setTextColor:[UIColor sidraFlatDarkGrayColor]];
    [topTimeLable setBackgroundColor:[UIColor clearColor]];
    [topTimeLable setText:[[CommonHelperClass sharedConstants] getTime:start_time]];
    [timeView addSubview:topTimeLable];
    
    
    UILabel *toLable = [[UILabel alloc] initWithFrame:CGRectMake(topTimeLable.frame.origin.x, topTimeLable.frame.origin.y + topTimeLable.frame.size.height, topTimeLable.frame.size.width, 8)];
    [toLable setFont:[UIFont boldSystemFontOfSize:8.0f]];
    toLable.textAlignment = NSTextAlignmentCenter;
    [toLable setTextColor:[UIColor sidraFlatDarkGrayColor]];
    [toLable setBackgroundColor:[UIColor clearColor]];
    [toLable setText:@"to"];
    [timeView addSubview:toLable];
    
    UILabel *bottomTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(toLable.frame.origin.x, toLable.frame.origin.y + toLable.frame.size.height, toLable.frame.size.width, 15)];
    [bottomTimeLable setFont:[UIFont boldSystemFontOfSize:10.0f]];
    bottomTimeLable.textAlignment = NSTextAlignmentCenter;
    [bottomTimeLable setTextColor:[UIColor sidraFlatDarkGrayColor]];
    [bottomTimeLable setBackgroundColor:[UIColor clearColor]];
    [bottomTimeLable setText:[[CommonHelperClass sharedConstants] getTime:end_time]];
    [timeView addSubview:bottomTimeLable];
    
}


-(CGRect)createTopDateView:(CGRect)frame with:(NSString *)dataString  with:(UIView *)parentView{
    UIView *dateView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    [dateView setBackgroundColor:[UIColor clearColor]];
    [parentView addSubview:dateView];
    
    UILabel *dateLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, dateView.frame.size.width, dateView.frame.size.height - 8)];
    [dateLable setFont:[UIFont boldSystemFontOfSize:22.0f]];
    dateLable.textAlignment = NSTextAlignmentCenter;
    [dateLable setTextColor:[UIColor sidraFlatBlueColor]];
    [dateLable setBackgroundColor:[UIColor clearColor]];
    [dateLable setText:[[CommonHelperClass sharedConstants] getDate:dataString]];
    [dateView addSubview:dateLable];
    

    
    UILabel *dayLable = [[UILabel alloc] initWithFrame:CGRectMake(dateLable.frame.origin.x, dateView.frame.size.height/2 + 5, dateView.frame.size.width, dateView.frame.size.height/2 - 5)];
    [dayLable setFont:[UIFont boldSystemFontOfSize:13.0f]];
    dayLable.textAlignment = NSTextAlignmentCenter;
    [dayLable setTextColor:[UIColor blackColor]];
    [dayLable setBackgroundColor:[UIColor clearColor]];
    [dayLable setText:[[CommonHelperClass sharedConstants] getDay:dataString]];
    [dateView addSubview:dayLable];
    
    

    return dateView.frame;
}



-(CGRect)createBottomDateView:(CGRect)frame with:(NSString *)dataString  with:(UIView *)parentView{
    UIView *dateView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y + 1, frame.size.width, frame.size.height)];
    [dateView setBackgroundColor:[UIColor clearColor]];
    [parentView addSubview:dateView];
    
    //Create Date Label
    UILabel *dateLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, dateView.frame.size.width, 22)];
    [dateLable setFont:[UIFont boldSystemFontOfSize:22.0f]];
    dateLable.textAlignment = NSTextAlignmentCenter;
    [dateLable setTextColor:[UIColor sidraFlatBlueColor]];
    [dateLable setBackgroundColor:[UIColor clearColor]];
    [dateLable setText:[[CommonHelperClass sharedConstants] getDate:dataString]];
    [dateView addSubview:dateLable];
    
    
    
    //Create Day Label
    UILabel *dayLable = [[UILabel alloc] initWithFrame:CGRectMake(dateLable.frame.origin.x, dateLable.frame.origin.y + dateLable.frame.size.height, dateView.frame.size.width, 16)];
    [dayLable setFont:[UIFont boldSystemFontOfSize:13.0f]];
    dayLable.textAlignment = NSTextAlignmentCenter;
    [dayLable setTextColor:[UIColor blackColor]];
    [dayLable setBackgroundColor:[UIColor clearColor]];
    [dayLable setText:[[CommonHelperClass sharedConstants] getDay:dataString]];
    [dateView addSubview:dayLable];
    
    return dateView.frame;
}




@end
