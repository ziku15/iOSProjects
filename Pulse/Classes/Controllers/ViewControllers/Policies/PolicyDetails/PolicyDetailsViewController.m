//
//  PolicyDetailsViewController.m
//  Pulse
//
//  Created by Atomix on 7/8/14.
//  Copyright (c) 2014 Atomix. All rights reserved.
//

#import "PolicyDetailsViewController.h"
#import "EventsTabbarView.h"
#import <QuartzCore/QuartzCore.h>
#import "PolicyDetailsTabbarView.h"

@interface PolicyDetailsViewController ()<UIScrollViewDelegate,PolicyDetailsTabViewDelegate> {
    
    UIScrollView *tabBarBgScrollView;
    NSMutableArray *buttonName;
    UITextView *showDtailsText;
    PolicyDetailsTabbarView *tabbarView;
}

@end

@implementation PolicyDetailsViewController

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
    
    NSString *_policyNumber = [NSString stringWithFormat:@"Policy Number : %@", self.itemArray.PolicyNO];
    [self setNavigationCustomTitleView:@"Policy Details" with:_policyNumber];
    
    [self addTopSegmentControl];
    //[self topTabBarDesign]; // top Tab bar design
    
    [self detailsTextView]; // Show text content
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Parent View Controller delegate (Navigation Title)

//set title and subtitle text to the navigation bar
-(void)setNavigationCustomTitleView:(NSString *)titleText with:(NSString *)subtitleText{
    //First Remove previous view
    for (UIView *view in self.navigationItem.titleView.subviews) {
        [view removeFromSuperview];
    }
    
    
    //Create view and add to the title view
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.text = titleText;
    [titleLabel sizeToFit];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 0, 0)];
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.textColor = [UIColor whiteColor];
    subTitleLabel.font = [UIFont systemFontOfSize:10];
    subTitleLabel.text = subtitleText;
    [subTitleLabel sizeToFit];
    
    UIView *twoLineTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAX(subTitleLabel.frame.size.width, titleLabel.frame.size.width), 30)];
    [twoLineTitleView addSubview:titleLabel];
    [twoLineTitleView addSubview:subTitleLabel];
    
    float widthDiff = subTitleLabel.frame.size.width - titleLabel.frame.size.width;
    
    if (widthDiff > 0) {
        CGRect frame = titleLabel.frame;
        frame.origin.x = widthDiff / 2;
        titleLabel.frame = CGRectIntegral(frame);
    }else{
        CGRect frame = subTitleLabel.frame;
        frame.origin.x = abs(widthDiff) / 2;
        subTitleLabel.frame = CGRectIntegral(frame);
    }
    
    self.navigationItem.titleView = twoLineTitleView;
}




// Text Width Calculation

-(CGSize)frameForText:(NSString*)text sizeWithFont:(UIFont*)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode  {
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = lineBreakMode;
    
    NSDictionary * attributes = @{NSFontAttributeName:font,
                                  NSParagraphStyleAttributeName:paragraphStyle
                                  };
    
    
    CGRect textRect = [text boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes
                                         context:nil];
    
    //Contains both width & height ... Needed: The height
    return textRect.size;
}

/*
-(void) topTabBarDesign {
    
    buttonName = [[NSMutableArray alloc] initWithObjects:@"Overview",@"Policy Statement", @"Definition",@"Reference", nil];
    
    tabBarBgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    tabBarBgScrollView.backgroundColor = [UIColor whiteColor];
    tabBarBgScrollView.showsHorizontalScrollIndicator = NO;
    tabBarBgScrollView.showsVerticalScrollIndicator = NO;
    tabBarBgScrollView.bounces = YES;
    [self.view addSubview:tabBarBgScrollView];
    
    
    float butnPositionX = 3.0f;
    
    for (int i= 0; i<buttonName.count; i++) {
        
        // calculate Dynamic Button Width
        NSString *btnText = [buttonName objectAtIndex:i];
        UIFont *TextFont = [UIFont fontWithName:@"Helvetica" size:14.0];
        CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
        CGSize labelSize = [self frameForText:btnText sizeWithFont:TextFont constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
        
        ///NSLog(@"wwwwwwwwwwwww: %f", labelSize.width);
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setTitle:[buttonName objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13.0];
        if (i==0) {
            [button setTitleColor:[UIColor colorWithRed:(38.0/255.0) green:(157.0/255.0) blue:(193.0/255.0) alpha:1.0] forState:UIControlStateNormal];
        }
        else{
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        //button.backgroundColor = [UIColor redColor];
        button.frame = CGRectMake(butnPositionX, 11, labelSize.width + 10, 50);
        [button addTarget:self
                   action:@selector(tabBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [button sizeToFit];
        [tabBarBgScrollView addSubview:button];
        butnPositionX = butnPositionX + labelSize.width + 10;
        
        //separator
        UIView *staightLine = [[UIView alloc] init];
        staightLine.frame = CGRectMake(butnPositionX - 6.5 , 1, 0.5, tabBarBgScrollView.frame.size.height);
        staightLine.backgroundColor = [UIColor sidraFlatGrayColor];
        
        if (buttonName.count -1 !=i) {
            [tabBarBgScrollView addSubview:staightLine];
        }
    
    }
    
    tabBarBgScrollView.contentSize = CGSizeMake(butnPositionX - 10, tabBarBgScrollView.frame.size.height);
    
    // Bottom border
    UIView *_bottomBorder = [[UIView alloc] init];
    _bottomBorder.frame = CGRectMake(0,tabBarBgScrollView.frame.size.height-0.5, tabBarBgScrollView.contentSize.width, 0.5);
    _bottomBorder.backgroundColor = [UIColor sidraFlatGrayColor];
    [tabBarBgScrollView addSubview:_bottomBorder];
    
}
*/

//*******************************************

#pragma mark - SegmentControl

- (void)addTopSegmentControl{
    //Create tab panel
    tabbarView = [[PolicyDetailsTabbarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50) with:self];
    [self.view addSubview:tabbarView];
    
}


//*******************************************


- (void)tabbedButtonAction:(int)button_tag{
    
   // NSLog(@"btn pressed: %ld", (long)sender.tag);
    
    // --------------------- UI Section -----------------
    /*
    NSArray *_buttonViewArray = tabBarBgScrollView.subviews;
    
    for (int i=0; i<_buttonViewArray.count; i++) {
        
        if([[_buttonViewArray objectAtIndex:i] isKindOfClass:[UIButton class]]){
            
            UIButton *btnColorChange = (UIButton*)[_buttonViewArray objectAtIndex:i];
            [btnColorChange setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
        
    }
    
    [sender setTitleColor:[UIColor colorWithRed:(38.0/255.0) green:(157.0/255.0) blue:(193.0/255.0) alpha:1.0] forState:UIControlStateNormal];
    
    // ----------------------- END ----------------------
    */
     NSString *_overview = [NSString stringWithFormat:@"\n\n\n%@",self.itemArray.overview];
     NSString *_policyStatement = [NSString stringWithFormat:@"\n\n\n%@",self.itemArray.policyStatement];
     NSString *_definition = [NSString stringWithFormat:@"\n\n\n%@",self.itemArray.definitions];
     NSString *_reference = [NSString stringWithFormat:@"\n\n\n%@",self.itemArray.reference];
    
    // Action
    
    switch (button_tag) {
        case 0:
            XLog(@"OverView");
            showDtailsText.text = _overview;
            [showDtailsText setContentOffset: CGPointMake(0,0) animated:NO];
            break;
            
        case 1:
            XLog(@"Policy Statement");
            showDtailsText.text = _policyStatement;
            [showDtailsText setContentOffset: CGPointMake(0,0) animated:NO];
            break;
            
        case 2:
            XLog(@"Definition");
            showDtailsText.text = _definition;
            [showDtailsText setContentOffset: CGPointMake(0,0) animated:NO];
            break;
            
        case 3:
            XLog(@"Reference");
            showDtailsText.text = _reference;
            [showDtailsText setContentOffset: CGPointMake(0,0) animated:NO];
            break;
            
        default:
            break;
    }
    
}


// UI section
-(void) detailsTextView {
    
    NSString *overview = [NSString stringWithFormat:@"\n\n\n%@",self.itemArray.overview];
    

    showDtailsText = [[UITextView alloc] initWithFrame:CGRectMake(7, 57, 306,[[UIScreen mainScreen] bounds].size.height - 128)];
    showDtailsText.backgroundColor = [UIColor whiteColor];
    [showDtailsText setEditable:NO];
    showDtailsText.text = overview;
    [showDtailsText setFont:[UIFont systemFontOfSize:13.0f]];
    showDtailsText.textColor = [UIColor lightGrayColor];
    
    //To make the border look very close to a UITextField
    [showDtailsText.layer setBorderColor:kViewBorderColor];
    [showDtailsText.layer setBorderWidth:kViewBorderWidth];
    
    //The rounded corner part, where you specify your view's corner radius:
    showDtailsText.layer.cornerRadius = kSubViewCornerRadius;
    showDtailsText.clipsToBounds = YES;
    
    [self.view addSubview:showDtailsText];
    
    UILabel *titleText = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 300, 50)];
    titleText.text = self.itemArray.title;
    titleText.numberOfLines = 2;
    [titleText setFont:[UIFont systemFontOfSize:15.0f]];
    titleText.textColor = [UIColor blackColor];
    
    [showDtailsText addSubview:titleText];
    

}
@end
