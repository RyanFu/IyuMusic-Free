//
//  InformationViewController.m
//  IyuMusic
//
//  Created by iyuba on 12-8-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InformationViewController.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@implementation InformationViewController
@synthesize more;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    isiPhone = ![Constants isPad];
	if (isiPhone) {
        self = [super initWithNibName:@"InformationViewController" bundle:nibBundleOrNil];
        	}else {
        self = [super initWithNibName:@"InformationViewController-ipad" bundle:nibBundleOrNil];
    }
    if (self) {
        //        NSLog(@"%@",nibNameOrNil);
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)goUrl:(id)sender
{
    if ([self isExistenceNetwork:1]) {
        InforViewController *myInfor = [[InforViewController alloc]init];
        [self.navigationController pushViewController:myInfor animated:YES];
    }
}
- (void)backButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//
//- (BOOL)isPad {
//	BOOL isPad = NO;
//#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
//	isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
//#endif
//	return isPad;
//}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    kNetTest;
    if (IS_IPHONE_5) {
        [more setFrame:CGRectMake(95, 370, 131, 40)];
    }
    self.title = kInfoOne;
    UIButton * imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imgBtn setImage:[UIImage imageWithContentsOfFile:
								[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"return"] ofType:@"png"]] 
					  forState:UIControlStateNormal];
    [imgBtn addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    imgBtn.frame = CGRectMake(0, 0, 50, 37);
    UIBarButtonItem * backbutton = [[UIBarButtonItem alloc] initWithCustomView:imgBtn];
    self.navigationItem.leftBarButtonItem = backbutton;
	self.navigationItem.hidesBackButton = YES;
	[backbutton release];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL) isExistenceNetwork:(NSInteger)choose
{
	BOOL isExistenceNetwork;
	Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
			isExistenceNetwork=FALSE;
            break;
        case ReachableViaWWAN:
			isExistenceNetwork=TRUE;
            break;
        case ReachableViaWiFi:
			isExistenceNetwork=TRUE;     
            break;
    }
	if (!isExistenceNetwork) {
        UIAlertView *myalert = nil;
        switch (choose) {
            case 0:
                
                break;
            case 1:
                myalert = [[UIAlertView alloc] initWithTitle:kInfoTwo message:kInfoThree delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil,nil];
                [myalert show];
                [myalert release];
                break;
            default:
                break;
        }
	}
	return isExistenceNetwork;
}

@end