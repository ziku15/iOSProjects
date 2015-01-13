//
//  OfferAndPromotionsDetailsViewController.h
//  Pulse
//
//  Created by Supran on 6/19/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OfferItem.h"

@interface OfferAndPromotionsDetailsViewController : CommonViewController

@property (nonatomic, strong)     OfferItem *detailsItem;
@property(nonatomic) NSInteger selectedIndex;

-(id)init:(OfferItem *)item with:(NSInteger)index;
@end
