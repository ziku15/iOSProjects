//
//  ForumPostCell.h
//  Pulse
//
//  Created by xibic on 7/15/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForumItem.h"
#import "STTweetLabel.h"

@interface ForumPostCell : UITableViewCell

{
    NSString *reuseID;
}

- (void)setDidTapDeleteButtonBlock:(void (^)(id sender))didTapDeleteButtonBlock;
- (void)setDidTapHashTagBlock:(void (^)(id sender))didTapHashTagBlock;

- (void)customizeWithItem:(ForumItem *)item;


@property (nonatomic,strong) UIView *backgroundFrame;
@property (nonatomic,strong) STTweetLabel *descriptionTextLabel;
@property (nonatomic,strong) UILabel *postedByAuthorLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *numberOfRepliesLabel;
@property (nonatomic,strong) UIButton *deleteButton;

@end
