//
//  DeptTableCell.h
//  Pulse
//
//  Created by Atomix on 6/26/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeptTableCell : UITableViewCell
{
    NSString *reuseID;
}

@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UILabel *positionTitle;
@property (nonatomic, strong) UILabel *userDepartmentName;

@property (nonatomic, strong) UIButton *favourateBtn;

@property (nonatomic, strong) UILabel *email;
@property (nonatomic, strong) UILabel *office;
@property (nonatomic, strong) UILabel *mobile;

@property (nonatomic, strong) XIBUnderLinedButton *emailBtn;
@property (nonatomic, strong) XIBUnderLinedButton *officeBtn;
@property (nonatomic, strong) XIBUnderLinedButton *mobileBtn;

@property (nonatomic, strong) UIView *highlightedgrayBG;
@end
