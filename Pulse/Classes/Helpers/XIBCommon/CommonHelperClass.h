//
//  CommonHelperClass.h
//  Pulse
//
//  Created by Supran on 6/24/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonDynamicCellModel.h"

#define IMAGE_SAVING_ERROR_MESSAGE @"There is an error in image saving in gallary, please try again"
#define DELETE_CLASSIFIED_TYPE @"3"
#define DELETE_MESSAGE @"Are you sure you want to delete your classified?"

@interface CommonHelperClass : NSObject

@property (nonatomic, readwrite) int classifiedTypeSelected;


+(CommonHelperClass*)sharedConstants;
-(NSString *)getDateNameFormat:(NSString *)dataString;
-(NSString *)getDateNameFormat2:(NSString *)dataString;
-(NSString *)getDateNameFormat3:(NSString *)dataString;

-(NSMutableArray *)findsDatesBetweenTwoSelectedDates:(NSString *)starString endDay:(NSString *)endString;
-(CommonDynamicCellModel *)calculateLabelMaxSize:(NSString *)maxText with:(UIFont *)maxFont with:(CGFloat)width;

-(NSString *)getBookmarkedImageName:(BOOL)isBookmarked;



-(NSString *)getDate:(NSString *)dataString;
-(NSString *)getDay:(NSString *)dataString;
-(NSString *)getTime:(NSString *)dataString;

-(NSString *)getSystemDate;


-(NSString *)getRemoteYear:(NSString *)dataString;
-(NSString *)getRemoteMonth:(NSString *)dataString;
-(NSString *)getRemoteMonthYear:(NSString *)dataString;
@end
