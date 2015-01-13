//
//  OfferCategoryItem.h
//  Pulse
//
//  Created by xibic on 6/24/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryItem : NSObject

@property(nonatomic,copy) NSString *itemID;
@property(nonatomic,copy) NSString *cat_id;
@property(nonatomic,copy) NSString *cat_name;

- (id)initwithDictionary:(NSDictionary*)dic;

//
@property(nonatomic,copy) NSString *date_value;

@end
