//
//  NewsTableCell.h
//  Pulse
//
//  Created by Atomix on 7/10/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableCell : UITableViewCell

{
    NSString *reuseID;
}

@property (nonatomic, strong) UILabel *headLineText;
@property (nonatomic, strong) UILabel *releaseDate;
@property (nonatomic, strong) UILabel *source;
@property (nonatomic, strong) UILabel *sourceName;
@property (nonatomic,strong) UIView *bgView;

@end
