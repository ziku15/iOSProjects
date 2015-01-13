//
//  XIBSearchBar.h
//  Pulse
//
//  Created by xibic on 6/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol XIBSearchBarDelegate <NSObject>

 @optional
- (void)searchResult:(NSArray*)resultArray forText:(NSString*)searchText;

@end

@interface XIBSearchBar : UIView

@property(nonatomic,retain) id<XIBSearchBarDelegate>delegate;

- (id)initWithFrame:(CGRect)frame withPlaceholderText:(NSString*)ptext;
- (void)updatePlaceHolderText:(NSString *)placeHolderTxt;
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
-(void)triggerSearchBar:(NSString *)searchText;

@end
