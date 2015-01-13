//
//  SettingsViewController.h
//  Pulse
//
//  Created by xibic on 6/3/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : CommonViewController

@property(strong,nonatomic) IBOutlet UIButton *onBtn;
@property(strong,nonatomic) IBOutlet UIButton *offBtn;

-(IBAction)onBtnAction:(UIButton*)sender;
-(IBAction)offBtnAction:(UIButton*)sender;
@end
