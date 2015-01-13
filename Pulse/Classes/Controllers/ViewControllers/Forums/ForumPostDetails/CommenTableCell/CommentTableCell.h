//
//  CommentTableCell.h
//  Pulse
//
//  Created by Atomix on 7/15/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STTweetLabel.h"

@interface CommentTableCell : UITableViewCell

{
    NSString *reuseID;
}

@property (nonatomic,strong) UIView *whiteBgView;
@property (nonatomic,strong) UILabel *userName;
@property (nonatomic,strong) UILabel *postTime;
@property (nonatomic,strong) STTweetLabel *postDetails;
@property (nonatomic,strong) UIButton *commentDeleteBtn;

@property (nonatomic,strong) AsyncImageView *userPostedImages;

//VIDEO PREVIEW
@property (nonatomic, strong) UIView *urlView;
@property (nonatomic, strong) AsyncImageView *imgThumbPreView;
@property (nonatomic, strong) UILabel *thumbTitle;

@end
