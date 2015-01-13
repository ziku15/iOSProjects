//
//  DepartmentItem.m
//  Pulse
//
//  Created by Atomix on 6/24/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "DepartmentItem.h"

@implementation DepartmentItem

- (id)initwithDictionary:(NSDictionary*)dic{
    if (self == [super init]) {
        
        self.itemID = [dic objectForKey:@"id"];
        self.deptName = [dic objectForKey:@"dept_name"];
        self.status = ([[dic valueForKey:@"status"] integerValue] == 1);
        self.createdDate = [dic objectForKey:@"created_at"];
        self.updatedDate = [dic objectForKey:@"updated_at"];
        
    }
    return self;
}

@end
