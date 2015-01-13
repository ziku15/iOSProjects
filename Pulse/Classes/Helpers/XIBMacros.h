//
//  XIBMacros.h
//
//  Created by xibic on 2/18/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#ifndef XIBMacros_h
#define XIBMacros_h


//Custom NSLog
/*
 #ifdef DEBUG
 #define XLog( s, ... ) NSLog( @"<%@:%d> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent],\\
 __LINE__,  [NSString stringWithFormat:(s), ##__VA_ARGS__] )
 #else
 #define XLog( s, ... )
 #endif
 */
///*
#ifdef DEBUG
#   define XLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define XLog(...)
#endif
//*/

//simply checks to see if the current thread is main, and if it isn’t, dispatch the method on the current thread.
#define XIB_runOnMainThread if (![NSThread isMainThread]) \\
                            { dispatch_sync(dispatch_get_main_queue(), \\
                            ^{ [self performSelector:_cmd]; }); return; };

#define XIB_logBounds(view) UA_log(@"%@ bounds: %@", view, NSStringFromRect([view bounds]))

#define XIB_logFrame(view)  UA_log(@"%@ frame: %@", view, NSStringFromRect([view frame]))

#define NSStringFromBool(b) (b ? @"YES" : @"NO")

#define XIB_SHOW_VIEW_BORDERS YES

#define XIB_showDebugBorderForViewColor(view, color) if (UA_SHOW_VIEW_BORDERS) { \\
                                        view.layer.borderColor = color.CGColor; view.layer.borderWidth = 1.0; }

#define XIB_showDebugBorderForView(view) UA_showDebugBorderForViewColor(view, [UIColor colorWithWhite:0.0 alpha:0.25])

#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size

#define IPHONE_5 ([[UIScreen mainScreen] bounds].size.height >= 568.0)

#endif
