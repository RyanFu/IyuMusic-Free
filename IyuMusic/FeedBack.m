//
//  FeedBack.m
//  IyuMusic
//
//  Created by iyuba on 12-8-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "FeedBack.h"

@implementation FeedBack
@synthesize feedback;
@synthesize mail;
@synthesize bg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    isiPhone =![Constants isPad];
    if(isiPhone){
        self = [super initWithNibName:@"FeedBack" bundle:nibBundleOrNil];
    }else{
        self = [super initWithNibName:@"FeedBack-ipad" bundle:nibBundleOrNil];
    }

    if (self) {
        // Custom initialization
        self.title = kFeedbackOne;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
- (void)backButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    kNetTest;
NSInteger nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
if (nowUserId > 0) {
    [mail setHidden:YES];
}
else
{
    [mail setHidden:NO];
}
}

- (void)viewDidLoad
{
[super viewDidLoad];
//isiPhone = ![Constants isPad];
//if (!isiPhone) {
//    [self.view setFrame:CGRectMake(0, 0, 768, 1024)];
//    self.bg.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"bg-ipad"]ofType:@"png"]];
//    [self.bg setFrame:CGRectMake(0, 0, 768, 1024)];
//    [self.feedback setFrame:CGRectMake(104, 20, 560, 250)];
//    [self.mail setFrame:CGRectMake(104, 300, 560, 160)];
//}
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
//    
    UIButton * imgBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [imgBtn2 setBackgroundImage:[UIImage imageWithContentsOfFile:
								[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"titleBtn"] ofType:@"png"]] 
					  forState:UIControlStateNormal];
	[imgBtn2 setTitle:kFeedbacksix forState:UIControlStateNormal];
	imgBtn2.titleLabel.font=[UIFont systemFontOfSize:13];
    [imgBtn2 addTarget:self action:@selector(sendFeedback) forControlEvents:UIControlEventTouchUpInside];
    imgBtn2.frame = CGRectMake(0, 0, 50, 37);
    UIBarButtonItem * sendButton = [[UIBarButtonItem alloc] initWithCustomView:imgBtn2];
//     UIBarButtonItem * sendButton = [[UIBarButtonItem alloc] initWithTitle:kFeedbacksix style:UIBarButtonItemStyleBordered target:self action:@selector(sendFeedback)];
    self.navigationItem.rightBarButtonItem = sendButton;
    [sendButton release];
    [feedback becomeFirstResponder];
    
    
}

- (void)viewDidUnload
{
[super viewDidUnload];
// Release any retained subviews of the main view.
// e.g. self.myOutlet = nil;
self.feedback = nil;
self.mail = nil;
}

- (void)dealloc
{
[self.feedback release];
[self.mail release];
[super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
// Return YES for supported orientations
return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - http connect

- (void)sendFeedback{
if ([self isExistenceNetwork]) {
    ASIFormDataRequest * request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://api.iyuba.com/mobile/ios/afterclass/feedback.xml"]];
    request.delegate = self;
    NSInteger nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    NSString * decodedText = [[NSString alloc] initWithUTF8String:[feedback.text UTF8String]];
    if (nowUserId > 0) {
        [request setPostValue:[NSString stringWithFormat:@"%d",nowUserId] forKey:@"uid"];
    }
    else
    {
        [request setPostValue:[NSString stringWithFormat:@"%@",mail.text] forKey:@"email"];
    }
    [request setPostValue:decodedText forKey:@"content"];
    [request startAsynchronous];
    [decodedText release];
}
}

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders{
if ([request responseStatusCode] >= 400) {
    UIAlertView *alertOne = [[UIAlertView alloc] initWithTitle:kSearchEleven message:[NSString stringWithFormat:@"%@,%@",kSearchEleven,kSearchTwelve] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertOne show];
    [alertOne release];
}
//    NSLog(@"httpCode:%d",[request responseStatusCode]);
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
NSData *myData = [request responseData];
DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
/////解析
NSArray *items = [doc nodesForXPath:@"response" error:nil];
if (items) {
    for (DDXMLElement *obj in items) {
        NSString *status = [[obj elementForName:@"status"] stringValue];
        //            NSLog(@"status:%@",status);
        if ([status isEqualToString:@"OK"]) {
            //                NSLog(@"反馈成功");
            alert = [[UIAlertView alloc] initWithTitle:kFeedbackTwo message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
            
            [alert setBackgroundColor:[UIColor clearColor]];
            
            [alert setContentMode:UIViewContentModeScaleAspectFit];
            
            [alert show];
            
            //            UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            //            
            //            active.center = CGPointMake(alert.bounds.size.width/2, alert.bounds.size.height-40);
            //            
            //            [alert addSubview:active];
            //            
            //            [active startAnimating];
            
            NSTimer *timer = nil;
            timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(c) userInfo:nil repeats:NO];
        }else
        {
            //                NSLog(@"反馈失败");
            NSString *msg = [[obj elementForName:@"msg"] stringValue] ;
            //                NSLog(@"msg:%@",msg);
            UIAlertView * alertOne = [[UIAlertView alloc] initWithTitle:kFeedbackThree message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertOne show];
            [alertOne release];
        }
    }
}    
[doc release],doc = nil;
// myData = nil;
//request.delegate = nil;
}


-(BOOL) isExistenceNetwork
{
BOOL isExistenceNetworkr;
Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
switch ([r currentReachabilityStatus]) {
    case NotReachable:
        isExistenceNetworkr=FALSE;
        break;
    case ReachableViaWWAN:
        isExistenceNetworkr=TRUE;
        break;
    case ReachableViaWiFi:
        isExistenceNetworkr=TRUE;     
        break;
}
if (!isExistenceNetworkr) {
    UIAlertView *myalert = nil;
    myalert = [[UIAlertView alloc] initWithTitle:kFeedbackThree message:kFeedbackFour delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil,nil];
    [myalert show];
    [myalert release];    
}
return isExistenceNetworkr;
}

-(void)c
{
[alert dismissWithClickedButtonIndex:0 animated:YES];
[alert release];
}


#pragma mark - UiTextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
[textField resignFirstResponder];
return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
[textView setText:@""];
return YES;
}

@end
