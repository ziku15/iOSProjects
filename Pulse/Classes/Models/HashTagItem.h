//
//  HashTagItem.h
//  Pulse
//
//  Created by xibic on 7/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HashTagItem : NSObject
@property(nonatomic,copy) NSString *tagName;
@property(nonatomic,copy) NSString *postCount;

- (id)initwithDictionary:(NSDictionary*)dic;
@end
