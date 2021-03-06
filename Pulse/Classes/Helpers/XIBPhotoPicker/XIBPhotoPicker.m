//
//  XIBPhotoPicker.m
//  Pulse
//
//  Created by xibic on 8/4/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "XIBPhotoPicker.h"
#import <ImageIO/ImageIO.h>

static int count=0;
#define ALBUM_SIZE CGSizeMake(99,99)
#define PADDING 3


#pragma mark - ImageItem Class
@interface ImageItem : NSObject

@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) ALAsset *asset;
@property (nonatomic,strong) UIImageView *imageSelectionMarker;
@property (nonatomic,readwrite) BOOL isSelected;

@end

@implementation ImageItem
@synthesize image,imageSelectionMarker,isSelected;

@end

@interface XIBPhotoPicker ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIScrollView *itemScrollView;
    int posX,posY;
    int numberOfCols,lastCol;
    int photoSelectionCount;
    NSMutableArray *albumPhotoItemArray;
    NSMutableArray *selectedPhotoArray;
    BOOL bottomBarAdded;
    
    //Activity
    UIView *hudView;
    UIImageView *loadingImageView;
}

@end

@implementation XIBPhotoPicker

@synthesize delegate;
@synthesize numberOfPhotosAllowed;
@synthesize shouldAutoPick;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        photoSelectionCount = 0;
        bottomBarAdded = FALSE;
        [self getAllPictures];
        [self addTopBar];
        
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
    }
    return self;
}

- (void)addTopBar{
    UIView *topBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    topBarView.backgroundColor = [UIColor sidraFlatTurquoiseColor];
    topBarView.userInteractionEnabled = YES;
    [self addSubview:topBarView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.userInteractionEnabled = YES;
    [backButton setFrame:CGRectMake(3.0f, topBarView.frame.size.height/3.0f - 6.0f, 53.0f,48.0f)];
    [backButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(backButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton setFrame:CGRectMake(topBarView.frame.size.width-46.0f, topBarView.frame.size.height/3.0f - 6.0f, 40.0f,40.0f)];
    [menuButton setImage:[UIImage imageNamed:@"take_photo_btn.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self
                   action:@selector(cameraButtonAction)
         forControlEvents:UIControlEventTouchUpInside];
    
    [topBarView addSubview:backButton];
    [topBarView addSubview:menuButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(topBarView.frame.size.width/2.0f - 27.0f,
                                                                    -10.0f,
                                                                    54.0f, 88)];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 2;
    [titleLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [topBarView addSubview:titleLabel];

    titleLabel.text = @"Camera Roll";
    
}

- (void)addBottomBar{
    bottomBarAdded = TRUE;
    UIView *bottomBarView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_SIZE.height-37.0f, self.frame.size.width, 40.0f)];
    bottomBarView.backgroundColor = [UIColor clearColor];
    bottomBarView.userInteractionEnabled = YES;
    [self addSubview:bottomBarView];
    
    XIBFlatButtons *cancelButton = [XIBFlatButtons buttonWithType:UIButtonTypeCustom];
    cancelButton.userInteractionEnabled = YES;
    [cancelButton setTitle:@"CANCEL" forState:UIControlStateNormal];
    [cancelButton setFrame:CGRectMake(5.0f, 2.0f, 153.0f,34.0f)];
    [cancelButton setBackgroundColor:[UIColor sidraFlatTurquoiseColor]];
    [cancelButton addTarget:self
                   action:@selector(cancelButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
    
    
    XIBFlatButtons *doneButton = [XIBFlatButtons buttonWithType:UIButtonTypeCustom];
    doneButton.userInteractionEnabled = YES;
    [doneButton setTitle:@"DONE" forState:UIControlStateNormal];
    [doneButton setFrame:CGRectMake(bottomBarView.frame.size.width-158.0f, 2.0f, 153.0f,34.0f)];
    [doneButton setBackgroundColor:[UIColor sidraFlatTurquoiseColor]];
    [doneButton addTarget:self
                     action:@selector(doneButtonAction:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [bottomBarView addSubview:cancelButton];
    [bottomBarView addSubview:doneButton];
    
}

- (void)cancelButtonAction:(id)sender{
    [self.delegate photoPickDone:nil];
}

- (void)backButtonAction:(id)sender{
    [self.delegate photoPickDone:nil];
}


- (void)doneButtonAction:(id)sender{
    
    selectedPhotoArray = [[NSMutableArray alloc] init];
    
    if (photoSelectionCount<=0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"Select some photos first"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
        selectedPhotoArray = nil;
    }else{
        [albumPhotoItemArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ImageItem *imageItem = (ImageItem*)obj;
            if (imageItem.isSelected) {
                
                // Get the full image in a background thread
                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                    
                    //UIImage* image = [self fullSizeImageForAssetRepresentation:imageItem.asset.defaultRepresentation];
                    
                    ALAssetRepresentation *assetRepresentation = [imageItem.asset defaultRepresentation];
                    // Retrieve the image orientation from the ALAsset
                    UIImageOrientation orientation = UIImageOrientationUp;
                    NSNumber* orientationValue = [imageItem.asset valueForProperty:@"ALAssetPropertyOrientation"];
                    if (orientationValue != nil) {
                        orientation = [orientationValue intValue];
                    }
                    
                    CGFloat scale  = 1;
                    UIImage* image = [UIImage imageWithCGImage:[assetRepresentation fullResolutionImage]
                                                         scale:scale orientation:orientation];
                    /*
                    CGImageRef fullResImage = [assetRepresentation fullResolutionImage];
                    NSString *adjustment = [[assetRepresentation metadata] objectForKey:@"AdjustmentXMP"];
                    if (adjustment) {
                        NSData *xmpData = [adjustment dataUsingEncoding:NSUTF8StringEncoding];
                        CIImage *image = [CIImage imageWithCGImage:fullResImage];
                        
                        NSError *error = nil;
                        NSArray *filterArray = [CIFilter filterArrayFromSerializedXMP:xmpData
                                                                     inputImageExtent:image.extent
                                                                                error:&error];
                        CIContext *context = [CIContext contextWithOptions:nil];
                        if (filterArray && !error) {
                            for (CIFilter *filter in filterArray) {
                                [filter setValue:image forKey:kCIInputImageKey];
                                image = [filter outputImage];
                            }
                            fullResImage = [context createCGImage:image fromRect:[image extent]];
                        }   
                    }
                    UIImage *result = [UIImage imageWithCGImage:fullResImage
                                                          scale:[assetRepresentation scale]
                                                    orientation:(UIImageOrientation)[assetRepresentation orientation]];
                    */
                    [selectedPhotoArray addObject:image];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (photoSelectionCount==[selectedPhotoArray count]) {
                            [self.delegate photoPickDone:selectedPhotoArray];
                            selectedPhotoArray = nil;
                        }
                        
                    });
                });
                
            }
        }];
    }

}

- (void)cameraButtonAction{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = YES;
        [[AppManager sharedManager ] presentModelViewController:imagePicker];
        
        CGRect frame = self.frame;
        frame.origin.y = -1000;
        
        [UIView animateWithDuration:0.8f animations:^{
            self.frame = frame;
        }];
        
    }
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    XLog(@"%@",chosenImage);
    @autoreleasepool {
        /* Save to the photo album */
        UIImageWriteToSavedPhotosAlbum(chosenImage ,
                                       self, // send the message to 'self' when calling the callback
                                       @selector(thisImage:hasBeenSavedInPhotoAlbumWithError:usingContextInfo:), // the selector to tell the method to call on completion
                                       NULL); // you generally won't need a contextInfo here);
    }
    
    CGRect frame = self.frame;
    frame.origin.y = 0;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = frame;
    }];
    photoSelectionCount = 0;
}

- (void)thisImage:(UIImage *)image hasBeenSavedInPhotoAlbumWithError:(NSError *)error usingContextInfo:(void*)ctxInfo {
    if (error) {
        // Do anything needed to handle the error or display it to the user
    } else {
        [[AppManager sharedManager] dismissModelViewController];
        [self getAllPictures];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //  [self dismissViewControllerAnimated:YES completion:nil];
    [[AppManager sharedManager]dismissModelViewController];
    
    CGRect frame = self.frame;
    frame.origin.y = 0;
    
    [UIView animateWithDuration:0.1f animations:^{
        self.frame = frame;
    }];
    
}

//END Camera Picker//

- (void)getAllPictures{
    
    [self startActivity];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        @autoreleasepool {
            imageArray=[[NSArray alloc] init];
            mutableArray =[[NSMutableArray alloc]init];
            NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
            
            library = [[ALAssetsLibrary alloc] init];
            
            void (^assetEnumerator)( ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if(result != nil) {
                    if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                        [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                        
                        NSURL *url= (NSURL*) [[result defaultRepresentation]url];
                        
                        [library assetForURL:url
                                 resultBlock:^(ALAsset *asset) {
                                     ImageItem *imageItem = [[ImageItem alloc] init];
                                     imageItem.asset = result;
                                     imageItem.image = [UIImage imageWithCGImage:[result thumbnail]];;
                                     imageItem.isSelected = FALSE;
                                     [mutableArray addObject:imageItem];
                                     imageItem = nil;
 
                                     if ([mutableArray count]==count){
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                             imageArray=[[NSArray alloc] initWithArray:[[mutableArray reverseObjectEnumerator] allObjects]];
                                             [self allPhotosCollected:imageArray];
                                         });
                                         
                                     }
                                 }
                                failureBlock:^(NSError *error){ XLog(@"operation was not successfull!"); [self dismissActivity]; } ];
                        
                    }
                }
            };
            
            NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
            
            void (^ assetGroupEnumerator) ( ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
                if(group != nil) {
                    [group setAssetsFilter: [ALAssetsFilter allPhotos]];
                    [group enumerateAssetsUsingBlock:assetEnumerator];
                    [assetGroups addObject:group];
                    count=[group numberOfAssets];
                    if (count==0) {
                        [self dismissActivity];
                    }
                }
            };
            
            //assetGroups = [[NSMutableArray alloc] init];
            
            [library enumerateGroupsWithTypes:ALAssetsGroupAll
                                   usingBlock:assetGroupEnumerator
                                 failureBlock:^(NSError *error) {XLog(@"There is an error");}];
        }
    });
    
}

-(UIImage *)fullSizeImageForAssetRepresentation:(ALAssetRepresentation *)assetRepresentation{
    ///*
    UIImage *result = nil;
    NSData *data = nil;
    
    uint8_t *buffer = (uint8_t *)malloc(sizeof(uint8_t)*(NSUInteger)[assetRepresentation size]);
    if (buffer != NULL) {
        NSError *error = nil;
        NSUInteger bytesRead = (NSUInteger)[assetRepresentation getBytes:buffer fromOffset:0 length:(NSUInteger)[assetRepresentation size] error:&error];
        data = [NSData dataWithBytes:buffer length:bytesRead];
        
        free(buffer);
    }
    
    if ([data length])
    {
        CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)data, nil);
        
        NSMutableDictionary *options = [NSMutableDictionary dictionary];
        
        [options setObject:(id)kCFBooleanTrue forKey:(id)kCGImageSourceShouldAllowFloat];
        [options setObject:(id)kCFBooleanTrue forKey:(id)kCGImageSourceCreateThumbnailFromImageAlways];
        [options setObject:(id)[NSNumber numberWithFloat:640.0f] forKey:(id)kCGImageSourceThumbnailMaxPixelSize];
        //[options setObject:(id)kCFBooleanTrue forKey:(id)kCGImageSourceCreateThumbnailWithTransform];
        
        CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(sourceRef, 0, (__bridge CFDictionaryRef)options);
        
        if (imageRef) {
            result = [UIImage imageWithCGImage:imageRef scale:[assetRepresentation scale] orientation:(UIImageOrientation)UIImageOrientationUp];
            CGImageRelease(imageRef);
        }
        
        if (sourceRef)
            CFRelease(sourceRef);
    }
    //*/
    /*
    ALAssetRepresentation *assetRepresentation = _assetRepresentation;
    CGImageRef fullResImage = [assetRepresentation fullResolutionImage];
    NSString *adjustment = [[assetRepresentation metadata] objectForKey:@"AdjustmentXMP"];
    if (adjustment) {
        NSData *xmpData = [adjustment dataUsingEncoding:NSUTF8StringEncoding];
        CIImage *image = [CIImage imageWithCGImage:fullResImage];
        
        NSError *error = nil;
        NSArray *filterArray = [CIFilter filterArrayFromSerializedXMP:xmpData
                                                     inputImageExtent:image.extent
                                                                error:&error];
        CIContext *context = [CIContext contextWithOptions:nil];
        if (filterArray && !error) {
            for (CIFilter *filter in filterArray) {
                [filter setValue:image forKey:kCIInputImageKey];
                image = [filter outputImage];
            }
            fullResImage = [context createCGImage:image fromRect:[image extent]];
        }
    }
    UIImage *result = [UIImage imageWithCGImage:fullResImage
                                          scale:[assetRepresentation scale]
                                    orientation:UIImageOrientationUp];
    //*/
    return result;
    
}

- (void)allPhotosCollected:(NSArray*)imgArray{
    //write your code here after getting all the photos from library...
    //XLog(@"all pictures are %@",imgArray);
    [self showImageForSelection:imgArray];
}

- (void)showImageForSelection:(NSArray *)photosArray{
    
    albumPhotoItemArray = nil;
    albumPhotoItemArray = [NSMutableArray arrayWithArray:photosArray];
    
    [itemScrollView removeFromSuperview];
    itemScrollView = nil;
    
    itemScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height)];
    itemScrollView.backgroundColor = [UIColor clearColor];
    itemScrollView.showsHorizontalScrollIndicator = NO;
    itemScrollView.showsVerticalScrollIndicator = NO;
    itemScrollView.pagingEnabled = NO;
    //itemScrollView.delegate = self;
    itemScrollView.bounces = YES;
    itemScrollView.userInteractionEnabled = YES;
    itemScrollView.exclusiveTouch = YES;
    itemScrollView.clipsToBounds = YES;
    
    numberOfCols = 3;
    
    int index=0;
    posY = 5;
    for (int i=0; index <[albumPhotoItemArray count]; i++) {
        posX = 6;
        for (int j=0; j<numberOfCols && index <[albumPhotoItemArray count]; j++) {
            
            ImageItem *imageItem = (ImageItem*)[albumPhotoItemArray objectAtIndex:index];
            UIImage *itemImage = imageItem.image;
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(posX, posY, ALBUM_SIZE.width, ALBUM_SIZE.height)];
            posX += ALBUM_SIZE.width+5;
            
            view.tag = index;
            view.userInteractionEnabled = YES;
            view.backgroundColor = [UIColor clearColor];
            view.layer.cornerRadius = 4.0f;
            
            AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(2, 2, ALBUM_SIZE.width-4, ALBUM_SIZE.height-4)];
            imageView.showActivityIndicator = YES;
            imageView.layer.cornerRadius = 2.5;
            imageView.clipsToBounds = YES;
            //imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.image = itemImage;
            [view addSubview:imageView];
            imageView.userInteractionEnabled = YES;
            
            UIImageView *imageShadeView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, ALBUM_SIZE.width-4, ALBUM_SIZE.height-4)];
            imageShadeView.image = [UIImage imageNamed:@"photo_selected_checkmark.png"];
            imageShadeView.layer.cornerRadius = 2.5;
            imageShadeView.clipsToBounds = YES;
            imageShadeView.alpha = 0.0f;
            [imageShadeView setContentMode:UIViewContentModeRedraw];
            imageItem.imageSelectionMarker = imageShadeView;
            [view addSubview:imageShadeView];
            
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
            [singleTap setNumberOfTapsRequired:1];
            [view addGestureRecognizer:singleTap];
            
            [itemScrollView addSubview:view];
            [albumPhotoItemArray replaceObjectAtIndex:index withObject:imageItem];
            
            index++;
            lastCol = j;
            
            
        }
        
        posY += ALBUM_SIZE.height + PADDING *2;
        
        itemScrollView.contentSize = CGSizeMake(itemScrollView.contentSize.width, posY + ALBUM_SIZE.height);
    }
    
    
    [self addSubview:itemScrollView];
    
    

    //
    if (!self.shouldAutoPick) {
        if(!bottomBarAdded)[self addBottomBar];
        else [self sendSubviewToBack:itemScrollView];
    }
    
    [self dismissActivity];
}

#pragma mark Gesture Handling methods

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    
    UIView *view = (UIView*)[gestureRecognizer view];
    ImageItem *imageItem = (ImageItem *)[albumPhotoItemArray objectAtIndex:view.tag];
    
    
//    if (imageItem.isSelected) {
//        photoSelectionCount++;
//        imageItem.imageSelectionMarker.alpha = 1.0f;
//    }else{
//        photoSelectionCount--;
//        photoSelectionCount=photoSelectionCount<0?0:photoSelectionCount;
//        imageItem.imageSelectionMarker.alpha = 0.0f;
//    }
    
    
    
    //Not selected and count ==
    //alert
    
    //Not selected and count >
    //not possible
    
    //Not selected and count <
    //select , count++
    
    //Selected and count ==
    //-deselect , count--
    
    //Selected and count >
    //not possible
    
    //Selected and count <
    //deselect, count--
    
    if (!imageItem.isSelected && photoSelectionCount==self.numberOfPhotosAllowed) {
        //alert
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"No more than %d photos can be selected.",self.numberOfPhotosAllowed] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
        
    }
    else if (!imageItem.isSelected && photoSelectionCount>self.numberOfPhotosAllowed) {
        XLog(@"impossible situation");
    }
    else if (!imageItem.isSelected && photoSelectionCount<self.numberOfPhotosAllowed) {//Done
        photoSelectionCount++;
        imageItem.isSelected = TRUE;
        imageItem.imageSelectionMarker.alpha = 1.0f;
    }
    
    else if (imageItem.isSelected && photoSelectionCount==self.numberOfPhotosAllowed) {
        photoSelectionCount--;
        photoSelectionCount=photoSelectionCount<0?0:photoSelectionCount;
        imageItem.imageSelectionMarker.alpha = 0.0f;
        imageItem.isSelected = FALSE;
    }
    else if (imageItem.isSelected && photoSelectionCount>self.numberOfPhotosAllowed) {
        //alert
    }
    else if (imageItem.isSelected && photoSelectionCount<self.numberOfPhotosAllowed) {
        photoSelectionCount--;
        photoSelectionCount=photoSelectionCount<0?0:photoSelectionCount;
        imageItem.imageSelectionMarker.alpha = 0.0f;
        imageItem.isSelected = FALSE;
    }
    
    //
    [albumPhotoItemArray replaceObjectAtIndex:view.tag withObject:imageItem];
    if (self.shouldAutoPick) {
        [self doneButtonAction:nil];
    }
}

#pragma mark - GestureRecognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - Activity Indicator
- (void)startActivity{
    
    [hudView removeFromSuperview];
    hudView = nil;
    
    hudView = [[UIView alloc] initWithFrame:self.frame];
    hudView.backgroundColor = [UIColor blackColor];
    hudView.alpha = 0.3f;
    [self addSubview:hudView];
    
    [loadingImageView removeFromSuperview];
    loadingImageView = nil;
    
    loadingImageView = [[UIImageView alloc] initWithLoadingImage];
    loadingImageView.center = self.center;
    [self addSubview:loadingImageView];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = NO;
}

- (void)dismissActivity{
    
    [hudView removeFromSuperview];
    hudView = nil;
    
    [loadingImageView stopAnimating];
    [loadingImageView removeFromSuperview];
    loadingImageView = nil;
    
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
}

@end
