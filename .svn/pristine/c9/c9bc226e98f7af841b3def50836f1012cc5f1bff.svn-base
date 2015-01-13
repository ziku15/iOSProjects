//
//  ForumPostCell.m
//  Pulse
//
//  Created by xibic on 7/15/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "ForumPostCell.h"


#define kCellHeight 100.0f

@interface ForumPostCell(){
//    UIView *backgroundFrame;
//    STTweetLabel *descriptionTextLabel;
//    UILabel *postedByAuthorLabel;
//    UILabel *timeLabel;
//    UILabel *numberOfRepliesLabel;
//    UIButton *deleteButton;
    BOOL selfPosted;
}

@property (copy, nonatomic) void (^didTapDeleteButtonBlock)(id sender);
@property (copy, nonatomic) void (^didTapHashTagBlock)(id sender);

@end

@implementation ForumPostCell

@synthesize backgroundFrame;
@synthesize descriptionTextLabel;
@synthesize postedByAuthorLabel;
@synthesize timeLabel;
@synthesize numberOfRepliesLabel;
@synthesize deleteButton;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //[self.actionButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didTapButton:(id)sender {
    if (self.didTapDeleteButtonBlock) {
        self.didTapDeleteButtonBlock(sender);
    }
}

- (void)didTapHashTag:(id)sender {
    if (self.didTapHashTagBlock) {
        self.didTapHashTagBlock(sender);
    }
}


/*
 [cell setDidTapButtonBlock:^(id sender) {
 XLog(@"%@", item[@"title"]);
 }];
 */


- (void)customizeWithItem:(ForumItem *)item{
    int postCreatedBy = (int)[item.createdBy integerValue];
    int myID = (int)[[UserManager sharedManager].userID  integerValue];
   
    selfPosted = (postCreatedBy == myID);
    if (selfPosted) {
        //XLog(@"creator: %d -- myid: %d",postCreatedBy,myID);
        //backgroundFrame.layer.borderWidth = 1.5f;
        //backgroundFrame.layer.borderColor = [UIColor sidraFlatGreenColor].CGColor;
        
        postedByAuthorLabel.textColor = [UIColor sidraFlatGreenColor];
        postedByAuthorLabel.text = @"You";

        deleteButton.alpha = 1.0f;

    }else{
        postedByAuthorLabel.text = item.authorName;
    }
    
    timeLabel.text = [[SettingsManager sharedManager] showPostedByFromDate:item.createdDate];
    
    descriptionTextLabel.text = item.text;
    numberOfRepliesLabel.text = [NSString stringWithFormat:@"%d reply",item.totalComments];
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.backgroundColor = [UIColor clearColor];
        
        reuseID = reuseIdentifier;
        
        //Content Frame
        [backgroundFrame removeFromSuperview];
        backgroundFrame = [[UIView alloc] initWithFrame:CGRectMake(5.0f, 5.0f, self.frame.size.width-10.0f, kCellHeight-10.0f)];
        backgroundFrame.backgroundColor = [UIColor whiteColor];
        backgroundFrame.layer.cornerRadius = kViewCornerRadius;
        backgroundFrame.layer.borderWidth = kViewBorderWidth;
        backgroundFrame.layer.borderColor = kViewBorderColor;
        [self addSubview:backgroundFrame];
        
        //Text Label - HASHTAG
        [descriptionTextLabel removeFromSuperview];
        descriptionTextLabel = [[STTweetLabel alloc] initWithFrame:CGRectMake(8.0f,3.0f,backgroundFrame.frame.size.width-18.0f,55.0f)];
        [backgroundFrame addSubview:descriptionTextLabel];
        
        __block ForumPostCell *weakSelf = self;
        [descriptionTextLabel setDetectionBlock:^(STTweetHotWord hotWord, NSString *string, NSString *protocol, NSRange range) {
            [weakSelf didTapHashTag:string];
        }];
        
        //PostedBy Label
        UILabel *postedByLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, kCellHeight-60.0f,
                                                                  backgroundFrame.frame.size.width-8, 48)];
        postedByLabel.lineBreakMode = NSLineBreakByWordWrapping;
        postedByLabel.numberOfLines = 1;
        [postedByLabel setFont:[UIFont systemFontOfSize:10.5f]];
        [postedByLabel setTextColor:[UIColor sidraFlatGrayColor]];
        [postedByLabel setBackgroundColor:[UIColor clearColor]];
        [backgroundFrame addSubview:postedByLabel];
        postedByLabel.text = @"Posted by: ";
        
        [postedByAuthorLabel removeFromSuperview];
        postedByAuthorLabel = [[UILabel alloc] initWithFrame:CGRectMake(67, kCellHeight-60.0f,
                                                                  backgroundFrame.frame.size.width-8, 48)];
        postedByAuthorLabel.lineBreakMode = NSLineBreakByWordWrapping;
        postedByAuthorLabel.numberOfLines = 1;
        [postedByAuthorLabel setFont:[UIFont boldSystemFontOfSize:10.5f]];
        [postedByAuthorLabel setTextColor:[UIColor sidraFlatTurquoiseColor]];
        [postedByAuthorLabel setBackgroundColor:[UIColor clearColor]];
        [backgroundFrame addSubview:postedByAuthorLabel];
        
        //Time Label
        [timeLabel removeFromSuperview];
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, kCellHeight-45.0f,
                                                              backgroundFrame.frame.size.width-8, 48)];
        timeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        timeLabel.numberOfLines = 1;
        [timeLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [timeLabel setTextColor:[UIColor sidraFlatDarkGrayColor]];
        [timeLabel setBackgroundColor:[UIColor clearColor]];
        [backgroundFrame addSubview:timeLabel];
        
        //Number Of Replies View
        UIView *numberOfRepliesFrame = [[UIView alloc] initWithFrame:CGRectMake(backgroundFrame.frame.size.width-71.0f, kCellHeight-38.0f,
                                                                                62.0f, 20.0f)];
        numberOfRepliesFrame.backgroundColor = [UIColor sidraFlatTurquoiseColor];
        numberOfRepliesFrame.layer.cornerRadius = 2.5f;
        numberOfRepliesFrame.layer.borderWidth = 0.1f;
        numberOfRepliesFrame.layer.borderColor = [UIColor sidraFlatGrayColor].CGColor;
        
        [numberOfRepliesLabel removeFromSuperview];
        numberOfRepliesLabel = [[UILabel alloc] initWithFrame:CGRectMake(1.0f, 0.0f, 60.0f, 24.0f)];
        numberOfRepliesLabel.lineBreakMode = NSLineBreakByWordWrapping;
        numberOfRepliesLabel.textAlignment = NSTextAlignmentCenter;
        numberOfRepliesLabel.numberOfLines = 1;
        numberOfRepliesLabel.adjustsFontSizeToFitWidth = YES;
        //[numberOfRepliesLabel sizeToFit];
        [numberOfRepliesLabel setFont:[UIFont boldSystemFontOfSize:9.0f]];
        [numberOfRepliesLabel setTextColor:[UIColor whiteColor]];
        [numberOfRepliesLabel setBackgroundColor:[UIColor clearColor]];
        numberOfRepliesLabel.center = CGPointMake(numberOfRepliesFrame.frame.size.width/2.0f, numberOfRepliesFrame.frame.size.height/2.0f);
        [numberOfRepliesFrame addSubview:numberOfRepliesLabel];
        
        [backgroundFrame addSubview:numberOfRepliesFrame];
        
        //Delete button
        [deleteButton removeFromSuperview];
        deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteButton setBackgroundColor:[UIColor clearColor]];
        [deleteButton setImage:[UIImage imageNamed:@"delete_icon.png"] forState:UIControlStateNormal];
//        [delButton addTarget:self
//                      action:@selector(deleteActionDetails:)
//            forControlEvents:UIControlEventTouchUpInside];
        [deleteButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
        deleteButton.frame = CGRectMake(backgroundFrame.frame.size.width-104.0f, kCellHeight-39.0f,
                                     23.0f, 23.0f);
        [backgroundFrame addSubview:deleteButton];
        deleteButton.alpha = 0.0f;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/*

 - (void)didTapButton:(id)sender {
 // Cast Sender to UIButton
 UIButton *button = (UIButton *)sender;
 
 // Find Point in Superview
 CGPoint pointInSuperview = [button.superview convertPoint:button.center toView:self.tableView];
 
 // Infer Index Path
 NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:pointInSuperview];
 
 // Fetch Item
 NSDictionary *item = [self.dataSource objectAtIndex:indexPath.row];
 
 // Log to Console
 XLog(@"%@", item[@"title"]);
 }

 
 */

@end
