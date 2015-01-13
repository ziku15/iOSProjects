//
//  HttpManager.m
//  Pulse
//
//  Created by xibic on 5/28/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "HttpManager.h"
#import "SynthesizeSingleton.h"

static NSString *SETTING_SERVER_URL = @"SETTING_SERVER_URL";
static NSString *OLD_PREFERENCES_SERVER_URL = @"SETTING_OLD_SERVER_URL";
static NSString *SETTING_USE_SELF_SIGNED_CERTIFICATE = @"SETTING_USE_SELF_SIGNED_CERTIFICATE";



#pragma mark - interface
@interface HttpManager()

DECLARE_SINGLETON_FOR_CLASS(HttpManager)
@property (nonatomic, retain) NSUserDefaults *userDefaults;

@end


#pragma mark - imlementation
@implementation HttpManager
SYNTHESIZE_SINGLETON_FOR_CLASS(HttpManager)

@synthesize userDefaults = _userDefaults;



#pragma mark - init
- (id)init{
    if (self = [super init]){
        
        self.userDefaults = [NSUserDefaults standardUserDefaults];

        self.useSelfSignedSSLCertificates = NO;
        
        self.serverURL = SERVER_BASE_API_URL;
        
        [self.userDefaults synchronize];
    }
    return self;
}

#pragma mark - Server Info
- (NSString *)serverURL{
    return [self.userDefaults stringForKey:SETTING_SERVER_URL];
}

- (void)setServerURL:(NSString *)value{
    [self.userDefaults setObject:value forKey:SETTING_SERVER_URL];
    [self.userDefaults synchronize];
}

- (void)setUseSelfSignedSSLCertificates:(BOOL)value{
    [self.userDefaults setBool:value forKey:SETTING_USE_SELF_SIGNED_CERTIFICATE];
    [self.userDefaults synchronize];
}


@end
