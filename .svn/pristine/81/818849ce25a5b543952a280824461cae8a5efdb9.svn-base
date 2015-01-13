//
//  UserPostView.h
//  CommonPostView
//
//  Created by Atomix on 8/1/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentItem.h"

@class ForumPostView;

@protocol ForumPostViewDelegate <NSObject>
-(void)sendBtnValue :(NSString*)text commentItem:(CommentItem*)item;
-(void)cancelComment;
-(void)isPostingContinue:(BOOL)isPost;
@end


@interface ForumPostView : UIView <UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

- (id)initWithFrame:(CGRect)frame forPostView:(BOOL)isTrue withHashTag:(NSString*)hashtag;
@property (nonatomic, strong) UITextView *inputField;
@property (nonatomic, retain) NSString *postID;
@property (nonatomic, retain) NSString *hashTag;
@property (nonatomic, retain) id<ForumPostViewDelegate> delegate;

@end
