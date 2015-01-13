//
//  PolicyItem.m
//  Pulse
//
//  Created by xibic on 6/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "PolicyItem.h"

@implementation PolicyItem

- (id)initwithDictionary:(NSDictionary*)dic{
    if (self == [super init]) {
        
        self.itemID = [dic objectForKey:@"id"];
        self.catID = [dic objectForKey:@"cat_id"];
        self.title = [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
        self.PolicyNO = [dic objectForKey:@"policy_no"];
        
        self.overview = [NSString stringWithFormat:@"%@",[dic objectForKey:@"overview"]];
        self.policyStatement = [NSString stringWithFormat:@"%@",[dic objectForKey:@"policy_statement"]];
        self.definitions = [NSString stringWithFormat:@"%@",[dic objectForKey:@"definitions"]];
        self.reference = [NSString stringWithFormat:@"%@",[dic objectForKey:@"reference"]];
        
        
        self.isDraft = ([[dic valueForKey:@"is_draft"] integerValue] == 1);
        self.isDel = ([[dic valueForKey:@"is_del"] integerValue] == 1);
        
        
        self.createdBy = [dic objectForKey:@"created_by"];
        self.updatedBy = [dic objectForKey:@"updated_by"];
        self.createdDate = [dic objectForKey:@"created_at"];
        self.updatedDate = [dic objectForKey:@"updated_at"];

        
    }
    return self;
}

@end
