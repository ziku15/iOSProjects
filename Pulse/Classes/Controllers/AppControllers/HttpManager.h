//
//  HttpManager.h
//  Pulse
//
//  Created by xibic on 5/28/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpManager : NSObject

@property (nonatomic) BOOL  useSelfSignedSSLCertificates;
@property (nonatomic, copy) NSString *serverURL;

+ (HttpManager *)sharedManager;

@end
