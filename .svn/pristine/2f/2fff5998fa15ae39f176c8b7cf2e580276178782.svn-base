//
//  AttachedThumbnailsImageSubview.h
//  Pulse
//
//  Created by Supran on 7/2/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#define MAX_IMAGE_LIMIT 3
#import <UIKit/UIKit.h>
#import "ELCImagePickerController.h"

#import "CUploadImageView.h"
//@protocol AttachedThumbnailsImageSubviewDelegate <NSObject>
//@optional
//-(void)imageScrollviewModified;
//@end

@interface AttachedThumbnailsImageSubview : UIView <
                                                    UINavigationControllerDelegate,
                                                    UIImagePickerControllerDelegate,
                                                    UIActionSheetDelegate,
                                                    CUploadImageViewDelegate>


//@property (strong) id <AttachedThumbnailsImageSubviewDelegate> delegate;
//@property (nonatomic)     BOOL isImageLoading;
@property (nonatomic, weak) UIScrollView *imageScrollview;
@property (nonatomic, copy) NSArray *chosenImages;
@property (nonatomic, strong) NSMutableArray *attached_image_array;
@property ( readwrite)     int maxImageLimit;

- (id)initWithFrame:(CGRect)frame with:(UIViewController*)parentReference photoArray:(NSArray *)photos;
@end
