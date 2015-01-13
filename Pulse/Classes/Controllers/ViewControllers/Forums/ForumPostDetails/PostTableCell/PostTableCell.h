//
//  PostTableCell.h
//  Pulse
//
//  Created by Atomix on 7/15/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STTweetLabel.h"

@interface PostTableCell : UITableViewCell

{
    NSString *reuseID;
}

@property (nonatomic,strong) UIView *userPostWhiteBgView;
@property (nonatomic,strong) STTweetLabel *postText;
@property (nonatomic,strong) XIBPhotoScrollView *postedImgList;
@property (nonatomic,strong) UILabel *postedOn;
@property (nonatomic,strong) UILabel *postedOnDate;
@property (nonatomic,strong) UILabel *postedBy;
@property (nonatomic,strong) UILabel *postedByName;
@property (nonatomic,strong) UIImageView *emailImg;
@property (nonatomic,strong) UIImageView *phoneImg;
@property (nonatomic,strong) UIButton *emailBtn;
@property (nonatomic,strong) UIButton *phoneBtn;
@property (nonatomic,strong) UIButton *deleteBtn;

- (void)addPhotoScrollerWithPhotos:(NSMutableArray*)photoArray frameSize: (CGRect)frame;

@end
