//
//  HashTagCell.m
//  Pulse
//
//  Created by xibic on 7/16/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "HashTagCell.h"
#import "STTweetLabel.h"

#define kCellHeight 80.0f

@interface HashTagCell(){
    UIView *backgroundFrame;
    STTweetLabel *descriptionTextLabel;
    UILabel *numberOfConversationLabel;
}

@property (copy, nonatomic) void (^didTapDeleteButtonBlock)(id sender);
@property (copy, nonatomic) void (^didTapHashTagBlock)(id sender);

@end

@implementation HashTagCell


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
 NSLog(@"%@", item[@"title"]);
 }];
 */


- (void)customizeWithHashTag:(NSString*)tagText andConversationCount:(int)numberOfConversation{
    descriptionTextLabel.text = tagText;
    numberOfConversationLabel.text = [NSString stringWithFormat:@"%d Conversations on this topic",numberOfConversation];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.backgroundColor = [UIColor clearColor];
        
        //Content Frame
        backgroundFrame = [[UIView alloc] initWithFrame:CGRectMake(5.0f, 5.0f, self.frame.size.width-10.0f, kCellHeight-10.0f)];
        backgroundFrame.backgroundColor = [UIColor whiteColor];
        backgroundFrame.layer.cornerRadius = kViewCornerRadius;
        backgroundFrame.layer.borderWidth = kViewBorderWidth;
        backgroundFrame.layer.borderColor = kViewBorderColor;
        [self addSubview:backgroundFrame];
        
        //Text Label
        descriptionTextLabel = [[STTweetLabel alloc] initWithFrame:CGRectMake(8.0f,8.0f,backgroundFrame.frame.size.width-18.0f,55.0f)];
        [backgroundFrame addSubview:descriptionTextLabel];
        
        __block HashTagCell *weakSelf = self;
        [descriptionTextLabel setDetectionBlock:^(STTweetHotWord hotWord, NSString *string, NSString *protocol, NSRange range) {
            [weakSelf didTapHashTag:string];
        }];
        
        
        
        numberOfConversationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, backgroundFrame.frame.size.height-35.0f,
                                                                              backgroundFrame.frame.size.width-16.0f, 24.0f)];
        numberOfConversationLabel.lineBreakMode = NSLineBreakByWordWrapping;
        numberOfConversationLabel.textAlignment = NSTextAlignmentLeft;
        numberOfConversationLabel.numberOfLines = 1;
        //[numberOfConversationLabel sizeToFit];
        [numberOfConversationLabel setFont:[UIFont boldSystemFontOfSize:10.5f]];
        [numberOfConversationLabel setTextColor:[UIColor sidraFlatGrayColor]];
        [numberOfConversationLabel setBackgroundColor:[UIColor clearColor]];
        
        [backgroundFrame addSubview:numberOfConversationLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

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
 NSLog(@"%@", item[@"title"]);
 }
 
 
 */