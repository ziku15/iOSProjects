//
//  PopupView.h
//  Pulse
//
//  Created by Supran on 7/7/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopupViewDelegate <NSObject>

@optional
-(void)popupDiscardAction;
-(void)popupSaveAction;
@end


@interface PopupView : UIView{
        CGRect popupGoToFrame,popupGoFromFrame;
}
@property (nonatomic,retain) id<PopupViewDelegate>delegate;

-(void)openPopupAnimation;
-(void)closePopupAnimation;
- (id)initWithFrame:(CGRect)frame with:(id)instance;

@end
