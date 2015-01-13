//
//  DepartmentItem.h
//  Pulse
//
//  Created by Atomix on 6/24/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DepartmentItem : NSObject

//API 5 : Staff Directory Departments

@property(nonatomic,copy) NSString *itemID;
@property(nonatomic,copy) NSString *deptName;
@property(nonatomic,readwrite) BOOL status;
@property(nonatomic,copy) NSString *createdDate;
@property(nonatomic,copy) NSString *updatedDate;

- (id)initwithDictionary:(NSDictionary*)dic;

@end
