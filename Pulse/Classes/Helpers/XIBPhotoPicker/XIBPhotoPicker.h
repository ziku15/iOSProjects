//
//  XIBPhotoPicker.h
//  Pulse
//
//  Created by xibic on 8/4/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AssetsLibrary/AssetsLibrary.h>

@protocol XIBPhotoPickerDelegate <NSObject>

@optional
-(void)photoPickDone:(NSArray*)selectedPhotos;

@end

@interface XIBPhotoPicker : UIView{
    ALAssetsLibrary *library;
    NSArray *imageArray;
    NSMutableArray *mutableArray;
}
@property(nonatomic,readwrite) int numberOfPhotosAllowed;
@property(nonatomic,readwrite) BOOL shouldAutoPick;


@property(nonatomic,strong) id<XIBPhotoPickerDelegate>delegate;

-(void)allPhotosCollected:(NSArray*)imgArray;

@end
