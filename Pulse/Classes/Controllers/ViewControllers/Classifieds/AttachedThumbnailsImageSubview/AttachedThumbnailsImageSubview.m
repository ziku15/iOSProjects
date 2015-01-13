//
//  AttachedThumbnailsImageSubview.m
//  Pulse
//
//  Created by Supran on 7/2/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "AttachedThumbnailsImageSubview.h"
#import "XIBPhotoPicker.h"

@interface AttachedThumbnailsImageSubview()<XIBPhotoPickerDelegate>{
    XIBPhotoPicker *photoPicker;
    UIViewController *parentViewController;
    NSInteger image_tag_value;

    UIView *imageScrollSubview;
}

@end

@implementation AttachedThumbnailsImageSubview
//@synthesize delegate;
@synthesize imageScrollview;
@synthesize attached_image_array;

//@synthesize maxImageLimit;

- (id)initWithFrame:(CGRect)frame with:(UIViewController*)parentReference photoArray:(NSArray *)photos{
    self = [super initWithFrame:frame];
    if (self) {

        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        parentViewController = parentReference;
        //self.maxImageLimit = 0;
        image_tag_value = 100;
        attached_image_array = [[NSMutableArray alloc] init];
     
//        isImageUploading = false;
        
        //create scroller view
        [self createNewScrollerDesignView];
        
        //check weather its already have photos or not
        
        if(photos.count > 0){
            for (NSDictionary *dic in photos) {
                //                NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: serverPhotoName, @"ServerPhotoName",  [NSString stringWithFormat:@"%i",tagID], @"TagId", nil];
                //                [attached_image_array addObject:dict];
                //                {
                //                    "classified_id" = 196;
                //                    "created_at" = "2014-08-18 10:57:32";
                //                    id = 343;
                //                    "is_del" = 0;
                //                    photo = "uploads/classified/1408337123userUploadImag.png";
                //                    "updated_at" = "2014-08-18 10:57:32";
                //                }
                
                NSString *urlString = [dic objectForKey:@"photo"];
                NSString *extractedUrlString = [urlString stringByReplacingOccurrencesOfString:@"uploads/classified/" withString:@""];
                
                if (![extractedUrlString isEqualToString:@""]) {
                    [self addImageTOScrollview:nil withUrl:urlString];
                    
                   // NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: extractedUrlString, @"ServerPhotoName",  [NSString stringWithFormat:@"%i",image_tag_value], @"TagId", nil];
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [XIBActivityIndicator startActivity];
                        NSURL *imageURL = [NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@",SERVER_BASE_IMAGE_URL,urlString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                        
                        
                        NSData *downloadedImageData=[NSData dataWithContentsOfURL:imageURL];
                        UIImage *image=[UIImage imageWithData:downloadedImageData];
                        
                        [attached_image_array addObject:image];
                        self.maxImageLimit = (int)attached_image_array.count;
                        [XIBActivityIndicator dismissActivity];
                        
                    });

                    
                   
                }
                
            }
        }
        
    }
    return self;
}

#pragma mark - image view

-(void)createNewScrollerDesignView{
    [self createImageScrollSubview:CGRectMake(10, 5, self.frame.size.width-20, self.frame.size.height-10)];
    [self createTempImageView];
}

-(void)createImageScrollSubview:(CGRect)frame{
    imageScrollSubview = [[UIView alloc] initWithFrame:frame];
    [imageScrollSubview setBackgroundColor:[UIColor whiteColor]];
    imageScrollSubview.layer.borderWidth = kViewBorderWidth;
    imageScrollSubview.layer.borderColor = kViewBorderColor;
    imageScrollSubview.layer.cornerRadius = kViewCornerRadius;
    imageScrollSubview.layer.masksToBounds = YES;
    [self addSubview:imageScrollSubview];
}

-(void)createTempImageView{
    
    UIView *tempImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageScrollSubview.frame.size.width/3, imageScrollSubview.frame.size.height)];
    [tempImageView setTag:99999];
    tempImageView.layer.borderWidth = 1.0f;
    tempImageView.layer.borderColor = [UIColor clearColor].CGColor;
    tempImageView.layer.cornerRadius = kViewCornerRadius;
    tempImageView.layer.masksToBounds = YES;
    [tempImageView setBackgroundColor:[UIColor clearColor]];
    [imageScrollSubview addSubview:tempImageView];
    
    //Create right add button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"add_image_btn.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 60, 62);
    [button setCenter:CGPointMake(tempImageView.frame.size.width/2, tempImageView.frame.size.height/2)];
    [tempImageView addSubview:button];
}


#pragma mark - add image to scrollview
-(void)addImageTOScrollview:(UIImage *)image withUrl:(NSString *)imageUrlString{

    image_tag_value = image_tag_value + 1;
    
    CUploadImageView *imageView ;
    if (image == nil) {
        imageView = [[CUploadImageView alloc] initWithFrame:CGRectMake([imageScrollSubview viewWithTag:99999].frame.origin.x, 0, imageScrollSubview.frame.size.width/3, imageScrollSubview.frame.size.height) withImageURL:imageUrlString];
    }
    else{
        imageView = [[CUploadImageView alloc] initWithFrame:CGRectMake([imageScrollSubview viewWithTag:99999].frame.origin.x, 0, imageScrollSubview.frame.size.width/3, imageScrollSubview.frame.size.height) withImage:image];
        
    }
    
    imageView.tag = image_tag_value;
    imageView.delegate = self;
    [imageScrollSubview addSubview:imageView];
    
    
    

    for (UIView *view in imageScrollSubview.subviews) {
        if (view.tag == 99999) {
            UIView *_newImageView = [imageScrollSubview viewWithTag:image_tag_value];

            CGRect frame = view.frame;
            frame.origin.x = _newImageView.frame.origin.x + _newImageView.frame.size.width;
            view.frame = frame;

            [imageScrollSubview bringSubviewToFront:view];
        }
    }

}

#pragma mark - add button action

-(IBAction)addAction:(id)sender{
    
    photoPicker = nil;
    photoPicker = [[XIBPhotoPicker alloc] initWithFrame:CGRectMake(0,0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    photoPicker.numberOfPhotosAllowed = MAX_IMAGE_LIMIT - self.maxImageLimit;//3;//change
    photoPicker.shouldAutoPick = NO;
    photoPicker.delegate = self;
    photoPicker.clipsToBounds = NO;
    [[AppManager sharedManager] hideNavigationBar];
    //[parentViewController.view addSubview:photoPicker];
    
}

#pragma mark- XIBPhotoPickerDelegate

- (void)photoPickDone:(NSArray *)selectedPhotos{
    
    
    [[AppManager sharedManager] showNavigationBar];
    [photoPicker removeFromSuperview];
    photoPicker = nil;
    
    if ([selectedPhotos count]>0) {
        [selectedPhotos enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIImage *image = (UIImage *)obj;
            XLog(@"%d",(int)idx);
            [self addImageTOScrollview:image withUrl:nil];
            [attached_image_array addObject:image];
            self.maxImageLimit++;
            
//            NSString * imageId = [NSString stringWithFormat:@"%d",image_tag_value];
//            [attached_image_array setValue:image forKey:imageId];
        }];
    }
    
    XLog(@"%@",attached_image_array);
    
}



#pragma mark - image uploader delegate

-(void)clickedDeleteButton:(NSInteger)tagID{
    XLog(@"RRRR : Delete tag ---- %i", (int)tagID);
  
    [self reallocateAttachecdArray:tagID];
    [self reallocateImageScrollviewContent:tagID];
    
    
    //[NSString stringWithFormat:@"%i", tagID]];
//    [attached_image_array removeObjectAtIndex:(tagID-101)];
//    self.maxImageLimit = self.maxImageLimit - 1;
    
}

//-(void)recievedPhotoName:(NSString *)serverPhotoName tag:(NSInteger)tagID{
//    NSLog(@"RRRR : %@ ---- ",serverPhotoName);
//    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: serverPhotoName, @"ServerPhotoName",  [NSString stringWithFormat:@"%i",tagID], @"TagId", nil];
//    [attached_image_array addObject:dict];
//}

#pragma mark - image remove and reallocate scrollview content
-(void)reallocateImageScrollviewContent:(NSInteger)tagID{
    
    CGRect previousFrame = CGRectZero;
    
    for (UIView *view in imageScrollSubview.subviews) {
        if (view.tag == tagID) {
            previousFrame = view.frame;
            [view removeFromSuperview];
        }
    }
    
    for (UIView *view in imageScrollSubview.subviews) {
        if (view.tag > tagID) {
            NSLog(@"Subview tag %i %i", (int)view.tag , (int)tagID);
            CGRect frame = view.frame;
            view.frame = previousFrame;
            previousFrame = frame;
        }
    }
    
    image_tag_value = 100;
    
    
    for (UIView *view in imageScrollSubview.subviews) {
        
        NSLog(@"%d",(int)view.tag);
        
        
        if ([view isKindOfClass:[CUploadImageView class]]&& view.tag!=99999) {
            NSLog(@"Subview tag %i %i", (int)view.tag , (int)tagID);
            image_tag_value = image_tag_value+1;
           view.tag=image_tag_value;
        }
    }
    
    
    
    for (UIView *view in imageScrollSubview.subviews) {
        
        NSLog(@"--->%d",(int)view.tag);
    }
    
}

-(void)reallocateAttachecdArray:(NSInteger)tagId{
    /*for (int i = 0; i < attached_image_array.count; i ++) {
       
        NSDictionary *dict = [attached_image_array objectAtIndex:i];
        NSString *imageTag = [dict valueForKey:@"TagId"];
        
        if ([imageTag isEqualToString:tagString]) {
            self.maxImageLimit = self.maxImageLimit - 1;
            [attached_image_array removeObjectAtIndex:i];
        }
    }*/
    
    [attached_image_array removeObjectAtIndex:(tagId-101)];
    
    
    self.maxImageLimit = self.maxImageLimit - 1;

}


/*
#pragma mark - Old initialize method
-(void)createOldMethod:(NSArray *)photos{
    //Create left image view
    UIView *imageBgView = [self createImageView:CGRectMake(10, 10, 150, 150)];
    
    //Create right add button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"add_image_demo.png"] forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(addAction:)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(imageBgView.frame.origin.x + imageBgView.frame.size.width, imageBgView.frame.origin.y, 55, 55);
    
    [button setCenter:CGPointMake(imageBgView.frame.origin.x + imageBgView.frame.size.width + (imageBgView.frame.size.width/2), imageBgView.frame.origin.y + imageBgView.frame.size.height/2)];
    [self addSubview:button];
    
    if(photos.count > 0){
        [self createImageViewByArray:photos];
    }
}
#pragma mark - others

-(void)createImageViewByArray:(NSArray *)photosArray{
    for (NSDictionary *photoDic in photosArray) {
        
        NSString *photosUrl = [photoDic objectForKey:@"photo"];
        NSString *photosName = [photosUrl stringByReplacingOccurrencesOfString:@"uploads/classified/" withString:@""];
        
        [self callImageUploader:nil withUrl:photosUrl];
        
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys: photosName, @"ServerPhotoName",  [NSString stringWithFormat:@"%i",image_tag_value], @"TagId", nil];
        [attached_image_array addObject:dict];
        
    }
}



#pragma mark - Action sheet 
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self takeNewPhotoFromCamera];
            break;
        case 1:
            [self choosePhotoFromExistingImages];
        default:
            break;
    }
}
- (void)takeNewPhotoFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        controller.allowsEditing = NO;
        controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
        controller.delegate = self;
        [parentViewController presentViewController: controller animated: YES completion: nil];
    }
}

-(void)choosePhotoFromExistingImages
{
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = 3 - self.maxImageLimit;
    elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.imagePickerDelegate = self;
    
    [parentViewController presentViewController:elcPicker animated:YES completion:nil];
    
}



#pragma mark - Upload image to the server

-(void)callImageUploader:(UIImage *)image withUrl:(NSString *)_url{
    
    CGSize contentSize = imageScrollview.contentSize;
    image_tag_value = image_tag_value + 1;

    
    
    CUploadImageView *imageView ;
    
    if (_url == nil) {
        imageView = [[CUploadImageView alloc] initWithFrame:CGRectMake(contentSize.width, 0, imageScrollview.frame.size.width, imageScrollview.frame.size.height) withImage:image];
    }
    else{
        imageView = [[CUploadImageView alloc] initWithFrame:CGRectMake(contentSize.width, 0, imageScrollview.frame.size.width, imageScrollview.frame.size.height) withImageURL:_url];
    }
    imageView.tag = image_tag_value;
    imageView.delegate = self;
    [imageScrollview addSubview:imageView];

    
	[imageScrollview setPagingEnabled:YES];
	[imageScrollview setContentSize:CGSizeMake(imageView.frame.origin.x + imageView.frame.size.width, imageView.frame.size.height)];
    self.maxImageLimit = self.maxImageLimit + 1;
}


#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [parentViewController dismissViewControllerAnimated:YES completion:nil];
	
//    for (UIView *v in [imageScrollview subviews]) {
//        [v removeFromSuperview];
//    }
//	CGRect workingFrame = imageScrollview.frame;
//	workingFrame.origin.x = 0;
    
//    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
	
	for (NSDictionary *dict in info) {
        
        UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
        [self callImageUploader:image withUrl:nil];
//		imageview.frame = workingFrame;
//		[imageScrollview addSubview:imageview];
//		workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
	}
    
//    self.chosenImages = images;
	 
//	[imageScrollview setPagingEnabled:YES];
//	[imageScrollview setContentSize:CGSizeMake(workingFrame.origin.x, workingFrame.size.height)];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [parentViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Image Picker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [parentViewController dismissViewControllerAnimated: YES completion: nil];
    UIImage *image = [info valueForKey: UIImagePickerControllerOriginalImage];
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    
    [self savePhoto:image];
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [parentViewController dismissViewControllerAnimated: YES completion: nil];
}


#pragma mark - Save photo to the gallary
- (void) savePhoto:(UIImage *)image {
    [XIBActivityIndicator startActivity];
    
    NSParameterAssert(image);
    //save image date in a compilation block
    UIImageWriteToSavedPhotosAlbum(image,
                                   self,
                                   @selector(thisImage:hasBeenSavedInPhotoAlbumWithError:usingContextInfo:),
                                   NULL);
    
}

- (void)thisImage:(UIImage *)image hasBeenSavedInPhotoAlbumWithError:(NSError *)error usingContextInfo:(void*)ctxInfo {
    if (error) {
        [XIBActivityIndicator dismissActivity];
        [[[UIAlertView alloc] initWithTitle:IMAGE_SAVING_ERROR_MESSAGE message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    } else {
        [XIBActivityIndicator dismissActivity];
        [self callImageUploader:image withUrl:nil];
    }
}



-(void)addImageToImageScrollview{
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
