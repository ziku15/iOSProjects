//
//  XIBSegmentControl.h
//  Pulse
//
//  Created by xibic on 6/3/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XIBSegmentControlDelegate <NSObject>

@required
- (void)selectedButtonAtIndex:(int)index;

@end

@interface XIBSegmentControl : UIView

@property (nonatomic,strong) id<XIBSegmentControlDelegate>delegate;

- (id)initWithFrame:(CGRect)frame segmentTitles:(NSArray*)segmentTitles selectedIndex:(int)sindex withColor:(UIColor*)dcolor withTextColor:(UIColor*)tcolor andSelectedColor:(UIColor*)scolor;

@end
