//
//  OffersAndPromotionsTabView.h
//  Pulse
//
//  Created by Supran on 6/18/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "OffersAndPromotionsButton.h"

@protocol OffersAndPromotionsTabViewDelegate <NSObject>
@optional
-(void)tabbedButtonAction:(int)button_tag;
@end


@interface OffersAndPromotionsTabView : UIView{
    UIScrollView *tabScrollview;
    
}

@property (nonatomic, strong) NSMutableArray *buttonArray;
- (id)initWithFrame:(CGRect)frame with:(id)parentReference;
@property (strong) id <OffersAndPromotionsTabViewDelegate> delegate;
@end
