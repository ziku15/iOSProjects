//
//  StaffItem.m
//  Pulse
//
//  Created by xibic on 6/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "StaffItem.h"

@implementation StaffItem

- (id)initwithDictionary:(NSDictionary*)dic{
    if (self == [super init]) {
        
        self.itemID = [dic objectForKey:@"id"];
        self.sidraUserID = [dic objectForKey:@"sidra_user_id"];
        self.name = [dic objectForKey:@"name"];
        self.deptID = [[dic valueForKey:@"dept_id"] integerValue];
        self.designation = [dic objectForKey:@"designation"];
        self.email = [dic objectForKey:@"email"];
        self.office = [dic objectForKey:@"office"];
        self.mobile = [dic objectForKey:@"mobile"];
        self.status = ([[dic valueForKey:@"status"] integerValue] == 1);
        self.createdDate = [dic objectForKey:@"created_at"];
        self.updatedDate = [dic objectForKey:@"updated_at"];
        self.isSaved = ([[dic valueForKey:@"is_bookmarked"] integerValue] == 1);
        self.departmentName = [dic objectForKey:@"dept_name"];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if( self != nil )
    {
        self.itemID = [decoder decodeObjectForKey:@"id"];
        self.sidraUserID = [decoder decodeObjectForKey:@"sidra_user_id"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.deptID = [decoder decodeIntForKey:@"dept_id"];
        self.designation = [decoder decodeObjectForKey:@"designation"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.office = [decoder decodeObjectForKey:@"office"];
        self.mobile = [decoder decodeObjectForKey:@"mobile"];
        self.status = [decoder decodeBoolForKey:@"status"];
        self.createdDate = [decoder decodeObjectForKey:@"created_at"];
        self.updatedDate = [decoder decodeObjectForKey:@"updated_at"];
        self.isSaved = [decoder decodeBoolForKey:@"is_bookmarked"];
        self.departmentName = [decoder decodeObjectForKey:@"dept_name"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.itemID forKey:@"id"];
    [encoder encodeObject:self.sidraUserID forKey:@"sidra_user_id"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeInt:self.deptID forKey:@"dept_id"];
    [encoder encodeObject:self.designation forKey:@"designation"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.office forKey:@"office"];
    [encoder encodeObject:self.mobile forKey:@"mobile"];
    [encoder encodeBool:self.status forKey:@"status"];
    [encoder encodeObject:self.createdDate forKey:@"created_at"];
    [encoder encodeObject:self.updatedDate forKey:@"updated_at"];
    [encoder encodeBool:self.isSaved forKey:@"is_bookmarked"];
    [encoder encodeObject:self.departmentName forKey:@"dept_name"];
}



@end
