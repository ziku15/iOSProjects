//
//  PostClassifiedViewController.m
//  Pulse
//
//  Created by Supran on 7/1/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "NewPostClassifiedViewController.h"

@interface NewPostClassifiedViewController (){
    OffersAndPromotionsShowView *categoryDropDownView;
    Categorytableview *categoryTableView;
    UITextField *titleTextField;
    UITextView *descriptionTextview;
    UILabel *remainningDescriptionLabel;
    UIScrollView *mainScrollview ;
    AttachedThumbnailsImageSubview *attachView;
    
    PopupView *popupView;
    FooterView *footerView;
    PostClassifiedItem *postClassifiedItem;
    ClassifiedItem *classifiedItem;
    
    UIAlertView *_alertMsg;
    
     NSMutableArray *photoNameArray;

}

@end

@implementation NewPostClassifiedViewController


//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//        
////        postClassifiedItem = nil;
////        previewClassifiedController = nil;
//    }
//    return self;
//}

-(id)init:(ClassifiedItem *)item{
    self = [super self];
    if (self) {
        [super setNavigationCustomTitleView:@"Classifieds" with:@"create a new post"];
        classifiedItem = item;
    }
    return self;
}

#pragma mark - PopupView delegate

-(void)createLeavePopupview{
    popupView = [[PopupView alloc] initWithFrame:CGRectZero with:self];
   
}

-(void)popupDiscardAction{
    [popupView removeFromSuperview];
    [super goBack];
}

-(void)popupSaveAction{
    [self callApiMethod];
}

-(void)callApiMethod{
    
    if (classifiedItem.isDraft == 1) {
        [self callUpdateClassifiedPostApi];
    }
    else{
        classifiedItem.isDraft = 1;
        [self callAddClassifiedPostApi];
    }
    
}


#pragma mark - UIalertview Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 101){
        if (buttonIndex == 0) {
            [popupView removeFromSuperview];
            [super goBack];
        }
    }
}

#pragma mark - parent view controller delegate
- (void)goBack{
    if ([titleTextField.text isEqualToString:@""] && [descriptionTextview.text isEqualToString:@""] && [categoryDropDownView.showTextField.text isEqualToString:@"None"]){
        [super goBack];
    }
    else if ([self checkViewUpdateOrNot]) {
//        if (attachView.attached_image_array.count < attachView.maxImageLimit) {
//            [[[UIAlertView alloc] initWithTitle:@"Please wait,loading images" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]show];
//        }
//        else{
//            [popupView openPopupAnimation];
//        }
     [popupView openPopupAnimation];
    }
    else{
        if (attachView.attached_image_array.count > 0 )
            [popupView openPopupAnimation];
        else{
            [popupView removeFromSuperview];
            [super goBack];
        }
    }
}


-(BOOL)checkViewUpdateOrNot{
    BOOL isTitleUpdate = NO;
    NSString *titleStr = [titleTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (![titleStr isEqualToString:@""])
        isTitleUpdate = YES;
    else{
        titleTextField.text = @"";
    }

    BOOL isDescriptionUpdate = NO;
    if (![descriptionTextview.text isEqualToString:@"Max 200 words.."])
        isDescriptionUpdate = YES;
    
    
    BOOL isCategoryUpdate  = NO;
    if (![categoryDropDownView.showTextField.text isEqualToString:@"None"])
        isCategoryUpdate = YES;
    
    BOOL isViewUpdate = NO;
    if (isCategoryUpdate || isDescriptionUpdate || isTitleUpdate) {
        isViewUpdate = YES;
    }
    
    if (classifiedItem.isDraft == 1) {
        isViewUpdate = YES;
    }
    return isViewUpdate;
}


#pragma mark - Common View Controller Delegate
- (void)rightBarButtonAction{
    if ([self checkViewUpdateOrNot]) {
        
//        if (attachView.attached_image_array.count < attachView.maxImageLimit) {
//            [[[UIAlertView alloc] initWithTitle:@"Please wait,loading images" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]show];
//        }
//        else{
//            [popupView openPopupAnimation];
//                
//        }
        [popupView openPopupAnimation];
        
    }
    else{
        
        if (attachView.attached_image_array.count > 0 )
            [popupView openPopupAnimation];
        else{
            [popupView removeFromSuperview];
            [super rightBarButtonAction];
        }
    }
}

//#pragma mark - Attached Image View Delegate
//-(void)imageScrollviewModified{
//    [self nextButtonEnableMethod];
//}
#pragma mark - footer view Delegate
-(void)createFooterView{
//    CGFloat height = 50;
    footerView = [[FooterView alloc] initWithFrame:CGRectMake(0, SCREEN_SIZE.height - (64 + FOOTER_HEIGHT), SCREEN_SIZE.width, FOOTER_HEIGHT) withIdentity:0 withParent:self];
    [self nextButtonEnableMethod];
    [self.view addSubview:footerView];

}

-(void)leftButtonAction{
    if ([titleTextField.text isEqualToString:@""] && [descriptionTextview.text isEqualToString:@""] && [categoryDropDownView.showTextField.text isEqualToString:@"None"]){
        [super goBack];
    }
//    else if (attachView.attached_image_array.count < attachView.maxImageLimit) {
//        [[[UIAlertView alloc] initWithTitle:@"Please wait,loading images" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]show];
//    }
    else{
        [popupView openPopupAnimation];
    }
}

- (void)handleSingleTap:(UITapGestureRecognizer*)sender{
    [_alertMsg dismissWithClickedButtonIndex:1 animated:YES];
    [self.view removeFromSuperview];
}

-(void)rightButtonMethod{
    
    if ([self checkViewUpdateOrNot]) {
        XLog(@"%@",attachView.attached_image_array);
//        if (attachView.attached_image_array.count < attachView.maxImageLimit) {
//            [[[UIAlertView alloc] initWithTitle:@"Please wait,loading images" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]show];
//        }
//        else{
        
            postClassifiedItem = nil;
            postClassifiedItem = [[PostClassifiedItem alloc] init];
            
            postClassifiedItem.title = titleTextField.text;
            postClassifiedItem.cat_Name = categoryDropDownView.showTextField.text;
            postClassifiedItem.cat_id = [NSString stringWithFormat:@"%li", (long)categoryDropDownView.showTextField.tag];
            postClassifiedItem.description = descriptionTextview.text;
            postClassifiedItem.isDraft = classifiedItem.isDraft;
            postClassifiedItem.item_id = classifiedItem.itemID;
            
            /*NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in attachView.attached_image_array) {
                NSString *photosName = [dic objectForKey:@"ServerPhotoName"];
                if (photosName.length > 0 || photosName != nil) {
                    photosName = [@"uploads/classified/" stringByAppendingString:photosName];
                }
                else{
                    photosName = @"";
                }
                [tempArray addObject:photosName];
            }*/
            postClassifiedItem.photosArray = attachView.attached_image_array;//tempArray;
            
            
            PreviewClassifiedViewController *previewClassifiedController = [[PreviewClassifiedViewController alloc] init:postClassifiedItem];
            previewClassifiedController.shouldShowRightMenuButton = YES;
            [self.navigationController pushViewController:previewClassifiedController animated:YES];

        //}
        
    }
    else{
        [[[UIAlertView alloc] initWithTitle:@"All fields are required to fill first" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]show];
    }

}

#pragma mark --------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

    
    //Create main Scrollview
    mainScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - (64 + FOOTER_HEIGHT))];
    [mainScrollview setContentSize:CGSizeMake(mainScrollview.frame.size.width, mainScrollview.frame.size.height)];
    [mainScrollview setUserInteractionEnabled:YES];
    [self.view addSubview:mainScrollview];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    singleTap.cancelsTouchesInView = NO;
    [mainScrollview addGestureRecognizer:singleTap];
    
    //Create Title View
    UIView *titleView = [self createTitleView];
    [mainScrollview addSubview:titleView];
    //Create Drop Down View
    UIView *categoryView = [self createCategoryView:titleView.frame];
    [mainScrollview addSubview:categoryView];
    

    
    //Create Description View
    UIView *descriptionView = [self createDescriptionView:categoryView.frame];
    [mainScrollview addSubview:descriptionView];
    
    //Create Image Slider view
    [self createImageAttachView:descriptionView.frame];
    [mainScrollview addSubview:attachView];
    [mainScrollview setContentSize:CGSizeMake(attachView.frame.size.width, attachView.frame.origin.y + attachView.frame.size.height)];
    
    //Create Drop Down View
    [self createCategoryDropDownView:categoryView.frame];
    [mainScrollview addSubview:categoryTableView];
    [mainScrollview bringSubviewToFront:categoryTableView];
    
    
    //Fetch category Data by call api
    [self populateDropDownList];
    
    


    
    //Create pop up view
    [self createLeavePopupview];

    
    
    //Create Footer view
    [self createFooterView];
    
      photoNameArray=[[NSMutableArray alloc]init];
}


- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    [self resetTextFieldAppeareance];
    [titleTextField resignFirstResponder];
    [descriptionTextview resignFirstResponder];
}

#pragma mark - Hide Keyboard on BG Touch

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Create Image Slider view

-(UIView *)createImageAttachView:(CGRect)previousFrame{
    attachView = [[AttachedThumbnailsImageSubview alloc] initWithFrame:CGRectMake(previousFrame.origin.x, previousFrame.origin.y + previousFrame.size.height, previousFrame.size.width, 120) with:self photoArray:classifiedItem.photos];
//    [attachView setDelegate:self];
    return attachView;
}
#pragma mark - Description View

-(UIView *)createDescriptionView:(CGRect)previousFrame{
    UIView *descriptionView = [[UIView alloc] initWithFrame:CGRectMake(previousFrame.origin.x, previousFrame.origin.y + previousFrame.size.height, previousFrame.size.width, 150)];
    [descriptionView setBackgroundColor:[UIColor clearColor]];

    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, descriptionView.frame.size.width-50, 15)];
    [titleLabel setText:@"Description"];
    [titleLabel setTextColor:[UIColor sidraFlatDarkGrayColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [descriptionView addSubview:titleLabel];
    
    remainningDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width, 5, 30, 15)];
    [remainningDescriptionLabel setTextAlignment:NSTextAlignmentRight];
    [remainningDescriptionLabel setText:@"200"];
    [remainningDescriptionLabel setTextColor:[UIColor sidraFlatDarkGrayColor]];
    [remainningDescriptionLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [remainningDescriptionLabel setBackgroundColor:[UIColor clearColor]];
    [descriptionView addSubview:remainningDescriptionLabel];
    
    descriptionTextview = [[UITextView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height + 3, descriptionView.frame.size.width - 20, 120)];
    [descriptionTextview setAutocorrectionType:UITextAutocorrectionTypeNo];
    [descriptionTextview setBackgroundColor:[UIColor whiteColor]];
    [descriptionTextview setDelegate:self];
    descriptionTextview.layer.borderWidth = kViewBorderWidth;
    descriptionTextview.layer.borderColor = kViewBorderColor;
    descriptionTextview.layer.cornerRadius = kSubViewCornerRadius;
    descriptionTextview.layer.masksToBounds = YES;
    [descriptionTextview setReturnKeyType:UIReturnKeyDone];
    [descriptionTextview setText:@"Max 200 words.."];
    [descriptionTextview setTextColor:[UIColor sidraFlatLightGrayColor]];
    if (![classifiedItem.a_description isEqualToString:@""]) {
        [descriptionTextview setText:[NSString stringWithFormat:@"%@",classifiedItem.a_description]];
        descriptionTextview.textColor = [UIColor sidraFlatDarkGrayColor];
    }
    [descriptionView addSubview:descriptionTextview];
    
    return descriptionView;
}

#pragma mark - View Container
- (void)resetTextFieldAppeareance{
    CGRect frame = self.view.frame;
    if(frame.origin.y != 64){
        frame.origin.y = 64;
        [UIView animateWithDuration:0.4 animations:^{
            self.view.frame = frame;
        }];
    }
}

- (void)moveUpTextFieldContainerAppearance{
    CGRect frame = self.view.frame;
    if(frame.origin.y != -10){
        frame.origin.y = -10;
        [UIView animateWithDuration:0.4 animations:^{
            self.view.frame = frame;
        }];
    }
}

-(void)nextButtonEnableMethod{
    
    if ([self checkViewUpdateForNextButtonEnable]) {
        [footerView.rightButton setEnabled:YES];
    }
    else{
        [footerView.rightButton setEnabled:NO];
    }
    
}

-(BOOL)checkViewUpdateForNextButtonEnable{
    BOOL isTitleUpdate = NO;
    NSString *titleStr = [titleTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (![titleStr isEqualToString:@""])
        isTitleUpdate = YES;
    else{
        titleTextField.text = @"";
    }
    
    BOOL isDescriptionUpdate = NO;
    if (![descriptionTextview.text isEqualToString:@"Max 200 words.."])
        isDescriptionUpdate = YES;
    
    BOOL isCategoryUpdate = NO;
    if (![categoryDropDownView.showTextField.text isEqualToString:@"None"])
        isCategoryUpdate = YES;
    
    
    BOOL isViewUpdate = NO;
    if (isDescriptionUpdate && isTitleUpdate && isCategoryUpdate) {
        isViewUpdate = YES;
    }
    
    return isViewUpdate;
}
#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self nextButtonEnableMethod];
}
#pragma mark - TextView Delegate

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    [self moveUpTextFieldContainerAppearance];
    if ([textView.text isEqualToString:@"Max 200 words.."]) {
        textView.text = @"";
        textView.textColor = [UIColor sidraFlatDarkGrayColor];
        
        [remainningDescriptionLabel setText:@"200"];
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSString *string = [textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(string.length == 0){
        textView.textColor = [UIColor sidraFlatLightGrayColor];
        textView.text = @"Max 200 words..";
        [textView resignFirstResponder];
        [self resetTextFieldAppeareance];
        
        
        [remainningDescriptionLabel setText:@"200"];
    }
    
    [self nextButtonEnableMethod];
    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    NSUInteger newLength = (textView.text.length - range.length) + text.length;
    if(newLength <= MAX_LENGTH)
    {
        if([text isEqualToString:@"\n"]) {
            [self resetTextFieldAppeareance];
            [textView resignFirstResponder];
            
            if(textView.text.length == 0){
                textView.textColor = [UIColor sidraFlatLightGrayColor];
                textView.text = @"Max 200 words..";
            }
            return NO;
        }
        
        int length = 200 - newLength;
        [remainningDescriptionLabel setText:[NSString stringWithFormat:@"%i",length]];
        return YES;
    } else {
//        NSUInteger emptySpace = MAX_LENGTH - (textView.text.length - range.length);
//        textView.text = [[[textView.text substringToIndex:range.location]
//                          stringByAppendingString:[text substringToIndex:emptySpace]]
//                         stringByAppendingString:[textView.text substringFromIndex:(range.location + range.length)]];
//        
//        if (emptySpace == 0) {
            [self resetTextFieldAppeareance];
            [textView resignFirstResponder];
//        }
        return NO;
    }
    
    
}



#pragma mark - Call Api Method

-(void)populateDropDownList{
    [XIBActivityIndicator startActivity];
    [[ServerManager sharedManager] fetchClassifiedCategories:^(BOOL success, NSMutableArray *resultDataArray) {
        if (success) {
            
            //Call Drop Down Value Api Here
            [XIBActivityIndicator dismissActivity];
            if (classifiedItem.isDraft == 1) {
                [categoryTableView setDataArrayValueForClassified:resultDataArray cat_id:classifiedItem.catID];
            }
            else{
                [categoryTableView setDataArrayValueForClassified:resultDataArray cat_id:0];
            }
        }
        else{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [[[UIAlertView alloc] initWithTitle:@"Server Error, Please go previous page and try again" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
//            });
        }
    }];
    
}


#pragma mark - Category Table view delegate
-(void)categorySelect:(NSString *)categoryName withCatId:(NSInteger)cat_id{
    [self closeCategoryTableview];
    [categoryDropDownView.showTextField setText:categoryName];
    [categoryDropDownView.showTextField setTag:cat_id];

    [self nextButtonEnableMethod];
}

-(void)closeCategoryTableview{
    //If category tableview open then close it
    if (!categoryTableView.hidden) {
        [self dropDownAction:categoryDropDownView.selectButton];
    }
}

#pragma mark - Category View
-(UIView *)createCategoryView:(CGRect)previousFrame{
    UIView *categoryView = [[UIView alloc] initWithFrame:CGRectMake(previousFrame.origin.x, previousFrame.origin.y + previousFrame.size.height, self.view.frame.size.width, 65)];
    [categoryView setBackgroundColor:[UIColor clearColor]];

    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, categoryView.frame.size.width-10, 15)];
    [titleLabel setText:@"Category*"];
    [titleLabel setTextColor:[UIColor sidraFlatDarkGrayColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [categoryView addSubview:titleLabel];
    
    //Create show view
    categoryDropDownView = [[OffersAndPromotionsShowView alloc] initWithFrame:CGRectMake(previousFrame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height, categoryView.frame.size.width, 50)];
    [categoryDropDownView.selectButton addTarget:self
                                      action:@selector(dropDownAction:)
                            forControlEvents:UIControlEventTouchUpInside];
    [categoryView addSubview:categoryDropDownView];

    
    return categoryView;
}


#pragma mark - Create DropDown View
-(void)createCategoryDropDownView:(CGRect)topFrame{
    
    categoryTableView= [[Categorytableview alloc] initMethodGeneral:CGRectMake(topFrame.origin.x, topFrame.origin.y + topFrame.size.height - 5, topFrame.size.width, SCREEN_SIZE.height) with:self];
    [categoryTableView setHidden:YES];
    
}
#pragma mark -Drop Down Show Button Action

-(IBAction)dropDownAction:(id)sender{
    
    if (categoryTableView.hidden) {
        [categoryTableView openCategoryView];
    }
    else{
        [categoryTableView closeCategoryView];
    }
    
}

#pragma mark - Title View
-(UIView *)createTitleView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    [titleView setBackgroundColor:[UIColor clearColor]];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, titleView.frame.size.width-10, 15)];
    [titleLabel setText:@"Title*"];
    [titleLabel setTextColor:[UIColor sidraFlatDarkGrayColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleView addSubview:titleLabel];
    
    UIView *textFieldView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.frame.size.height + 5, titleLabel.frame.size.width - 10, 30)];
    [textFieldView setBackgroundColor:[UIColor whiteColor]];
    textFieldView.layer.borderWidth = kViewBorderWidth;
    textFieldView.layer.borderColor = kViewBorderColor;
    textFieldView.layer.cornerRadius = kSubViewCornerRadius;
    textFieldView.layer.masksToBounds = YES;
    [titleView addSubview:textFieldView];
    
    titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(5,2,textFieldView.frame.size.width-8, textFieldView.frame.size.height - 4)];
    [titleTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [titleTextField setTextColor:[UIColor sidraFlatLightGrayColor]];
    [titleTextField setBackgroundColor:[UIColor whiteColor]];
    [titleTextField setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [titleTextField setDelegate:self];
    [titleTextField setPlaceholder:@"Write here"];
    if (![classifiedItem.title isEqualToString:@""]) {
        [titleTextField setText:[NSString stringWithFormat:@"%@",classifiedItem.title]];
    }
    [textFieldView addSubview:titleTextField];
    
    return titleView;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - SerVer API
#pragma mark - Post Post API



-(void) postClassifiedData :(NSString*)successMsg unSuccessMsg:(NSString*)unsuccessMsg{
    
    [XIBActivityIndicator startActivity];
    [photoNameArray removeAllObjects];
    
    if(attachView.attached_image_array.count==0)
        [self callAddClassifiedPostApi:successMsg unsuccessfullMessage:unsuccessMsg];

        
else
{
    
        
    for (int i=0;i<attachView.attached_image_array.count;i++) {
        
        [[ServerManager sharedManager] uploadImage:(UIImage*)[attachView.attached_image_array objectAtIndex:i] completion:^(BOOL success, NSString *resultString) {
            
            
            if (success) {
                
                [photoNameArray addObject:resultString];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(photoNameArray.count==attachView.attached_image_array.count){
                        
                        
                            [self callAddClassifiedPostApi:successMsg unsuccessfullMessage:unsuccessMsg];
                        
                    }
                    
                    
                    
                });
                
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    [[[UIAlertView alloc] initWithTitle:@"UNSUCCESS" message:@"Classified Not Updated, Please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                    
                });
                
            }
            
            
        }];
        
    }
}
}



-(void)callAddClassifiedPostApi:(NSString *)successfullMessage unsuccessfullMessage:(NSString *)unsuccessfullMessage{
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    if (photoNameArray.count > 0) {
        for (NSString *photosUrl in photoNameArray) {
            NSString *photosName = [photosUrl stringByReplacingOccurrencesOfString:@"uploads/classified/" withString:@""];
            [tempArray addObject:photosName];
        }
    }
    
    //@[@"140496404010397981_662617793826868_56480279239687492_n.jpg",@"1404964064images (3).jpeg",@"1404964083images (1).jpeg"]
    [[ServerManager sharedManager] addClassifiedWithCatID:[NSString stringWithFormat:@"%i", (int)categoryDropDownView.showTextField.tag]
                                                    title:[NSString stringWithFormat:@"%@",titleTextField.text]
                                              description:[NSString stringWithFormat:@"%@",([descriptionTextview.text isEqualToString:@"Max 200 words.."] ? @"" : descriptionTextview.text)]
                                                    photo:tempArray
                                                  isDraft:@"1"
                                               completion:^(BOOL success) {
                                                   if (success) {
                                                       
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           
                                                           
                                                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Classified Posted" message:successfullMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                           alert.tag = 101;
                                                           [alert show];
                                                           
                                                       });
                                                       
                                                   }else{
                                                       
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           [[[UIAlertView alloc] initWithTitle:@"Classified Not Posted" message:unsuccessfullMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                                                       });
                                                       
                                                   }
                                                   //
                                               }];
}






-(void)callUpdateClassifiedPostApi_Finally{
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    if (photoNameArray.count > 0) {
        for (NSString *photosUrl in photoNameArray) {
            NSString *photosName = [photosUrl stringByReplacingOccurrencesOfString:@"uploads/classified/" withString:@""];
            [tempArray addObject:photosName];
        }
    }
    
 
    
    
    [[ServerManager sharedManager] updateClassifiedWithCatID:[NSString stringWithFormat:@"%i", (int)categoryDropDownView.showTextField.tag]
                                                classifiedID:[NSString stringWithFormat:@"%@",classifiedItem.itemID]
                                                       title:[NSString stringWithFormat:@"%@",titleTextField.text]
                                                 description:[NSString stringWithFormat:@"%@",([descriptionTextview.text isEqualToString:@"Max 200 words.."] ? @"" : descriptionTextview.text)]
                                                       photo:tempArray
                                                     isDraft:@"1"
                                                  completion:^(BOOL success){
                                                      
                                                      if (success) {
                                                          
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SUCCESS" message:@"Draft updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                              alert.tag = 101;
                                                              [alert show];
                                                          });
                                                          
                                                      }else{
                                                          
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              [[[UIAlertView alloc] initWithTitle:@"UNSUCCESS" message:@"Draft failed to Update, Please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                                                          });
                                                          
                                                      }
                                                      
                                                  }];
    
    
}


/*---------------------------*/



-(void)callAddClassifiedPostApi{
    
    [self postClassifiedData:@"Saved as Draft" unSuccessMsg:@"Save failed, please try again"];
    
  /*  NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    if (attachView.attached_image_array.count > 0) {
        for (NSDictionary *dic in attachView.attached_image_array) {
            NSString *photosName = [dic objectForKey:@"ServerPhotoName"];
            [tempArray addObject:photosName];
        }
    }
    
    //    postClassifiedItem.photosArray = tempArray;
    
    [[ServerManager sharedManager] addClassifiedWithCatID:[NSString stringWithFormat:@"%i", (int)categoryDropDownView.showTextField.tag]
                                                    title:[NSString stringWithFormat:@"%@",titleTextField.text]
                                              description:[NSString stringWithFormat:@"%@",([descriptionTextview.text isEqualToString:@"Max 200 words.."] ? @"" : descriptionTextview.text)]
                                                    photo:tempArray
                                                  isDraft:[NSString stringWithFormat:@"%i",classifiedItem.isDraft]
                                               completion:^(BOOL success) {
                                                   if (success) {
                                                       
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           
                                                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved as Draft" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                           alert.tag = 101;
                                                           [alert show];
                                                           
                                                       });
                                                       
                                                   }else{
                                                       
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           [[[UIAlertView alloc] initWithTitle:@"Save failed, please try again" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                                                       });
                                                       
                                                   }
                                               }];*/
}

-(void)callUpdateClassifiedPostApi{
    
   // [self postClassifiedData:@"Draft updated" unSuccessMsg:@"Draft failed to Update, Please try again"];
    
    [XIBActivityIndicator startActivity];
    [photoNameArray removeAllObjects];
    
    if(attachView.attached_image_array.count==0){
         [self callUpdateClassifiedPostApi_Finally];
    
    
    }
    else{
    for (int i=0;i<attachView.attached_image_array.count;i++) {
        
        [[ServerManager sharedManager] uploadImage:(UIImage*)[attachView.attached_image_array objectAtIndex:i] completion:^(BOOL success, NSString *resultString) {
            
            
            if (success) {
                
                [photoNameArray addObject:resultString];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(photoNameArray.count==attachView.attached_image_array.count){
                        
                  
                            
                        [self callUpdateClassifiedPostApi_Finally];
                        
                        
                        
                        
                    }
                    
                    
                    
                });
                
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    [[[UIAlertView alloc] initWithTitle:@"UNSUCCESS" message:@"Classified Not Updated, Please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                    
                });
                
            }
            
            
        }];
        
    }

    }
    
    
    
  /*  NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    if (attachView.attached_image_array.count > 0) {
        for (NSDictionary *dic in attachView.attached_image_array) {
            NSString *photosName = [dic objectForKey:@"ServerPhotoName"];
            [tempArray addObject:photosName];
        }
    }
    //    postClassifiedItem.photosArray = tempArray;
    
    [[ServerManager sharedManager] updateClassifiedWithCatID:[NSString stringWithFormat:@"%i", (int)categoryDropDownView.showTextField.tag]
                                                classifiedID:[NSString stringWithFormat:@"%@",classifiedItem.itemID]
                                                       title:[NSString stringWithFormat:@"%@",titleTextField.text]
                                                 description:[NSString stringWithFormat:@"%@",([descriptionTextview.text isEqualToString:@"Max 200 words.."] ? @"" : descriptionTextview.text)]
                                                       photo:tempArray
                                                     isDraft:[NSString stringWithFormat:@"%i",classifiedItem.isDraft]
                                                  completion:^(BOOL success){
                                                      
                                                      if (success) {
                                                          
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SUCCESS" message:@"Draft updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                              alert.tag = 101;
                                                              [alert show];
                                                          });
                                                          
                                                      }else{
                                                          
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              [[[UIAlertView alloc] initWithTitle:@"UNSUCCESS" message:@"Draft failed to Update, Please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                                                          });
                                                          
                                                      }
                                                      
                                                  }];
   */
    
}




@end
