//
//  LoginViewController.m
//  Pulse
//
//  Created by xibic on 5/29/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>{
    XIBCheckBox *termsAndConditionsCheckBox;
    __block NSString *userNameString, *userPasswordString;
    
    CGRect popupGoToFrame,popupGoFromFrame;
    UIView *termConditionView;
}

@property (weak, nonatomic) IBOutlet UITextField *userIDTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;

@property (weak, nonatomic) IBOutlet UIButton *signInButton;

- (IBAction)signInButtonAction:(id)sender;
- (IBAction)termsAndCondtionsButtonAction:(id)sender;

@end

@implementation LoginViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor sidraFlatLightGrayColor];
    self.signInButton.backgroundColor = [UIColor sidraFlatDarkGrayColor];//sidraFlatTurquoiseColor];
    
    
    termsAndConditionsCheckBox = [[XIBCheckBox alloc] initWithFrame:CGRectMake(10, IPHONE_5?452:379, 22, 22)
                                                 withSelector:@selector(termsAndCondtionsCheckBoxAction) andTarget:self];
    [self.view addSubview:termsAndConditionsCheckBox];
    

    popupGoToFrame = CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height);
    popupGoFromFrame = CGRectMake(0, SCREEN_SIZE.height, SCREEN_SIZE.width, SCREEN_SIZE.height);
    
    NSString *tutorialText = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. \n    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    [self createTermConditionView:tutorialText];
    
    self.signInButton.enabled = FALSE;
}

-(void)createTermConditionView:(NSString *)tutorialText{
    termConditionView = [[UIView alloc] initWithFrame:popupGoFromFrame];
    [termConditionView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    [self.view addSubview:termConditionView];
    

    UIImageView *bgImageview = [[UIImageView alloc] initWithFrame:CGRectMake(9, IPHONE_5?92:48, 302, 384)];
    [bgImageview setImage:[UIImage imageNamed:@"terms_use_popup.png"]];
    [bgImageview setUserInteractionEnabled:YES];
    [termConditionView addSubview:bgImageview];
    
    
    
    UIScrollView *contantView = [[UIScrollView alloc] initWithFrame:CGRectMake(2, 40, bgImageview.frame.size.width-4
                                                                               , bgImageview.frame.size.height-45)];

    [contantView setContentSize:CGSizeMake(contantView.frame.size.width, contantView.frame.size.height)];
    [contantView setBackgroundColor:[UIColor clearColor]];
    [bgImageview addSubview:contantView];
    
    
    // Create title label
    CommonDynamicCellModel *titleDetails = [[CommonHelperClass sharedConstants] calculateLabelMaxSize:tutorialText with:[UIFont systemFontOfSize:13.0f] with:contantView.frame.size.width];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleDetails.maxSize.width, titleDetails.maxSize.height)];
    titleLabel.bounds = CGRectInset(titleLabel.frame, 10.0f, 10.0f);
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    [titleLabel setText:titleDetails.maxTitle];
    [titleLabel setFont:titleDetails.maxFont];
    [titleLabel setTextColor:[UIColor lightGrayColor]];
    [contantView addSubview:titleLabel];
    
    
    [contantView setContentSize:CGSizeMake(contantView.frame.size.width, titleLabel.frame.size.height)];
    
    
    
    //Create Cancle Button
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [cancleButton setBackgroundColor:[UIColor blackColor]];
    [cancleButton setImage:[UIImage imageNamed:@"cross_btn.png"] forState:UIControlStateNormal];
    [cancleButton setFrame:CGRectMake(bgImageview.frame.size.width - 40,-5, 50, 50)];
    [cancleButton addTarget:self
                            action:@selector(cancleAction:)
                  forControlEvents:UIControlEventTouchUpInside];
    [bgImageview addSubview:cancleButton];
}



- (void)termsAndCondtionsCheckBoxAction{
    [termsAndConditionsCheckBox setCheckBoxSelected:!termsAndConditionsCheckBox.isSelected];
    [self toggleSignInButtonState];
}

#pragma mark - TextField Container
- (void)resetTextFieldAppeareance{
    CGRect frame = self.view.frame;
    if(frame.origin.y != 0){
        frame.origin.y = 0;
        [UIView animateWithDuration:0.2 animations:^{
            self.view.frame = frame;
        }];
    }
}
- (void)moveUpTextFieldContainerAppearance{
    CGRect frame = self.view.frame;
    if(frame.origin.y != -150){
        frame.origin.y = -150;
        [UIView animateWithDuration:0.2 animations:^{
            self.view.frame = frame;
        }];
    }
}

#pragma mark - TextField delegates
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //NSLog(@"textFieldShouldBeginEditing - %d",textField.tag);
    [self moveUpTextFieldContainerAppearance];
    textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //NSLog(@"textFieldDidBeginEditing");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{


    
    if (textField.tag == 1) {
        [self.passwordTextfield becomeFirstResponder];
    }
    else {
        [self resetTextFieldAppeareance];
        [textField resignFirstResponder];
        
        [self toggleSignInButtonState];
    }
    return YES;
}



#pragma mark -
#pragma mark - Hide Keyboard on BG Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [self resetTextFieldAppeareance];
    [self toggleSignInButtonState];
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - Sign In Button Action
- (IBAction)signInButtonAction:(id)sender {
    userNameString = self.userIDTextfield.text;
    userPasswordString = self.passwordTextfield.text;
    
    userPasswordString = [userPasswordString stringByReplacingOccurrencesOfString:@" " withString:@""];
    userNameString = [userNameString stringByReplacingOccurrencesOfString:@" " withString:@""];

    //![userPasswordString isEqualToString:@""] &&
    if (![userNameString isEqualToString:@""] &&
        ![userPasswordString isEqualToString:@""] &&
        userNameString!=NULL &&
        userPasswordString!=NULL &&
        termsAndConditionsCheckBox.isSelected) {
        
        [[ServerManager sharedManager] loginUser:userNameString password:userPasswordString completion:^(BOOL success, NSMutableArray *resultDataArray) {
            if (success) {
                
                NSString *accessToken = [resultDataArray objectAtIndex:1];
                NSString *pushSettings = [resultDataArray objectAtIndex:2];
                NSString *userid = [resultDataArray objectAtIndex:3];
                [UserManager sharedManager].userAccessToken = accessToken;
                [UserManager sharedManager].userID = userid;
                [SettingsManager sharedManager].pushSettings = pushSettings;
                
                [UserManager sharedManager].userName = userNameString;
                [UserManager sharedManager].userPassword = userPasswordString;
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[[UIAlertView alloc] initWithTitle:@"Incorrect username or password. Hint: use your sidra network login credentials" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                    self.userIDTextfield.text = @"";
                    self.passwordTextfield.text = @"";
                });
                
            }
        }];
    }
    else{
        NSString *popupString = @"";
        
        if (userNameString==nil || [userNameString isEqualToString:@""]) {
            popupString = @"Please give valid user name.";
        }
        else if (userPasswordString==nil || [userPasswordString isEqualToString:@""]) {
            popupString = @"Please give correct password";
        }
        else{
            popupString = @"You must accept the terms of use";
        }
        
        [[[UIAlertView alloc] initWithTitle:popupString message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
    
    
}


#pragma mark - terms condition delegate

- (IBAction)termsAndCondtionsButtonAction:(id)sender {
    [self openPopupAnimation];
}

-(IBAction)cancleAction:(id)sender{
    [self closePopupAnimation];
}

-(void)openPopupAnimation{
    [UIView animateWithDuration:0.6f animations:^{
        [termConditionView setFrame:popupGoToFrame];
    } completion:^(BOOL finished) {
    }];
    
}

-(void)closePopupAnimation{
    [UIView animateWithDuration:0.6f animations:^{
        [termConditionView setFrame:popupGoFromFrame];
    } completion:^(BOOL finished) {
    }];
}

- (void)toggleSignInButtonState{
    if (termsAndConditionsCheckBox.isSelected) {
        
        userNameString = self.userIDTextfield.text;
        userPasswordString = self.passwordTextfield.text;
        
        userPasswordString = [userPasswordString stringByReplacingOccurrencesOfString:@" " withString:@""];
        userNameString = [userNameString stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if (![userNameString isEqualToString:@""] && ![userPasswordString isEqualToString:@""]
            &&userNameString!=NULL && userPasswordString!=NULL){
            self.signInButton.enabled = TRUE;
            self.signInButton.backgroundColor = [UIColor sidraFlatTurquoiseColor];
        }
        else{
            self.signInButton.enabled = FALSE;
            self.signInButton.backgroundColor = [UIColor sidraFlatDarkGrayColor];
        }
        
        
    }else{
        self.signInButton.enabled = FALSE;
        self.signInButton.backgroundColor = [UIColor sidraFlatDarkGrayColor];
    }
}

@end
