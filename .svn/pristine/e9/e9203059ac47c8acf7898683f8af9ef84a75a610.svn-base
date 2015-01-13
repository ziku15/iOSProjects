//
//  UserManager.h
//  Pulse
//
//  Created by xibic on 5/28/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userPassword;
@property (nonatomic, copy) NSString *userEmail;
@property (nonatomic, copy) NSString *userAccessToken;
@property (nonatomic, copy) NSString *userID;

+ (UserManager *)sharedManager;

- (BOOL)userAuthenticated; // Send name and pass to server to check for validity- return true if valid else false
- (BOOL)logInUser; // Send name and pass to server to log in user- return true if successfull else false;
- (BOOL)logOutUser; // Send name and pass to server to log out user- return true if successfull else false;

@end
