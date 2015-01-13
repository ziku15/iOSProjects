//
//  PressDetailsViewController.m
//  Pulse
//
//  Created by Atomix on 7/10/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "PressDetailsViewController.h"

@interface PressDetailsViewController () {
    
    UITextView *showReleaseDetails;
    UILabel *titleText;
    UILabel *date;
    NSString *overview;
}

@end

@implementation PressDetailsViewController

@synthesize isHRArtical;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.item = [[HRL2Item alloc] init];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self common];
    if (isHRArtical) {
        [self setNavigationCustomTitleView:@"Human Resources" with:self.item.question];
        [self hrArticalDesign];
    }else{
        //self.title = @"Press Details";
        [self setNavigationCustomTitleView:@"Press Details" with:@""];
        [self releaseDetails];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) hrArticalDesign{
    
    
    overview = [NSString stringWithFormat:@"\n\n\n\n\n\n%@",self.item.answer];
    
    showReleaseDetails.text = overview;
    
    
    // Title
    titleText.text = self.item.question;
    
    // Date
    date.text =  [[SettingsManager sharedManager] showPostedByFromDate:self.item.createdDate];//self.itemDetailsArray.releaseDate;
    

    
}

-(void) common{
    
    
    showReleaseDetails = [[UITextView alloc] initWithFrame:CGRectMake(7, 7, 306,[[UIScreen mainScreen] bounds].size.height - 78)];
    showReleaseDetails.backgroundColor = [UIColor whiteColor];
    [showReleaseDetails setEditable:NO];
    [showReleaseDetails setFont:[UIFont systemFontOfSize:13.5]];
    showReleaseDetails.textColor = [UIColor lightGrayColor];
    
    //To make the border look very close to a UITextField
    [showReleaseDetails.layer setBorderColor:kViewBorderColor];
    [showReleaseDetails.layer setBorderWidth:kViewBorderWidth];
    
    //The rounded corner part, where you specify your view's corner radius:
    showReleaseDetails.layer.cornerRadius = kSubViewCornerRadius;
    showReleaseDetails.clipsToBounds = YES;
    
    [self.view addSubview:showReleaseDetails];
    
    // Title
    titleText = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 300, 40)];
    titleText.numberOfLines = 2;
    [titleText setFont:[UIFont systemFontOfSize:16]];
    titleText.textColor = [UIColor blackColor];
    [showReleaseDetails addSubview:titleText];
    
    // Date
    date =  [[UILabel alloc] initWithFrame:CGRectMake(5, 45, 320, 20)];
    //self.itemDetailsArray.releaseDate;
    [date setFont:[UIFont systemFontOfSize:12]];
    date.textColor = [UIColor redColor];
    [showReleaseDetails addSubview:date];
}


// UI Design section
-(void) releaseDetails {
    
    overview = [NSString stringWithFormat:@"\n\n\n\n%@",self.itemDetailsArray.content];
    
    
   
    showReleaseDetails.text = overview;
  

    
    // Title
    titleText.text = self.itemDetailsArray.title;
   
    // Date
    date.text =  [[SettingsManager sharedManager] showPostedByFromDate:self.itemDetailsArray.releaseDate];//self.itemDetailsArray.releaseDate;
    
}

@end
