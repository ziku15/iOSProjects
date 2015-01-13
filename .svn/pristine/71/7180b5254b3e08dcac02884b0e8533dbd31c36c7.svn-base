//
//  UserManager.m
//  Pulse
//
//  Created by xibic on 5/28/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "UserManager.h"
#import "SynthesizeSingleton.h"


static NSString *SETTING_USERNAME = @"SETTING_USERNAME";
static NSString *SETTING_PASSWORD = @"SETTING_PASSWORD";
static NSString *SETTING_USERMAIL = @"SETTING_USEREMAIL";
static NSString *SETTING_USERACCESSTOKEN = @"SETTING_USERACCESSTOKEN";
static NSString *SETTING_USERID = @"SETTING_USERID";



#pragma mark - interface
@interface UserManager()

DECLARE_SINGLETON_FOR_CLASS(UserManager)

@property (nonatomic, retain) NSUserDefaults *userDefaults;

@end


#pragma mark - imlementation
@implementation UserManager
SYNTHESIZE_SINGLETON_FOR_CLASS(UserManager)

@synthesize userDefaults = _userDefaults;



#pragma mark - init
- (id)init{
    if (self = [super init]){
        
        self.userDefaults = [NSUserDefaults standardUserDefaults];
        // Set some defaults for the first run of the application
        if (self.userName == NULL) {
            self.userName = @"";
            self.userPassword = @"";
            self.userEmail = @"invalidUser@invalidEmail.com";
            self.userAccessToken = @"invalidAccessToken";
            self.userID = @"0";
        }

        [self.userDefaults synchronize];
    }
    return self;
}



#pragma mark - User Info
- (NSString *)userName{
    return [self.userDefaults stringForKey:SETTING_USERNAME];
}

- (void)setUserName:(NSString *)value{
    [self.userDefaults setObject:value forKey:SETTING_USERNAME];
    [self.userDefaults synchronize];
}

- (NSString *)userPassword{
    return [self.userDefaults stringForKey:SETTING_PASSWORD];
}

- (void)setUserPassword:(NSString *)value{
    [self.userDefaults setObject:value forKey:SETTING_PASSWORD];
    [self.userDefaults synchronize];
}

- (NSString *)userEmail{
    return [self.userDefaults stringForKey:SETTING_USERMAIL];
}

- (void)setUserEmail:(NSString *)value{
    [self.userDefaults setObject:value forKey:SETTING_USERMAIL];
    [self.userDefaults synchronize];
}

- (NSString *)userAccessToken{
    return [self.userDefaults stringForKey:SETTING_USERACCESSTOKEN];
}

- (void)setUserAccessToken:(NSString *)userAccessToken{
    [self.userDefaults setObject:userAccessToken forKey:SETTING_USERACCESSTOKEN];
    [self.userDefaults synchronize];
}

- (NSString *)userID{
    return [self.userDefaults stringForKey:SETTING_USERID];
}

- (void)setUserID:(NSString *)userID{
    [self.userDefaults setObject:userID forKey:SETTING_USERID];
    [self.userDefaults synchronize];
}

#pragma mark - User Authentication
// Send name and pass to server to check for validity- return true if valid else false
- (BOOL)userAuthenticated{
    
    return FALSE;
}
#pragma mark - User LogIN
// Send name and pass to server to log in user- return true if successfull else false;
- (BOOL)logInUser{
    return TRUE;
}
#pragma mark - User LogOut
// Send name and pass to server to log out user- return true if successfull else false;
- (BOOL)logOutUser{
    return TRUE;
}


@end
