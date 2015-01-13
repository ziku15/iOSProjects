//
//  CommonHelperClass.m
//  Pulse
//
//  Created by Supran on 6/24/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "CommonHelperClass.h"

@implementation CommonHelperClass
@synthesize classifiedTypeSelected;

#pragma mark Singleton Methods
+(CommonHelperClass*)sharedConstants{
    static CommonHelperClass *mysharedConstants = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mysharedConstants = [[CommonHelperClass alloc] init];
        // Do any other initialisation stuff here
    });
    return mysharedConstants;
}


-(NSString *)getDateNameFormat:(NSString *)dataString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    //XLog(@"%@ %@", starString, endString);
    
    NSString *tar_date_str = @"";
    if (dataString.length > 0) {
        
        NSDate *targetDate=[dateFormatter dateFromString:dataString];
        [dateFormatter setDateFormat:@"MMMM dd, yyyy"];
        tar_date_str = [dateFormatter stringFromDate:targetDate];
    }

    
    if (tar_date_str == nil) {
        tar_date_str = @"";
    }
    
    return tar_date_str;
}

-(NSString *)getDateNameFormat2:(NSString *)dataString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    //XLog(@"%@ %@", starString, endString);
    
    NSString *tar_date_str = @"";
    if (dataString.length > 0) {
        
        NSDate *targetDate=[dateFormatter dateFromString:dataString];
        [dateFormatter setDateFormat:@"EEEE MMMM dd yyyy, HH:mm"];
        tar_date_str = [dateFormatter stringFromDate:targetDate];
    }

    
    if (tar_date_str == nil) {
        tar_date_str = @"";
    }
    
    return tar_date_str;
}

-(NSString *)getDateNameFormat3:(NSString *)dataString{
//    XLog(@"------------------------------------------------------------------------- Offer time ---------------------- %@", dataString);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    //XLog(@"%@ %@", starString, endString);
    
    NSString *tar_date_str = @"";
    if (dataString.length > 0) {
        
        NSDate *targetDate=[dateFormatter dateFromString:dataString];
        [dateFormatter setDateFormat:@"dd MMMM, yyyy"];
        tar_date_str = [dateFormatter stringFromDate:targetDate];
    }
    
    if (tar_date_str== nil) {
        tar_date_str = @"";
    }
    
    return tar_date_str;
}

-(NSMutableArray *)findsDatesBetweenTwoSelectedDates:(NSString *)starString endDay:(NSString *)endString {
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    NSDateComponents *components;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    //XLog(@"%@ %@", starString, endString);
    
    if (starString.length > 0 || endString.length > 0 ) {
        NSDate *startDate;// = [[NSDate alloc] init];
        startDate = [dateFormatter dateFromString:starString];
        
        NSDate *endDate;// = [[NSDate alloc] init];
        endDate = [dateFormatter dateFromString:endString];
        
        components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:startDate toDate:endDate options:0];
        
        int days = [components day];
        
        for (int x = 0; x <= days; x++) {
            //XLog(@"%@", [dateFormatter stringFromDate:startDate]);
            [dates addObject:[dateFormatter stringFromDate:startDate]];
            startDate = [startDate dateByAddingTimeInterval:(60 * 60 * 24)];
        }
        
    }
    
    
    //XLog(@"%@", dates);
    return dates;
}

-(CommonDynamicCellModel *)calculateLabelMaxSize:(NSString *)maxText with:(UIFont *)maxFont with:(CGFloat)width{
    maxText = [NSString stringWithFormat:@"%@",maxText];

    CGSize maximumLabelSize = CGSizeMake(width, FLT_MAX);
    
    //fetch expected label frame size
//    CGRect expectedLabelSize = [maxText boundingRectWithSize:maximumLabelSize
//                                                     options:NSStringDrawingUsesLineFragmentOrigin
//                                                  attributes:@{
//                                                               NSFontAttributeName: maxFont
//                                                               }
//                                                     context:nil];
//    
    
    
    
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:maxText
     attributes:@
     {
     NSFontAttributeName: maxFont
     }];
    CGRect expectedLabelSize = [attributedText boundingRectWithSize:maximumLabelSize
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                            context:nil];
    

    
    CommonDynamicCellModel *item = [[CommonDynamicCellModel alloc] init];
    item.maxTitle = maxText;
    item.maxSize = expectedLabelSize.size;
    item.maxFont = maxFont;
    
    
    return item;
}

#pragma mark - Common method
-(NSString *)getSystemDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSString *tar_date_str = @"";
    NSDate *startDate = [[NSDate alloc] init];
    [dateFormatter setDateFormat:@"MMMM dd, yyyy"];
    tar_date_str = [dateFormatter stringFromDate:startDate];

    return tar_date_str;
}

-(NSString *)getBookmarkedImageName:(BOOL)isBookmarked{
    NSString *bookmarkedImageName = @"";
    if (isBookmarked) {
        bookmarkedImageName = @"star_icon.png";
    }
    else{
        bookmarkedImageName = @"star_gray_icon.png";
    }
    return bookmarkedImageName;
}

#pragma mark - Extract Date Value Method
//yyyy-MM-dd HH:mm:ss
-(NSString *)getDate:(NSString *)dataString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSString *tar_date_str = @"";
    if (dataString.length > 0) {
        
        NSDate *targetDate=[dateFormatter dateFromString:dataString];
        [dateFormatter setDateFormat:@"dd"];
        tar_date_str = [dateFormatter stringFromDate:targetDate];
    }
    
    return tar_date_str;
}

-(NSString *)getDay:(NSString *)dataString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSString *tar_date_str = @"";
    if (dataString.length > 0) {
        
        NSDate *targetDate=[dateFormatter dateFromString:dataString];
        [dateFormatter setDateFormat:@"EEE"];
        //        [dateFormatter setDateFormat:@"EEEE MMMM dd yyyy, HH:mm"];
        tar_date_str = [dateFormatter stringFromDate:targetDate];
    }
    
    return tar_date_str;
}

-(NSString *)getTime:(NSString *)dataString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSString *tar_date_str = @"";
    if (dataString.length > 0) {
        
        NSDate *targetDate=[dateFormatter dateFromString:dataString];
        [dateFormatter setDateFormat:@"HH:mm"];
        tar_date_str = [dateFormatter stringFromDate:targetDate];
    }
    
    return tar_date_str;
}

#pragma mark - Event

-(NSString *)getRemoteYear:(NSString *)dataString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];

    NSString *tar_date_str = @"";
    if (dataString.length > 0) {
        NSDate *date = [dateFormatter dateFromString:dataString];
        [dateFormatter setDateFormat:@"yyyy"];
        tar_date_str    = [dateFormatter stringFromDate:date];
    }
    
    
    return tar_date_str;
}

-(NSString *)getRemoteMonth:(NSString *)dataString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSString *tar_date_str = @"";
    if (dataString.length > 0) {
        NSDate *date = [dateFormatter dateFromString:dataString];
        [dateFormatter setDateFormat:@"MM"];
        tar_date_str    = [dateFormatter stringFromDate:date];
    }
    
    
    return tar_date_str;
}

-(NSString *)getRemoteMonthYear:(NSString *)dataString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSString *tar_date_str = @"";
    if (dataString.length > 0) {
        NSDate *date = [dateFormatter dateFromString:dataString];
        [dateFormatter setDateFormat:@"MMMM yyyy"];
        tar_date_str = [dateFormatter stringFromDate:date];
    }
    
    
    return tar_date_str;
}
@end
