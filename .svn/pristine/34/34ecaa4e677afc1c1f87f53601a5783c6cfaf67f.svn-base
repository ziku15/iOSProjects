//
//  CUploadImageView.m
//  Pulse
//
//  Created by xibic on 7/3/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "CUploadImageView.h"

@interface CUploadImageView(){
    OBShapedButton *cancelButton;
    UIView *maskView;
    UIActivityIndicatorView *activityIndicator;
    UIButton *menuButton;
//    UIImage *uploadedImage;
}

@end

@implementation CUploadImageView

@synthesize delegate;


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // Initialization code
        AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height-10)];
        [imageView setBackgroundColor:[UIColor clearColor]];
        imageView.tag = 9999;
        imageView.contentMode = UIViewContentModeRedraw;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
//        imageView = nil;
        
        maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        maskView.backgroundColor = [UIColor blackColor];
        maskView.alpha = 0.4;
        [self addSubview:maskView];
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityIndicator.hidesWhenStopped = YES;
        activityIndicator.center = maskView.center;
        [self addSubview:activityIndicator];
        [activityIndicator startAnimating];
        
        
        menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        menuButton.clipsToBounds = YES;
        [menuButton setFrame:CGRectMake(self.frame.size.width-38.5f, -11.5f, 50.0f,50.0f)];
        [menuButton setImage:[UIImage imageNamed:@"photoViewerCloseButton.png"] forState:UIControlStateNormal];
        [menuButton addTarget:self
                       action:@selector(deleteImageButtonClick)
             forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:menuButton];
        
        
    }
    return self;
}

- (void)setImageToTheView:(UIImage *)image{
    AsyncImageView *imageView = (AsyncImageView *)[self viewWithTag:9999];
    imageView.image = image;
}

- (id)initWithFrame:(CGRect)frame withImage:(UIImage *)image{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // Initialization code
        AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height-10)];

        imageView.image = image;
        imageView.contentMode = UIViewContentModeRedraw;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        imageView = nil;
        
//        maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        maskView.backgroundColor = [UIColor blackColor];
//        maskView.alpha = 0.4;
//        [self addSubview:maskView];
        
//        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        activityIndicator.hidesWhenStopped = YES;
//        activityIndicator.center = maskView.center;
//        [self addSubview:activityIndicator];
//        [activityIndicator startAnimating];
//        
        
        menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        menuButton.clipsToBounds = YES;
        [menuButton setFrame:CGRectMake(self.frame.size.width-38.5f, -11.5f, 50.0f,50.0f)];
        [menuButton setImage:[UIImage imageNamed:@"photoViewerCloseButton.png"] forState:UIControlStateNormal];
        [menuButton addTarget:self
                       action:@selector(deleteImageButtonClick)
             forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:menuButton];
        
        
        [menuButton setHidden:NO];
        

        //[self uploadImage:image];
        
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withImageURL:(NSString *)imageurl{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // Initialization code
        AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height-10)];
        
        imageView.imageURL = [NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@",SERVER_BASE_IMAGE_URL,imageurl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        imageView.contentMode = UIViewContentModeRedraw;//kImageViewContentMode;
        imageView.clipsToBounds = YES;
        imageView.showActivityIndicator = YES;
        [self addSubview:imageView];
        

        maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        maskView.backgroundColor = [UIColor blackColor];
        maskView.alpha = 0.4;
        [self addSubview:maskView];
        
        menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        menuButton.clipsToBounds = YES;
        [menuButton setFrame:CGRectMake(self.frame.size.width-38.5f, -11.5f, 50.0f,50.0f)];
        [menuButton setImage:[UIImage imageNamed:@"photoViewerCloseButton.png"] forState:UIControlStateNormal];
        [menuButton addTarget:self
                       action:@selector(deleteImageButtonClick)
             forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:menuButton];
        
    }
    return self;
}

- (void)uploadImage:(UIImage*)image{
    
    dispatch_queue_t apiQueue = dispatch_queue_create("API Queue", NULL);
    dispatch_async(apiQueue, ^{
        NSLog(@"%@",[UserManager sharedManager].userID);
            NSLog(@"%@",[UserManager sharedManager].userAccessToken);
        
        // Build the request body
        NSString *boundary = @"SportuondoFormBoundary";
        NSMutableData *body = [NSMutableData data];
        
        // Body part for "USER ID" parameter. This is a string.
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"user_id"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [UserManager sharedManager ].userID] dataUsingEncoding:NSUTF8StringEncoding]];
        
        // Body part for "ACCESS TOKEN" parameter. This is a string.
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"access_token"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [UserManager sharedManager].userAccessToken] dataUsingEncoding:NSUTF8StringEncoding]];
        ///*
        // Body part for "FUNC_ID" parameter. This is a string.
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"func_id"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", @"19"] dataUsingEncoding:NSUTF8StringEncoding]];
        //*/
        // Body part for the attachament. This is an image.
        //imageData = UIImageJPEGRepresentation(image, 0.6);
        NSData *imageData =  UIImageJPEGRepresentation(image, 0.6);//UIImagePNGRepresentation(image);
        NSString *fileName = [NSString stringWithFormat:@"userClassifiedUploadImag%d.jpeg",arc4random()%50000+arc4random()%20000];
        if (imageData) {                                                                            
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", @"image",fileName] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:imageData];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        // Setup the session
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPAdditionalHeaders = @{
                                                       @"func_id"       : @"19",
                                                       @"Accept"        : @"application/json",
                                                       @"Content-Type"  : [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary]
                                                       };
        
        // Create the session
        // We can use the delegate to track upload progress
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        
        // Data uploading task. We could use NSURLSessionUploadTask instead of NSURLSessionDataTask if we needed to support uploads in the background
        NSURL *url = [NSURL URLWithString:[HttpManager sharedManager].serverURL];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"POST";
        request.HTTPBody = body;
        NSURLSessionDataTask *yuploadTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error) {
                NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                //NSLog(@"#### %@ ####", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                if (httpResp.statusCode == 200) {
                    NSError *jsonError;
                    //XLog(@"Data 2: %@",data);
                    NSDictionary *jsonData =
                    [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingAllowFragments
                                                      error:&jsonError];
                    if (!jsonError) {
                        dispatch_async(dispatch_get_main_queue(), ^{

                            NSDictionary *dictonary = [jsonData objectForKey:@"data"];
                            NSString *photoName = [dictonary objectForKey:@"photo_name"];
                            maskView.alpha = 0.1;
                            [activityIndicator stopAnimating];
                            [menuButton setHidden:NO];
//                            uploadedImage = nil;
                            [self.delegate recievedPhotoName:photoName tag:self.tag];
                        });
                        //XLog(@"jsonData # %@ - Data - %@",params,jsonData);
                        //callback(jsonData);
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //[XIBActivityIndicator dismissActivity];
                            maskView.alpha = 0.1;
                            [activityIndicator stopAnimating];
                            
                            [menuButton setHidden:NO];
                        });
                        //XLog(@"JsonError # Error - %@",jsonError);
                        //callback(nil);
                    }
                }
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    XLog(@"RequestError # Error - %@ \n\n",error);
                    //[XIBActivityIndicator dismissActivity];
                    maskView.alpha = 0.1;
                    [activityIndicator stopAnimating];
                    
                    [menuButton setHidden:NO];
                });
            }
            
        }];
        [yuploadTask resume];
        
    });
}

- (void)deleteImageButtonClick{
    [self.delegate clickedDeleteButton:self.tag];
}


@end
