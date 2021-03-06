//
//  ClassifiedsViewController.h
//  Pulse
//
//  Created by xibic on 6/11/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "ClassifiedDetailsViewController.h"
#import "NewPostClassifiedViewController.h"
#import <UIKit/UIKit.h>
#import "ClassifiedTabbarView.h"
#import "AllClassifiedsView.h"

@interface ClassifiedsViewController : CommonViewController <ClassifiedTabbarViewDelegate, AllClassifiedsViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *classifiedScrollview;


- (IBAction)createPostAction:(id)sender;


@end
