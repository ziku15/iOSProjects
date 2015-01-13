//
//  ForumNewPostViewController.m
//  Pulse
//
//  Created by xibic on 7/15/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "ForumNewPostViewController.h"

@interface ForumNewPostViewController ()
{
    UILabel *remainningLabel ;
    int textLimit;
    NSMutableArray *hashTagArray;
    AttachedThumbnailsImageSubview *attachView;
    UITextView *descriptionTextview;
}
@end

@implementation ForumNewPostViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//        
//    }
//    return self;
//}
//

-(id)init{
    self = [super init];
    if (self) {
        [super setNavigationCustomTitleView:@"Forums" with:@"Create a New Forum Thread"];
    }
    return self;
}

- (void)goBack{
    [self.navigationController dismissViewControllerAnimated:YES
                                                  completion:^{
                                                      
                                                  }];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    textLimit = 250;
    hashTagArray = [[NSMutableArray alloc] init];
    
    UIView *topView = [self createTopView];
    UIView *middleView = [self createMiddleView:topView.frame];
    [self createImageAttachView:middleView.frame];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [descriptionTextview becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createImageAttachView:(CGRect)previousFrame{
    attachView = [[AttachedThumbnailsImageSubview alloc] initWithFrame:CGRectMake(0, SCREEN_SIZE.height - (IPHONE_5?380:328), SCREEN_SIZE.width, (IPHONE_5?99:47)) with:self photoArray:[[NSMutableArray alloc] init]];
    [attachView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:attachView];
}


#pragma mark - Middle View
-(UIView *)createMiddleView:(CGRect)previousFrame{
    UIView *descriptionView = [[UIView alloc] initWithFrame:CGRectMake(previousFrame.origin.x, previousFrame.origin.y + previousFrame.size.height + 15, previousFrame.size.width, 130)];
    [descriptionView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:descriptionView];
    
    descriptionTextview = [[UITextView alloc] initWithFrame:CGRectMake(10, 5, descriptionView.frame.size.width - 20, 120)];
    [descriptionTextview setAutocorrectionType:UITextAutocorrectionTypeNo];
    [descriptionTextview setBackgroundColor:[UIColor whiteColor]];
    [descriptionTextview setDelegate:self];
//    descriptionTextview.layer.borderWidth = kViewBorderWidth;
//    descriptionTextview.layer.borderColor = kViewBorderColor;
//    descriptionTextview.layer.cornerRadius = kSubViewCornerRadius;
    descriptionTextview.layer.masksToBounds = YES;
    [descriptionTextview setReturnKeyType:UIReturnKeyDefault];
    [descriptionView sizeToFit];
    [descriptionTextview setTextColor:[UIColor sidraFlatLightGrayColor]];
    [descriptionView addSubview:descriptionTextview];
    
    UIView *endLineView = [[UIView alloc] init];
    [endLineView setBackgroundColor:[UIColor sidraFlatGrayColor]];
    [endLineView setFrame:CGRectMake(descriptionTextview.frame.origin.x, descriptionTextview.frame.size.height + 20, descriptionTextview.frame.size.width, 0.5)];
    [self.view addSubview:endLineView];
    
    return descriptionView;
}


#pragma mark - TextView Delegate

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:TEXTVIEW_TEXT]) {
        textView.text = @"";
        textView.textColor = [UIColor sidraFlatDarkGrayColor];
    }
    
    return YES;
}

//lksafmnlk lksldfm lk m l#sss #supon nsfkjnskdjf. njkndsajkfn kjsadnfkjsad f#dsnafknksadf
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSString *string = [textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(string.length == 0){
        textView.textColor = [UIColor sidraFlatLightGrayColor];
        textView.text = TEXTVIEW_TEXT;
    }

//    NSArray *arr=[str componentsSeparatedByString:@" "];
//    NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF contains '#'"];
//    NSArray *b = [arr filteredArrayUsingPredicate:p];
//    NSLog(@"%@",b);
    

    [hashTagArray removeAllObjects];
    NSString *str=textView.text;
    NSArray *words = [str componentsSeparatedByString:@" "];
    for (NSString *word in words) {
        if ([word hasPrefix:@"#"]) {
            NSString *hashString = [word stringByReplacingOccurrencesOfString:@"#" withString:@""];
            [hashTagArray addObject:hashString];
        }
    }
    
        
    //[textView resignFirstResponder];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    //NSLog(@"%i", textView.text.length);
    int currentLimit = textLimit - (int)textView.text.length;
    [remainningLabel setText:[NSString stringWithFormat:@"%i", currentLimit]];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    
    NSUInteger newLength = (textView.text.length - range.length) + text.length;
    if(newLength <= textLimit)
    {

        if([text isEqualToString:@"\n"]) {
            //[textView resignFirstResponder];
            
            if(textView.text.length == 0){
                textView.textColor = [UIColor sidraFlatLightGrayColor];
                textView.text = TEXTVIEW_TEXT;
            }
            return NO;
        }
        
        return YES;
    } else {
        //[textView resignFirstResponder];
        return NO;
    }
    
    
}
#pragma mark - Top View 
-(UIView *)createTopView{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, 30)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:topView];
    
    remainningLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, topView.frame.size.width - (20 + 70), topView.frame.size.height - 10)];
    [remainningLabel setBackgroundColor:[UIColor clearColor]];
    [remainningLabel setText:[NSString stringWithFormat:@"%i",textLimit]];
    [remainningLabel setTextColor:[UIColor sidraFlatGrayColor]];
    [topView addSubview:remainningLabel];
    
    UIView *middleLineView = [[UIView alloc] init];
    [middleLineView setBackgroundColor:[UIColor sidraFlatGrayColor]];
    [middleLineView setFrame:CGRectMake(remainningLabel.frame.origin.x + remainningLabel.frame.size.width - 1, remainningLabel.frame.origin.y, 1, remainningLabel.frame.size.height)];
    [topView addSubview:middleLineView];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton setTitle:@"SEND" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor sidraFlatTurquoiseColor] forState:UIControlStateNormal];
    [sendButton setFrame:CGRectMake(remainningLabel.frame.origin.x + remainningLabel.frame.size.width, remainningLabel.frame.origin.y, 70, 18)];
    [sendButton addTarget:self
               action:@selector(sendButtonAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:sendButton];
    
    UIView *endLineView = [[UIView alloc] init];
    [endLineView setBackgroundColor:[UIColor sidraFlatGrayColor]];
    [endLineView setFrame:CGRectMake(remainningLabel.frame.origin.x, topView.frame.size.height - 1, topView.frame.size.width - 20, 0.5)];
    [topView addSubview:endLineView];
    
    return topView;
}

-(IBAction)sendButtonAction:(id)sender{

    if (attachView.attached_image_array.count < attachView.maxImageLimit) {
        [[[UIAlertView alloc] initWithTitle:@"Please wait for while until image loading finishes" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]show];
    }
    else{
        
        if ([self isViewUpdated]) {
            NSMutableArray *photoArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in attachView.attached_image_array) {
                NSString *photosName = [dic objectForKey:@"ServerPhotoName"];
                photosName = [@"uploads/classified/" stringByAppendingString:photosName];
                [photoArray addObject:photosName];
            }
            
            NSString *descriptionText = [NSString stringWithFormat:@"%@", descriptionTextview.text];
            NSMutableArray *tagArray = [NSMutableArray arrayWithArray:hashTagArray];
            [hashTagArray removeAllObjects];
            
            [self callPostApi:descriptionText with:tagArray with:photoArray];
        }
        else{
            [[[UIAlertView alloc] initWithTitle:@"There is nothing to post" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]show];
        }
        
    }

}

-(BOOL)isViewUpdated{
    BOOL isViewUp = false;
    
    BOOL isImageAdd = false;
    if (attachView.attached_image_array.count > 0) {
        isImageAdd = true;
    }
    
    BOOL isDesAdd = false;
    NSString *desString = [[NSString stringWithFormat:@"%@", descriptionTextview.text] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (![desString isEqualToString:@""]) {
        if (![desString isEqualToString:TEXTVIEW_TEXT]) {
            isDesAdd = true;
        }
    }
    
    if (isImageAdd) {
        isViewUp = true;
    }
    if (isDesAdd) {
        isViewUp = true;
    }
    
    return isViewUp;
}

-(void)callPostApi:(NSString *)descriptionText with:(NSMutableArray *)tagArray with:(NSMutableArray *)photoArray{
    
    [XIBActivityIndicator startActivity];
    [[ServerManager sharedManager] addForumThread:descriptionText tags:tagArray photo:photoArray completion:^(BOOL success){

        if (success) {
            [XIBActivityIndicator dismissActivity];
            [self goBack];
        }
        else{
//            [XIBActivityIndicator dismissActivity];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [[[UIAlertView alloc] initWithTitle:@"Server Error, Please go previous page and try again" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
//            });
        }
    }];
}

/*
[self createImageAttachView:CGRectMake(0, SCREEN_SIZE.height - (IPHONE_5?380:328), SCREEN_SIZE.width, (IPHONE_5?99:47))];


-(void)createImageAttachView:(CGRect)previousFrame{
    addPhotoView = [[UIView alloc] initWithFrame:previousFrame];
    addPhotoView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:addPhotoView];
    
    CGFloat buttonSize = previousFrame.size.height-2;
    
    UIImage *addPhotoImage = [UIImage imageNamed:@"plus_btn_2.png"];
    
    addPhotoButtonView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, buttonSize, buttonSize)];
    addPhotoButtonView.backgroundColor = [UIColor clearColor];
    addPhotoButtonView.userInteractionEnabled = YES;
    
    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    photoImageView.image = addPhotoImage;
    photoImageView.center = CGPointMake(addPhotoButtonView.frame.size.width/2.0f, addPhotoButtonView.frame.size.height/2.0f-10.0f);
    [addPhotoButtonView addSubview:photoImageView];
    
    UILabel *addPhotoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,84,15)];
    [addPhotoLabel setBackgroundColor:[UIColor clearColor]];
    [addPhotoLabel setFont:[UIFont systemFontOfSize:14.5f]];
    [addPhotoLabel setTextAlignment:NSTextAlignmentCenter];
    [addPhotoLabel setText:[NSString stringWithFormat:@"Add photo"]];
    [addPhotoLabel setTextColor:[UIColor blackColor]];;
    addPhotoLabel.center = CGPointMake(addPhotoButtonView.frame.size.width/2.0f, addPhotoButtonView.frame.size.height/2.0f+15.0f);
    [addPhotoButtonView addSubview:addPhotoLabel];
    
    addPhotoButtonView.center = CGPointMake(addPhotoView.frame.size.width/2.0f, addPhotoView.frame.size.height/2.0f);
    [addPhotoView addSubview:addPhotoButtonView];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhotoButtonAction:)];
    [singleTap setNumberOfTapsRequired:1];
    [addPhotoButtonView addGestureRecognizer:singleTap];
    
}

- (void)addPhotoButtonAction:(UIGestureRecognizer *)gestureRecognizer{
    //
}



*/

@end
