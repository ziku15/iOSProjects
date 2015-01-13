//
//  ServerManager.m
//  Pulse
//
//  Created by xibic on 6/20/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "ServerManager.h"
#import "SynthesizeSingleton.h"

#import "ServerDataParser.h"

#pragma mark - interface
@interface ServerManager(){
    Reachability *networkReachability;
}

DECLARE_SINGLETON_FOR_CLASS(ServerManager)

@end

#pragma mark - imlementation
@implementation ServerManager

SYNTHESIZE_SINGLETON_FOR_CLASS(ServerManager)

@synthesize isNetworkAvailable;

#pragma mark - init
- (id)init{
    if (self = [super init]){
    }
    return self;
}


/* ***** API ***** */

#pragma mark -  API - FUNC_ID: 1
- (void) checkForUserAuthentication:(api_Completion_Handler_Status)completion{
    //if ([self checkForNetworkAvailability]) {
        if ([[UserManager sharedManager].userName isEqualToString:@""]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(FALSE);
            });
        }else{
            NSString *parameterString = [NSString stringWithFormat:@"func_id=1&username=%@&password=%@&device_type=1&device_token=%@&registration_key=%@",
                                         [UserManager sharedManager].userName,
                                         [UserManager sharedManager].userPassword,
                                         [SettingsManager sharedManager].deviceToken,
                                         @"fakeRegistrationKey"
                                         ];
            XLog(@"API-1: %@",parameterString);
            
            dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
            
            dispatch_async(backgroundQueue, ^{
                
                [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                    
                    if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                        //Valid Data From Server
                        NSMutableArray *dataResult = [ServerDataParser validateUserAuthentication:responseDictionary];
                        
                        int status = [[dataResult objectAtIndex:0] integerValue];
                        
                        NSString *accessToken = [dataResult objectAtIndex:1];
                        NSString *pushSettings = [dataResult objectAtIndex:2];
                        NSString *userid = [dataResult objectAtIndex:3];
                        
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [UserManager sharedManager].userAccessToken = accessToken;
                            [UserManager sharedManager].userID = userid;
                            [SettingsManager sharedManager].pushSettings = pushSettings;
                            completion(status==1);
                        });
                        
                    }else{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completion(FALSE);
                        });
                        
                    }
                    
                }];
                
            });
        }
    //}else{
    //    [self showAlertForNoInternet];
    //}
    
}

#pragma mark -  API - FUNC_ID: 1
- (void) loginUser:(NSString*)userName password:(NSString*)userPass completion:(api_Completion_Handler_Data)completion{
    
    if ([self checkForNetworkAvailability]) {
        [XIBActivityIndicator startActivity];
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=1&username=%@&password=%@&device_type=1&device_token=%@&registration_key=%@",
                                     userName,
                                     userPass,
                                     [SettingsManager sharedManager].deviceToken,
                                     @"fakeRegistrationKey"
                                     ];
        XLog(@"API-1: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser validateUserAuthentication:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
    
}

#pragma mark -  API - FUNC_ID: 2
- (void) updatePushStatus:(NSString*)statusString completion:(api_Completion_Handler_Status)completion{
    
    if ([self checkForNetworkAvailability]) {
        [XIBActivityIndicator startActivity];
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=2&user_id=%@&access_token=%@&push_on=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken,
                                     statusString];
        XLog(@"API-2: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
    
}

#pragma mark -  API - FUNC_ID: 3
- (void) fetchAllNotifications:(api_Completion_Handler_Data)completion{
   
    if ([self checkForNetworkAvailability]) {
        NSString *parameterString = [NSString stringWithFormat:@"func_id=3&user_id=%@&access_token=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken];
        XLog(@"API-3: %@",parameterString);
        
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataMenuNotifications:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        //[XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        //[XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        //[self showAlertForNoInternet];
    }
    
}

#pragma mark -  API - FUNC_ID: 4
- (void) fetchAnnouncements:(NSString*)lastElementID scrollDirection:(NSString*)direction completion:(api_Completion_Handler_Data)completion{
    
    if ([self checkForNetworkAvailability]) {
        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator startActivity];
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=4&user_id=%@&access_token=%@&last_element_id=%@&direction=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken,
                                     lastElementID,
                                     direction];
        XLog(@"API-4: %@",parameterString);
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataAnnouncements:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
    
}

#pragma mark -  API - FUNC_ID: 5
- (void) fetchStaffDirectoryDepartments:(api_Completion_Handler_Data)completion{

    if ([self checkForNetworkAvailability]) {
        [XIBActivityIndicator startActivity];
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=5&user_id=%@&access_token=%@",[UserManager sharedManager].userID,[UserManager sharedManager].userAccessToken];
        XLog(@"API-5: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataStaffDirectoryDepartment:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }

}

#pragma mark -  API - FUNC_ID: 6
- (void) fetchStaffDirectoryStaffs:(NSString*)lastElementID deptID:(NSString*)deptID scrollDirection:(NSString*)direction completion:(api_Completion_Handler_Data)completion{
    
    if ([self checkForNetworkAvailability]) {
        
        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator startActivity];
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=6&user_id=%@&access_token=%@&dept_id=%@&last_element_id=%@&direction=%@",[UserManager sharedManager].userID,[UserManager sharedManager].userAccessToken,deptID,lastElementID,direction];
        XLog(@"API-6: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataStaffDirectoryStaffDetails:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
}

#pragma mark -  API - FUNC_ID: 7
- (void) fetchEvents:(NSString*)lastElementID type:(NSString*)type date:(NSString*)date scrollDirection:(NSString*)direction completion:(api_Completion_Handler_Data)completion{
    
    if ([self checkForNetworkAvailability]) {
        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator startActivity];
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=7&user_id=%@&access_token=%@&type=%@&date=%@&last_element_id=%@&direction=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken,
                                     type,
                                     date,
                                     lastElementID,
                                     direction];
        XLog(@"API-7: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataEvents:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
    
}

#pragma mark -  API - FUNC_ID: 8
- (void) favoriteEvent:(NSString*)isFav eventID:(NSString*)eventID completion:(api_Completion_Handler_Status)completion{
    
    if ([self checkForNetworkAvailability]) {
        [XIBActivityIndicator startActivity];
//        XLog(@"%@",isFav);
//        NSDictionary *parameterKeyValues = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                            @"func_id", @"8",
//                                            @"user_id", [UserManager sharedManager].userID,
//                                            @"access_token", [UserManager sharedManager].userAccessToken,
//                                            @"is_fav",isFav,
//                                            @"event_id",eventID,
//                                            nil];
        
        NSMutableDictionary *parameterKeyValues = [[NSMutableDictionary alloc] init];
        
        [parameterKeyValues setObject:@"8" forKey:@"func_id"];
        [parameterKeyValues setObject:[UserManager sharedManager].userID forKey:@"user_id"];
        [parameterKeyValues setObject:[UserManager sharedManager].userAccessToken forKey:@"access_token"];
        [parameterKeyValues setObject:isFav forKey:@"is_fav"];
        [parameterKeyValues setObject:eventID forKey:@"event_id"];
        
        
        XLog(@"%@",parameterKeyValues);
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithParams:parameterKeyValues withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
    
}

#pragma mark - API - FUNC_ID: 9
- (void) fetchGalleryAlbumList:(NSString*)pageIndex year:(NSString*)year completion:(api_Completion_Handler_Data)completion{

    if ([self checkForNetworkAvailability]) {
        
        if ([pageIndex integerValue]==1)[XIBActivityIndicator startActivity];
        
//        NSDictionary *parameterDic = @{
//                                       @"9":@"func_id",
//                                       [UserManager sharedManager].userID:@"user_id",
//                                       [UserManager sharedManager].userAccessToken:@"access_token",
//                                       year:@"year"
//                                       };
        
        NSMutableDictionary *parameterDic = [[NSMutableDictionary alloc] init];
        
        [parameterDic setObject:@"9" forKey:@"func_id"];
        [parameterDic setObject:[UserManager sharedManager].userID forKey:@"user_id"];
        [parameterDic setObject:[UserManager sharedManager].userAccessToken forKey:@"access_token"];
        [parameterDic setObject:year forKey:@"year"];
        
        
        
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithParams:parameterDic withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataGalleryAlbum:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        if ([pageIndex integerValue]==1)[XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        if ([pageIndex integerValue]==1)[XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
}

#pragma mark -  API - FUNC_ID: 10
- (void) fetchGalleryAlbumImageList:(NSString*)lastElementID galleryID:(NSString*)galleryID scrollDirection:(NSString*)direction completion:(api_Completion_Handler_Data)completion{

    if ([self checkForNetworkAvailability]) {
        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator startActivity];
        
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=10&user_id=%@&access_token=%@&gallery_id=%@&last_element_id=%@&direction=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken,
                                     galleryID,
                                     lastElementID,direction];
        XLog(@"API-10: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataGalleryAlbumDetails:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
    
}

#pragma mark -  API - FUNC_ID: 11
- (void) fetchSidraInNews:(NSString*)lastElementID scrollDirection:(NSString*)direction completion:(api_Completion_Handler_Data)completion{

    if ([self checkForNetworkAvailability]) {
        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator startActivity];
        
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=11&user_id=%@&access_token=%@&last_element_id=%@&direction=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken,
                                     lastElementID,direction];
        
        XLog(@"API-11: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataSidraInNews:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
}

#pragma mark -  API - FUNC_ID: 12
- (void) fetchPressReleases:(NSString*)lastElementID scrollDirection:(NSString*)direction completion:(api_Completion_Handler_Data)completion{
    
    if ([self checkForNetworkAvailability]) {
        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator startActivity];
        
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=12&user_id=%@&access_token=%@&last_element_id=%@&direction=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken,
                                     lastElementID, direction];
        XLog(@"API-12: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataPressRelease:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
    
}

#pragma mark -  API - FUNC_ID: 13
- (void) fetchHRCategory:(NSString*)pageIndex completion:(api_Completion_Handler_Data)completion{

    if ([self checkForNetworkAvailability]) {
        [XIBActivityIndicator startActivity];
        
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=13&user_id=%@&access_token=%@",[UserManager sharedManager].userID,[UserManager sharedManager].userAccessToken];
        XLog(@"API-13: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataHRCategories:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                       // [XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
}

#pragma mark -  API - FUNC_ID: 14
- (void) fetchHRDetails:(NSString*)lastElementID hrType:(NSString*)type scrollDirection:(NSString*)direction completion:(api_Completion_Handler_Data)completion{

    if ([self checkForNetworkAvailability]) {
        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator startActivity];
        
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=14&user_id=%@&access_token=%@&type=%@&last_element_id=%@&direction=%@",[UserManager sharedManager].userID,[UserManager sharedManager].userAccessToken,type,lastElementID,direction];
        XLog(@"API-14: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataHRList:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
}

#pragma mark -  API - FUNC_ID: 15
- (void) fetchOffersAndPromotions:(NSString*)lastElementID category:(NSString*)cat_id type:(NSString*)type scrollDirection:(NSString*)direction completion:(api_Completion_Handler_Data)completion{
    
    if ([self checkForNetworkAvailability]) {
        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator startActivity];
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=15&user_id=%@&access_token=%@&type=%@&cat_id=%@&last_element_id=%@&direction=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken,
                                     type,
                                     cat_id,
                                     lastElementID,
                                     direction];
        XLog(@"API-15: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataOffersAndPromotions:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
    
}

#pragma mark -  API - FUNC_ID: 16
- (void) favoriteOffersAndPromotions:(NSString*)offerID isFavorite:(NSString*)isFav completion:(api_Completion_Handler_Status)completion{
    
    if ([self checkForNetworkAvailability]) {
        [XIBActivityIndicator startActivity];
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=16&user_id=%@&access_token=%@&offer_id=%@&is_bookmark=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken,
                                     offerID,
                                     isFav];
        XLog(@"API-16: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
    
}

#pragma mark -  API - FUNC_ID: 17
- (void) fetchClassifieds:(NSString*)lastElementID type:(NSString*)type category:(NSString*)cat_id scrollDirection:(NSString*)direction completion:(api_Completion_Handler_Data)completion{

    if ([self checkForNetworkAvailability]) {
        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator startActivity];
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=17&user_id=%@&access_token=%@&cat_id=%@&type=%@&last_element_id=%@&direction=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken,
                                     cat_id,
                                     type,
                                     lastElementID,direction];
        
        XLog(@"API-17: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataClassifieds:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
}

#pragma mark -  API - FUNC_ID: 18
- (void) fetchClassifiedCategories:(api_Completion_Handler_Data)completion{
    
    if ([self checkForNetworkAvailability]) {
        [XIBActivityIndicator startActivity];
//        NSDictionary *parameterKeyValues = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                            @"func_id", @"18",
//                                            @"user_id", [UserManager sharedManager].userID,
//                                            @"access_token", [UserManager sharedManager].userAccessToken,
//                                            nil];
        
        NSMutableDictionary *parameterKeyValues = [[NSMutableDictionary alloc] init];
        
        [parameterKeyValues setObject:@"18" forKey:@"func_id"];
        [parameterKeyValues setObject:[UserManager sharedManager].userID forKey:@"user_id"];
        [parameterKeyValues setObject:[UserManager sharedManager].userAccessToken forKey:@"access_token"];
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithParams:parameterKeyValues withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataClassifiedCategories:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
}

#pragma mark -  API - FUNC_ID: 19
- (void) uploadClassifiedPhoto:(api_Completion_Handler_Status)completion{
    if ([self checkForNetworkAvailability]) {
    }else{
    }
   //Done -- using "CUploadImageView.h" class
}

#pragma mark -  API - FUNC_ID: 20
- (void) addClassifiedWithCatID:(NSString*)catID title:(NSString*)title description:(NSString*)description photo:(NSArray*)photos isDraft:(NSString*)isDraft completion:(api_Completion_Handler_Status)completion{
    
    if ([self checkForNetworkAvailability]) {
        [XIBActivityIndicator startActivity];
        
        NSString *photoString = @"";
        
        if (photos.count > 0) {
            photoString = [NSString stringWithFormat:@"%@",[photos objectAtIndex:0]];
            
            for (int i=1; i<[photos count]; i++) {
                photoString = [NSString stringWithFormat:@"%@,%@",photoString,[photos objectAtIndex:i]];
            }
            
        }
        
        
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=20&user_id=%@&access_token=%@&cat_id=%@&title=%@&description=%@&photo=%@&is_draft=%@",[UserManager sharedManager].userID,[UserManager sharedManager].userAccessToken,
                                     catID,title,description,photoString,isDraft ];
        
        XLog(@"API-20: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
    
    
}

#pragma mark -  API - FUNC_ID: 21
- (void) fetchForumTags:(NSString*)pageIndex completion:(api_Completion_Handler_Data)completion{}

#pragma mark -  API - FUNC_ID: 22
- (void) fetchForumPostList:(NSString*)lastElementID tagString:(NSString*)tagString type:(NSString*)type scrollDirection:(NSString*)direction completion:(api_Completion_Handler_Data)completion{
    
    if ([self checkForNetworkAvailability]) {
        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator startActivity];
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=22&user_id=%@&access_token=%@&tag_id=%@&type=%@&last_element_id=%@&direction=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken,
                                     tagString,
                                     type,
                                     lastElementID,
                                     direction];
        
        XLog(@"API-22: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [type isEqualToString:@"2"]?[ServerDataParser parseDataForumHashTag:responseDictionary]:[ServerDataParser parseDataForumPosts:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        if ([lastElementID isEqualToString:@""])[XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
}

#pragma mark -  API - FUNC_ID: 23
- (void) uploadForumThreadPhotos:(api_Completion_Handler_Status)completion{
    if ([self checkForNetworkAvailability]) {
    }else{
    }
    //Done -- using "FUploadImageView.h" class
}

#pragma mark -  API - FUNC_ID: 24
- (void) addForumThread:(NSString*)text tags:(NSArray*)tags photo:(NSArray*)photos completion:(api_Completion_Handler_Status)completion{
    
    if ([self checkForNetworkAvailability]) {
        [XIBActivityIndicator startActivity];
        
        NSString *photoString = @"";
        NSString *tagString = @"";
        
        if (photos.count > 0) {
            photoString = [NSString stringWithFormat:@"%@",[photos objectAtIndex:0]];
            
            for (int i=1; i<[photos count]; i++) {
                photoString = [NSString stringWithFormat:@"%@,%@",photoString,[photos objectAtIndex:i]];
            }
            
        }
        if (tags.count > 0) {
            tagString = [NSString stringWithFormat:@"%@",[tags objectAtIndex:0]];
            
            for (int i=1; i<[tags count]; i++) {
                tagString = [NSString stringWithFormat:@"%@,%@",tagString,[tags objectAtIndex:i]];
            }
            
        }
        
        
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=24&user_id=%@&access_token=%@&text=%@&tags=%@&photo=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken,
                                     text,
                                     tagString,
                                     photoString];
        
        XLog(@"API-24: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
}

#pragma mark -  API - FUNC_ID: 25
- (void) fetchPolicyDepartments:(api_Completion_Handler_Data)completion{
    
    if ([self checkForNetworkAvailability]) {
        [XIBActivityIndicator startActivity];
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=25&user_id=%@&access_token=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken ];
        
        XLog(@"API-25: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataPolicyDepartment:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
    
}

#pragma mark -  API - FUNC_ID: 26
- (void) fetchPolicyDetails:(NSString*)deptID completion:(api_Completion_Handler_Data)completion{

    if ([self checkForNetworkAvailability]) {
        [XIBActivityIndicator startActivity];
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=26&user_id=%@&access_token=%@&dept_id=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken,
                                     deptID];
        
        XLog(@"API-26: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataPolicyDepartmentDetails:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
    
}

#pragma mark -  API - FUNC_ID: 27
- (void) deleteItem:(NSString*)elementID type:(NSString*)type completion:(api_Completion_Handler_Status)completion{
    
    if ([self checkForNetworkAvailability]) {
        [XIBActivityIndicator startActivity];
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=27&user_id=%@&access_token=%@&element_id=%@&type=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken,
                                     elementID,
                                     type];
        XLog(@"API-27: %@",parameterString);
        
        
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    //NSMutableArray *resultDataArray = [ServerDataParser parseDataAnnouncements:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
    
}

#pragma mark -  API - FUNC_ID: 28
- (void) updateReadStatusForItem:(NSString*)elementID type:(NSString*)type completion:(api_Completion_Handler_Status)completion{
    if ([self checkForNetworkAvailability]) {
        NSString *parameterString = [NSString stringWithFormat:@"func_id=28&user_id=%@&access_token=%@&element_id=%@&type=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken,
                                     elementID,
                                     type];
        XLog(@"API-28: %@",parameterString);
        
        
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    //NSMutableArray *resultDataArray = [ServerDataParser parseDataAnnouncements:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE);
                        //[XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE);
                        //[XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        //[self showAlertForNoInternet];
    }
    
}
#pragma mark -  API - FUNC_ID: 29
- (void) fetchOffersAndPromotionsCategories:(api_Completion_Handler_Data)completion{
    
    if ([self checkForNetworkAvailability]) {
        //[XIBActivityIndicator startActivity];
        
       /* NSDictionary *parameterKeyValues = [[NSDictionary alloc] initWithObjectsAndKeys:
                                            @"func_id", @"29",
                                            @"user_id", [UserManager sharedManager].userID,
                                            @"access_token", [UserManager sharedManager].userAccessToken,
                                            nil];
        */
        NSMutableDictionary *parameterKeyValues = [[NSMutableDictionary alloc] init];
        
        [parameterKeyValues setObject:@"29" forKey:@"func_id"];
        [parameterKeyValues setObject:[UserManager sharedManager].userID forKey:@"user_id"];
        [parameterKeyValues setObject:[UserManager sharedManager].userAccessToken forKey:@"access_token"];
  

        
        
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithParams:parameterKeyValues withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataOffersAndPromotionsCategories:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        //[XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        //[XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        //[self showAlertForNoInternet];
    }
    
}

#pragma mark -  API - FUNC_ID: 30
- (void) addForumComment:(NSString*)forumID commentText:(NSString*)text photo:(NSArray*)photos completion:(api_Completion_Handler_Data)completion{
    if ([self checkForNetworkAvailability]) {
        [XIBActivityIndicator startActivity];
        UIImage *image;
        if([photos count]>0)image = (UIImage*)[photos objectAtIndex:0];
        
        //Upload with image
        dispatch_queue_t apiQueue = dispatch_queue_create("API Queue", NULL);
        dispatch_async(apiQueue, ^{
            
            
            // Build the request body
            NSString *boundary = @"SportuondoFormBoundary";
            NSMutableData *body = [NSMutableData data];
            
            // Body part for "USER ID" parameter. This is a string.
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"user_id"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", [UserManager sharedManager ].userID] dataUsingEncoding:NSUTF8StringEncoding]];
            
            // Body part for "ACCESS TOKEN" parameter. This is a string.
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"access_token"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", [UserManager sharedManager].userAccessToken] dataUsingEncoding:NSUTF8StringEncoding]];
            ///*
            
            // Body part for "FUNC_ID" parameter. This is a string.
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"func_id"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", @"30"] dataUsingEncoding:NSUTF8StringEncoding]];
            //*/
            
            // Body part for "FORUM ID" parameter. This is a string.
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"forum_id"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", forumID] dataUsingEncoding:NSUTF8StringEncoding]];
            //*/
            
            // Body part for "COMMENT Text" parameter. This is a string.
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"comment_text"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", text] dataUsingEncoding:NSUTF8StringEncoding]];
            //*/
            
            // Body part for "VIDEO" parameter. This is a string.
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"video"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", @"" ]dataUsingEncoding:NSUTF8StringEncoding]];
            //*/
            
            // Body part for the attachament. This is an image.
            //imageData = UIImageJPEGRepresentation(image, 0.6);
            NSData *imageData = UIImagePNGRepresentation(image);
            if (imageData) {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"userUploadImag.png\"\r\n", @"image"] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:imageData];
                [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            // Setup the session
            NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
            sessionConfiguration.HTTPAdditionalHeaders = @{
                                                           @"func_id"       : @"30",
                                                           @"Accept"        : @"application/json",
                                                           @"Content-Type"  : [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary]
                                                           };
            
            // Create the session
            // We can use the delegate to track upload progress
            NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
            
            // Data uploading task. We could use NSURLSessionUploadTask instead of NSURLSessionDataTask if we needed to support uploads in the background
            NSURL *url = [NSURL URLWithString:[HttpManager sharedManager].serverURL];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            request.HTTPMethod = @"POST";
            request.HTTPBody = body;
            NSURLSessionDataTask *yuploadTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                if (!error) {
                    NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                    //XLog(@"#### %@ ####", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                    if (httpResp.statusCode == 200) {
                        NSError *jsonError;
                        //XLog(@"Data 2: %@",data);
                        NSDictionary *jsonData =
                        [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingAllowFragments
                                                          error:&jsonError];
                        if (!jsonError) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                //XLog(@"1:jsonData # - Data - %@",jsonData);
                                
                                
                               
                                NSDictionary *dictonary = (NSDictionary* )[jsonData objectForKey:@"data"];

                                CommentItem *item = [[CommentItem alloc] init];
                                item.userID = [UserManager sharedManager].userID;
                                item.itemID = [dictonary valueForKey:@"comment_id"];
                                item.commentText = [dictonary valueForKey:@"comment_text"];
                                item.created_at = [dictonary valueForKey:@"created_at"];
                                item.photo = [dictonary valueForKey:@"image"];
                                item.video = [dictonary valueForKey:@"video"];
                                
                                completion(TRUE,[NSMutableArray arrayWithObject:item]);
                                
                                //item = nil;
                                [XIBActivityIndicator dismissActivity];
                                
                            });
                            //XLog(@"2:jsonData # - Data - %@",jsonData);
                            //callback(jsonData);
                        }else{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                completion(FALSE,nil);
                                [XIBActivityIndicator dismissActivity];
                                
                            });
                            //XLog(@"JsonError # Error - %@",jsonError);
                            //callback(nil);
                        }
                    }
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        XLog(@"RequestError # Error - %@ \n\n",error);
                        completion(FALSE,nil);
                        [XIBActivityIndicator dismissActivity];
                        
                    });
                }
                
            }];
            [yuploadTask resume];
            
        });
        
        
        
    }else{
        [self showAlertForNoInternet];
    }
}

#pragma mark -  API - FUNC_ID: 31
- (void) logOutUser:(api_Completion_Handler_Status)completion{
    if ([self checkForNetworkAvailability]) {
        [XIBActivityIndicator startActivity];
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=31&user_id=%@&access_token=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken];
        XLog(@"API-31: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [UserManager sharedManager].userAccessToken = @"invalidAccessToken";
                        [UserManager sharedManager].userID = @"0";
                        [UserManager sharedManager].userName = @"";
                        [UserManager sharedManager].userPassword = @"";
                        
                        completion(TRUE);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
    
}
#pragma mark -  API - FUNC_ID: 32
- (void) updateBubbleNotificationStatus:(NSString*)type completion:(api_Completion_Handler_Status)completion{

    if ([self checkForNetworkAvailability]) {
        NSString *parameterString = [NSString stringWithFormat:@"func_id=32&user_id=%@&access_token=%@&type=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken,
                                     type];
        XLog(@"API-32: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    //NSMutableArray *resultDataArray = [ServerDataParser parseDataAnnouncements:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE);
                        //[XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE);
                        //[XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        //[self showAlertForNoInternet];
    }
}

#pragma mark -  API - FUNC_ID: 33
- (void) fetchStaffSearchResults:(NSString*)keyWord deptID:(NSString*)deptID completion:(api_Completion_Handler_Data)completion{
    
    if ([self checkForNetworkAvailability]) {
        [XIBActivityIndicator startActivity];
        
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=33&user_id=%@&access_token=%@&dept_id=%@&keyword=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken,
                                     deptID,
                                     keyWord];
        XLog(@"API-33: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataStaffDirectoryStaffDetails:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
    
}

#pragma mark -  API - FUNC_ID: 34
- (void) favoriteStaff:(NSString*)staffID isBookmark:(NSString*)isBookmark completion:(api_Completion_Handler_Status)completion{

    if ([self checkForNetworkAvailability]) {
        [XIBActivityIndicator startActivity];
        
//        NSDictionary *parameterKeyValues = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                            @"func_id", @"34",
//                                            @"user_id", [UserManager sharedManager].userID,
//                                            @"access_token", [UserManager sharedManager].userAccessToken,
//                                            @"is_bookmark",isBookmark,
//                                            @"staff_id",staffID,
//                                            nil];
        NSString *parameterString = [NSString stringWithFormat:@"func_id=34&user_id=%@&access_token=%@&is_bookmark=%@&staff_id=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken,
                                     isBookmark,
                                     staffID];
        //XLog(@"API-34: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
    
}
#pragma mark -  API - FUNC_ID: 35
- (void) updateClassifiedWithCatID:(NSString*)catID classifiedID:(NSString*)classifiedID title:(NSString*)title description:(NSString*)description photo:(NSArray*)photos isDraft:(NSString*)isDraft completion:(api_Completion_Handler_Status)completion{
    
    if ([self checkForNetworkAvailability]) {
        [XIBActivityIndicator startActivity];
        
        NSString *photoString = @""; //[NSString stringWithFormat:@"%@",[photos objectAtIndex:0]];
        
        
        if (photos.count > 0) {
            photoString = [NSString stringWithFormat:@"%@",[photos objectAtIndex:0]];
            
            for (int i=1; i<[photos count]; i++) {
                photoString = [NSString stringWithFormat:@"%@,%@",photoString,[photos objectAtIndex:i]];
            }
            
        }
        
        
        NSString *parameterString = [NSString stringWithFormat:@"func_id=35&user_id=%@&access_token=%@&cat_id=%@&classified_id=%@&title=%@&description=%@&photo=%@&is_draft=%@",[UserManager sharedManager].userID,[UserManager sharedManager].userAccessToken,
                                     catID,classifiedID,title,description,photoString,isDraft ];
        
        XLog(@"API-35: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE);
                        [XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        [self showAlertForNoInternet];
    }
    
}
#pragma mark -  API - FUNC_ID: 36
- (void) fetchGalleryAlbumYearList:(api_Completion_Handler_Data)completion{
    if ([self checkForNetworkAvailability]) {
        NSString *parameterString = [NSString stringWithFormat:@"func_id=36&user_id=%@&access_token=%@",
                                     [UserManager sharedManager].userID,
                                     [UserManager sharedManager].userAccessToken];
        XLog(@"API-36: %@",parameterString);
        
        dispatch_queue_t backgroundQueue = dispatch_queue_create("Background Queue", NULL);
        
        dispatch_async(backgroundQueue, ^{
            
            [self makeServerRequestWithStringParams:parameterString withResponseCallback:^(NSDictionary *responseDictionary) {
                
                if ([self validateResponseData:responseDictionary] && responseDictionary!=nil) {
                    //Valid Data From Server
                    NSMutableArray *resultDataArray = [ServerDataParser parseDataGalleryAlbumYear:responseDictionary];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(TRUE,resultDataArray);
                        //[XIBActivityIndicator dismissActivity];
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(FALSE,nil);
                        //[XIBActivityIndicator dismissActivity];
                    });
                    
                }
                
            }];
            
        });
    }else{
        //[self showAlertForNoInternet];
    }
    
}
#pragma mark -  API - Upload Image

- (void) uploadImage:(UIImage*)image  completion:(api_Completion_Handler_Status_String)completion{
    
    
        if ([self checkForNetworkAvailability]) {
        dispatch_queue_t apiQueue = dispatch_queue_create("API Queue", NULL);
        dispatch_async(apiQueue, ^{
            
            
            // Build the request body
            NSString *boundary = @"SportuondoFormBoundary";
            NSMutableData *body = [NSMutableData data];
            
            // Body part for "USER ID" parameter. This is a string.
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"user_id"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", [UserManager sharedManager ].userID] dataUsingEncoding:NSUTF8StringEncoding]];
            
            // Body part for "ACCESS TOKEN" parameter. This is a string.
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"access_token"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", [UserManager sharedManager].userAccessToken] dataUsingEncoding:NSUTF8StringEncoding]];
            ///*
            // Body part for "FUNC_ID" parameter. This is a string.
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"func_id"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", @"19"] dataUsingEncoding:NSUTF8StringEncoding]];
            //*/
            // Body part for the attachament. This is an image.
            //imageData = UIImageJPEGRepresentation(image, 0.6);
            NSData *imageData =  UIImageJPEGRepresentation(image, 0.6);//UIImagePNGRepresentation(image);
            NSString *fileName = [NSString stringWithFormat:@"userClassifiedUploadImag%d.jpeg",arc4random()%50000+arc4random()%20000];
            if (imageData) {
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", @"image",fileName] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:imageData];
                [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            // Setup the session
            NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
            sessionConfiguration.HTTPAdditionalHeaders = @{
                                                           @"func_id"       : @"19",
                                                           @"Accept"        : @"application/json",
                                                           @"Content-Type"  : [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary]
                                                           };
            
            // Create the session
            // We can use the delegate to track upload progress
            NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
            
            // Data uploading task. We could use NSURLSessionUploadTask instead of NSURLSessionDataTask if we needed to support uploads in the background
            NSURL *url = [NSURL URLWithString:[HttpManager sharedManager].serverURL];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            request.HTTPMethod = @"POST";
            request.HTTPBody = body;
            NSURLSessionDataTask *yuploadTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                if (!error) {
                    NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                    //NSLog(@"#### %@ ####", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                    if (httpResp.statusCode == 200) {
                        NSError *jsonError;
                        //XLog(@"Data 2: %@",data);
                        NSDictionary *jsonData =
                        [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingAllowFragments
                                                          error:&jsonError];
                        if (!jsonError) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                NSDictionary *dictonary = [jsonData objectForKey:@"data"];
                                NSString *photoName = [dictonary objectForKey:@"photo_name"];
                          if(photoName!=Nil||photoName.length>0)
                              completion(TRUE,photoName);
                                else
                                    completion(FALSE,Nil);
                            });
                            //XLog(@"jsonData # %@ - Data - %@",params,jsonData);
                            //callback(jsonData);
                        }else{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                //[XIBActivityIndicator dismissActivity];
                                completion(FALSE,Nil);
                            });
                            //XLog(@"JsonError # Error - %@",jsonError);
                            //callback(nil);
                        }
                    }
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        XLog(@"RequestError # Error - %@ \n\n",error);
                        //[XIBActivityIndicator dismissActivity];
                       completion(FALSE,Nil);
                        
                       
                    });
                }
                
            }];
            [yuploadTask resume];
            
        });
        }
    
        else{
            [self showAlertForNoInternet];
        }
    


}

#pragma mark - Server Request
//Call to server for data
- (void) makeServerRequestWithStringParams:(NSString*)params withResponseCallback:(void (^)(NSDictionary *responseDictionary))callback {
    dispatch_queue_t apiQueue = dispatch_queue_create("API Queue", NULL);
    dispatch_async(apiQueue, ^{
        
        @autoreleasepool {
            NSURL *url = [NSURL URLWithString:[HttpManager sharedManager].serverURL];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            request.HTTPMethod = @"POST";
            request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
            
            NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
            sessionConfiguration.timeoutIntervalForResource = 60.0;
            NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
            NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                if (!error) {
                    NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                    //XLog(@"#### %@ ####", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                    if (httpResp.statusCode == 200) {
                        NSError *jsonError;
                        //XLog(@"Data 2: %@",data);
                        NSDictionary *jsonData =
                        [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingAllowFragments
                                                          error:&jsonError];
                        if (!jsonError) {
                            //XLog(@"jsonData # %@ - Data - %@",params,jsonData);
                            callback(jsonData);
                        }else{
                            //XLog(@"JsonError # Error - %@",jsonError);
                            callback(nil);
                        }
                    }
                }else{
                    XLog(@"RequestError # Error - %@ \n\n",error);
                    callback(nil);
                }
            }];
            
            [postDataTask resume];
        }
    });
    
}
#pragma mark -
#pragma mark - Server Request
//Call to server for data
- (void) makeServerRequestWithParams:(NSDictionary*)params withResponseCallback:(void (^)(NSDictionary *responseDictionary))callback {

    dispatch_queue_t apiQueue = dispatch_queue_create("API Queue", NULL);
    dispatch_async(apiQueue, ^{
        
        NSURL *url = [NSURL URLWithString:[HttpManager sharedManager].serverURL];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"POST";
        request.HTTPBody = [[self urlStringFromDictionary:params] dataUsingEncoding:NSUTF8StringEncoding];
        
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error) {
                NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                //XLog(@"#### %@ ####", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                if (httpResp.statusCode == 200) {
                    NSError *jsonError;
                    //XLog(@"Data 2: %@",data);
                    NSDictionary *jsonData =
                    [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingAllowFragments
                                                      error:&jsonError];
                    if (!jsonError) {
                        //XLog(@"jsonData # %@ - Data - %@",params,jsonData);
                        callback(jsonData);
                    }else{
                        //XLog(@"JsonError # Error - %@",jsonError);
                        callback(nil);
                    }
                }
            }else{
                XLog(@"RequestError # Error - %@ \n\n",error);
                callback(nil);
            }
        }];
        
        [postDataTask resume];
    });
    
}

//Upload data to server


//Check status for valid data from server
- (BOOL)validateResponseData:(NSDictionary*)responseDictionary{
    
    if ([[responseDictionary objectForKey:@"status"] integerValue]==5) {

        dispatch_async(dispatch_get_main_queue(), ^{
            [XIBActivityIndicator dismissActivity];
            [XIBActivityIndicator startActivity];
            [self performSelector:@selector(present) withObject:nil afterDelay: 0.1];
        });
        
    }
    
    return [[responseDictionary objectForKey:@"status"] integerValue]!=1?FALSE:TRUE;
}

- (void)present{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"xxx" object:nil];
    [XIBActivityIndicator dismissActivity];
}

//Convert Parameter Dictionary to Single string parameter
#pragma mark - Dictionary to String
- (NSString *)urlStringFromDictionary:(NSDictionary*)dict{
    NSArray *keys;
    int i, count;
    id key, value;
    
    keys = [dict allKeys];
    count = (int)[keys count];
    
    NSString *paramString = @"";
    
    for (i = count-1; i >= 0; i--){
        key = [keys objectAtIndex: i];
        value = [dict objectForKey: key];
        if (![paramString isEqualToString:@""])paramString = [paramString stringByAppendingString:@"&"];
        paramString = [paramString stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
        
    }
    XLog(@"para: %@",paramString);
    
    return paramString;
}

#pragma mark - Network Reachability
- (BOOL)checkForNetworkAvailability{
    networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if ((networkStatus != ReachableViaWiFi) && (networkStatus != ReachableViaWWAN)) {
        self.isNetworkAvailable = FALSE;
    }else{
        self.isNetworkAvailable = TRUE;
    }
    
    return self.isNetworkAvailable;
}

//server not available
- (void)showAlertForNoInternet{
    dispatch_async(dispatch_get_main_queue(), ^{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"No internet connection available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        alert = nil;
        
        CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/13.0, [UIScreen mainScreen].bounds.size.height/4.0 , 245, 90);
        NSString *msg = @"The app can’t be accessed offline. Please check your internet connection.";
        AlertPopView *alertMsg = [[AlertPopView alloc] initWithFrame:frame alertMsg:msg withDelay:2.5];
        [[UIApplication sharedApplication].keyWindow addSubview:alertMsg];
        alertMsg = nil;
    });
}

@end
