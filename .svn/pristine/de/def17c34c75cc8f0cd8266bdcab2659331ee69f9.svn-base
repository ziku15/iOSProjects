//
//  StaffSearchView.h
//  Pulse
//
//  Created by xibic on 7/7/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StaffSearchViewDelegate <NSObject>

@optional
-(void)searchViewRemoved;
-(void)showingSearcViewOnScreen;

@end

@interface StaffSearchView : UIView

@property(nonatomic,strong) NSString *searchDept;
@property(nonatomic,strong) NSString *savedContact;

@property(nonatomic,retain) id<StaffSearchViewDelegate>delegate;

- (id)initWithPlaceholderText:(NSString*)ptext;
- (id)initWithFrame:(CGRect)frame withPlaceholderText:(NSString*)ptext;
- (void)updatePlaceHolderText:(NSString *)placeHolderTxt;
- (void)cancelButtonAction;
- (void)addSearchBar:(NSString*)ptext;


@end
