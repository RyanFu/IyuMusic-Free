//
//  RegistViewController.m
//  IyuMusic
//
//  Created by iyuba on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RegistViewController.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


@implementation RegistViewController
@synthesize logTable;
@synthesize userF;
@synthesize userL;
@synthesize codeF;
@synthesize codeL;
@synthesize codeAgainF;
@synthesize codeAgainL;
@synthesize mailF;
@synthesize mailL;
@synthesize registBtn;
@synthesize alert;
//@synthesize backgroundView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    isiPhone = ![Constants isPad];
	if (isiPhone) {
        if (IS_IPHONE_5) {
            self = [super initWithNibName:@"RegistViewController-iPhone5" bundle:nibBundleOrNil];
            
        } else {
            self = [super initWithNibName:@"RegistViewController" bundle:nibBundleOrNil];
            
            
        }
    }else {
        self = [super initWithNibName:@"RegistViewController-ipad" bundle:nibBundleOrNil];
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
//
//- (BOOL)isPad {
//	BOOL isPad = NO;
//#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
//	isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
//#endif
//	return isPad;
//}

#pragma mark - My action
- (IBAction) goBack:(UIButton *)sender
{
    //    [self dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) doRegist:(UIButton *) sender
{
    if (userF.textColor == [UIColor blackColor] && codeF.textColor == [UIColor blackColor] && codeAgainF.textColor == [UIColor blackColor] && mailF.textColor == [UIColor blackColor]&&userF.text!=NULL&&codeF.text !=NULL &&codeAgainF.text !=NULL &&mailF.text !=NULL) {
        [self catchRegists];
    }else
    {
        UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:kVoaWordOne message:kRegThirteen delegate:self cancelButtonTitle:kFeedbackFive otherButtonTitles: nil];
        [alert2 show];
        [alert2 release];
        
    }
}


#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated
{
    kNetTest;
    //    self.navigationController.navigationBarHidden=NO;
    [self.navigationController setNavigationBarHidden:NO];
    
    [registBtn setUserInteractionEnabled:NO];
}

- (void)viewDidLoad
{
    isiPhone = ![Constants isPad];
    //    backgroundView = Nil;
    //    if (isiPhone) {
    ////    backgroundView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 160)];
    ////    [backgroundView setImage:[UIImage imageNamed:@"feedback_top.png"]];
    //    }else {
    ////        [self.view setFrame:CGRectMake(0, 0, 768, 1024)];
    //        [self.logTable setFrame:CGRectMake(234, 50, 300, 230)];
    ////    backgroundView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 160)];
    ////    [backgroundView setImage:[UIImage imageNamed:@"feedback@2x.png"]];
    //    }
    
    //    [logTable addSubview:backgroundView];
    //    [logTable sendSubviewToBack:backgroundView];
    
    
    [self.navigationItem setTitle:kRegTwilve];
    UIButton * imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imgBtn setImage:[UIImage imageWithContentsOfFile:
                      [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"return"] ofType:@"png"]]
            forState:UIControlStateNormal];
    [imgBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    imgBtn.frame = CGRectMake(0, 0, 50, 37);
    UIBarButtonItem * backbutton = [[UIBarButtonItem alloc] initWithCustomView:imgBtn];
    self.navigationItem.leftBarButtonItem = backbutton;
	self.navigationItem.hidesBackButton = YES;
	[backbutton release];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.logTable = nil;
}

- (void)dealloc
{
    //    [self.logTable release];
    [self.userL release];
    [self.codeL release];
    [self.codeAgainL release];
    [self.mailL release];
    [self.userF release];
    [self.codeF release];
    [self.codeAgainF release];
    [self.mailF release];
    [self.registBtn release];
    [self.alert release];
    //    [self.backgroundView release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView //明确cell数目
 numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    NSString *identifier = [NSString stringWithFormat:@"RegistCell%d",[indexPath row]];
    cell = [logTable dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
        UIImageView *backgroundView=[[UIImageView alloc]init];
        if (isiPhone) {
            [backgroundView setFrame:CGRectMake(0, 0, 300, 40)];
        } else {
            [backgroundView setFrame:CGRectMake(0, 0, 493, 70)];
        }
        
        //        UIImageView *lineView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 39, 300, 1)];
        switch ([indexPath row]) {
            case 0:
                if (isiPhone) {
                    [backgroundView setImage:[UIImage imageNamed:@"logPanel.png"]];
                    [cell addSubview:backgroundView];
                    [cell sendSubviewToBack:backgroundView];
                    //                [lineView setImage:[UIImage imageNamed:@"sp_login.png"]];
                    //                [cell addSubview:lineView];
                    //                [cell sendSubviewToBack:lineView];
                    userL = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 80, 30)];
                    [userL setFont:[UIFont fontWithName:@"Arial" size:18]];
                    [userL setBackgroundColor:[UIColor clearColor]];
                    [userL setTextAlignment:UITextAlignmentLeft];
                    [userL setText:kLogFive];
                    [cell addSubview:userL];
                    
                    userF = [[UITextField alloc]initWithFrame:CGRectMake(90, 10, 210, 30)];
                    [userF setFont:[UIFont fontWithName:@"Arial" size:15]];
                    [userF setBackgroundColor:[UIColor clearColor]];
                    [userF setTextAlignment:UITextAlignmentLeft];
                    [userF setPlaceholder:kRegOne];
                    [userF setDelegate:self];
                    [userF setTag:0];
                    userF.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    [cell addSubview:userF];
                    
                } else {
                    [backgroundView setImage:[UIImage imageNamed:@"logPanel@2x.png"]];
                    [cell addSubview:backgroundView];
                    [cell sendSubviewToBack:backgroundView];
                    //                [lineView setImage:[UIImage imageNamed:@"sp_login.png"]];
                    //                [cell addSubview:lineView];
                    //                [cell sendSubviewToBack:lineView];
                    userL = [[UILabel alloc]initWithFrame:CGRectMake(10, 6, 90, 45)];
                    [userL setFont:[UIFont fontWithName:@"Arial" size:23]];
                    [userL setBackgroundColor:[UIColor clearColor]];
                    [userL setTextAlignment:UITextAlignmentLeft];
                    [userL setText:kLogFive];
                    [cell addSubview:userL];
                    
                    userF = [[UITextField alloc]initWithFrame:CGRectMake(115, 14,375, 45)];
                    [userF setFont:[UIFont fontWithName:@"Arial" size:23]];
                    [userF setBackgroundColor:[UIColor clearColor]];
                    [userF setTextAlignment:UITextAlignmentLeft];
                    [userF setPlaceholder:kRegOne];
                    [userF setDelegate:self];
                    [userF setTag:0];
                    userF.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    [cell addSubview:userF];
                    
                }
                break;
                
            case 1:
                if (isiPhone) {
                    [backgroundView setImage:[UIImage imageNamed:@"logPanel.png"]];
                    [cell addSubview:backgroundView];
                    [cell sendSubviewToBack:backgroundView];
                    //                [lineView setImage:[UIImage imageNamed:@"sp_login.png"]];
                    //                [cell addSubview:lineView];
                    //                [cell sendSubviewToBack:lineView];
                    codeL = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 80, 30)];
                    [codeL setFont:[UIFont fontWithName:@"Arial" size:18]];
                    [codeL setBackgroundColor:[UIColor clearColor]];
                    [codeL setTextAlignment:UITextAlignmentLeft];
                    [codeL setText:kLogSeven];
                    [cell addSubview:codeL];
                    
                    codeF = [[UITextField alloc]initWithFrame:CGRectMake(90, 10, 210, 30)];
                    [codeF setFont:[UIFont fontWithName:@"Arial" size:15]];
                    [codeF setBackgroundColor:[UIColor clearColor]];
                    [codeF setTextAlignment:UITextAlignmentLeft];
                    [codeF setPlaceholder:kLogEight];
                    [codeF setSecureTextEntry:YES];
                    [codeF setDelegate:self];
                    [codeF setTag:1];
                    codeF.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    [cell addSubview:codeF];
                    
                } else {
                    [backgroundView setImage:[UIImage imageNamed:@"logPanel@2x.png"]];
                    [cell addSubview:backgroundView];
                    [cell sendSubviewToBack:backgroundView];
                    //                [lineView setImage:[UIImage imageNamed:@"sp_login.png"]];
                    //                [cell addSubview:lineView];
                    //                [cell sendSubviewToBack:lineView];
                    codeL = [[UILabel alloc]initWithFrame:CGRectMake(10, 6, 90, 45)];
                    [codeL setFont:[UIFont fontWithName:@"Arial" size:23]];
                    [codeL setBackgroundColor:[UIColor clearColor]];
                    [codeL setTextAlignment:UITextAlignmentLeft];
                    [codeL setText:kLogSeven];
                    [cell addSubview:codeL];
                    
                    codeF = [[UITextField alloc]initWithFrame:CGRectMake(115, 14, 375, 45)];
                    [codeF setFont:[UIFont fontWithName:@"Arial" size:23]];
                    [codeF setBackgroundColor:[UIColor clearColor]];
                    [codeF setTextAlignment:UITextAlignmentLeft];
                    [codeF setPlaceholder:kLogEight];
                    [codeF setSecureTextEntry:YES];
                    [codeF setDelegate:self];
                    [codeF setTag:1];
                    codeF.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    [cell addSubview:codeF];
                    
                }
                break;
                
            case 2:
                if (isiPhone) {
                    [backgroundView setImage:[UIImage imageNamed:@"logPanel.png"]];
                    [cell addSubview:backgroundView];
                    [cell sendSubviewToBack:backgroundView];
                    //                [lineView setImage:[UIImage imageNamed:@"sp_login.png"]];
                    //                [cell addSubview:lineView];
                    //                [cell sendSubviewToBack:lineView];
                    codeAgainL=[[UILabel alloc]initWithFrame: CGRectMake(10, 5, 80, 30)];
                    [codeAgainL setFont:[UIFont fontWithName:@"Arial" size:18]];
                    [codeAgainL setBackgroundColor:[UIColor clearColor]];
                    [codeAgainL setTextAlignment:UITextAlignmentLeft];
                    [codeAgainL setText:kRegTwo];
                    [cell addSubview:codeAgainL];
                    codeAgainF = [[UITextField alloc]initWithFrame:CGRectMake(90, 10, 210, 30)];
                    [codeAgainF setFont:[UIFont fontWithName:@"Arial" size:15]];
                    [codeAgainF setBackgroundColor:[UIColor clearColor]];
                    [codeAgainF setTextAlignment:UITextAlignmentLeft];
                    [codeAgainF setPlaceholder:kRegThree];
                    [codeAgainF setSecureTextEntry:YES];
                    [codeAgainF setDelegate:self];
                    [codeAgainF setTag:2];
                    codeAgainF.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    [cell addSubview:codeAgainF];
                } else {
                    [backgroundView setImage:[UIImage imageNamed:@"logPanel@2x.png"]];
                    [cell addSubview:backgroundView];
                    [cell sendSubviewToBack:backgroundView];
                    //                [lineView setImage:[UIImage imageNamed:@"sp_login.png"]];
                    //                [cell addSubview:lineView];
                    //                [cell sendSubviewToBack:lineView];
                    codeAgainL=[[UILabel alloc]initWithFrame: CGRectMake(10, 6, 100, 45)];
                    [codeAgainL setFont:[UIFont fontWithName:@"Arial" size:23]];
                    [codeAgainL setBackgroundColor:[UIColor clearColor]];
                    [codeAgainL setTextAlignment:UITextAlignmentLeft];
                    [codeAgainL setText:kRegTwo];
                    [cell addSubview:codeAgainL];
                    codeAgainF = [[UITextField alloc]initWithFrame:CGRectMake(115, 14, 375, 45)];
                    [codeAgainF setFont:[UIFont fontWithName:@"Arial" size:23]];
                    [codeAgainF setBackgroundColor:[UIColor clearColor]];
                    [codeAgainF setTextAlignment:UITextAlignmentLeft];
                    [codeAgainF setPlaceholder:kRegThree];
                    [codeAgainF setSecureTextEntry:YES];
                    [codeAgainF setDelegate:self];
                    [codeAgainF setTag:2];
                    codeAgainF.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    [cell addSubview:codeAgainF];
                }
                
                break;
                
            case 3:
                if (isiPhone) {
                    [backgroundView setImage:[UIImage imageNamed:@"logPanel.png"]];
                    [cell addSubview:backgroundView];
                    [cell sendSubviewToBack:backgroundView];
                    //                [lineView setImage:[UIImage imageNamed:@"lineSep.png"]];
                    //                [cell addSubview:lineView];
                    //                [cell sendSubviewToBack:lineView];
                    mailL=[[UILabel alloc]initWithFrame: CGRectMake(10, 5, 80, 30)];
                    [mailL setFont:[UIFont fontWithName:@"Arial" size:18]];
                    [mailL setBackgroundColor:[UIColor clearColor]];
                    [mailL setTextAlignment:UITextAlignmentLeft];
                    [mailL setText:@"Email:"];
                    [cell addSubview:mailL];
                    
                    mailF = [[UITextField alloc]initWithFrame:CGRectMake(90, 10, 210, 30)];
                    [mailF setFont:[UIFont fontWithName:@"Arial" size:15]];
                    [mailF setBackgroundColor:[UIColor clearColor]];
                    [mailF setTextAlignment:UITextAlignmentLeft];
                    [mailF setPlaceholder:kRegFour];
                    [mailF setDelegate:self];
                    [mailF setTag:3];
                    mailF.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    [cell addSubview:mailF];
                } else {
                    [backgroundView setImage:[UIImage imageNamed:@"logPanel@2x.png"]];
                    [cell addSubview:backgroundView];
                    [cell sendSubviewToBack:backgroundView];
                    //                [lineView setImage:[UIImage imageNamed:@"lineSep.png"]];
                    //                [cell addSubview:lineView];
                    //                [cell sendSubviewToBack:lineView];
                    mailL=[[UILabel alloc]initWithFrame: CGRectMake(10, 6, 90, 45)];
                    [mailL setFont:[UIFont fontWithName:@"Arial" size:23]];
                    [mailL setBackgroundColor:[UIColor clearColor]];
                    [mailL setTextAlignment:UITextAlignmentLeft];
                    [mailL setText:@"Email:"];
                    [cell addSubview:mailL];
                    
                    mailF = [[UITextField alloc]initWithFrame:CGRectMake(115, 14, 375, 45)];
                    [mailF setFont:[UIFont fontWithName:@"Arial" size:23]];
                    [mailF setBackgroundColor:[UIColor clearColor]];
                    [mailF setTextAlignment:UITextAlignmentLeft];
                    [mailF setPlaceholder:kRegFour];
                    [mailF setDelegate:self];
                    [mailF setTag:3];
                    mailF.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    [cell addSubview:mailF];
                }
                
                break;
                
            default:
                break;
        }
    }else
    {
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (isiPhone?50.0f:75.0f);
}

#pragma mark - Http connect
- (void)catchRegists
{
    //    NSLog(@"mail：%s",[self.mailF.text UTF8String]);
    NSString *url = [NSString stringWithFormat:@"http://apis.iyuba.com/v2/api.iyuba?protocol=10002"];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setPostValue:[userF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"username"];
    //    NSLog(@"username:%@",[userF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    NSString *password = [ROUtility md5HexDigest:codeF.text];
    [request setPostValue:password   forKey:@"password"];
    [request setPostValue:[mailF.text  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"email"];
    
    //   [request setPostValue:@"0"   forKey:@"md5status"];
    [request setPostValue:@"xml" forKey:@"format"];
    [request setPostValue:@"ios" forKey:@"platform"];
    [request setPostValue:@"afterclass" forKey:@"app"];
    NSString *sign = [ROUtility md5HexDigest:[NSString stringWithFormat:@"10002%@%@%@iyubaV2",userF.text,password,mailF.text]];
    ////    NSLog(@"10001%@%@iyubaV2",userF.text,password);
    ////    NSLog(@"sign:%@",sign);
    [request setPostValue:sign forKey:@"sign"];
    request.delegate = self;
    [request setUsername:@"regist"];
    [request startSynchronous];
    
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
    kNetTest;
    alert = [[UIAlertView alloc] initWithTitle:kRegFive message:kRegSix delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    kNetEnable;
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
    if ([request.username isEqualToString:@"regist" ]) {
        NSArray *items = [doc nodesForXPath:@"response" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                NSString *status = [[obj elementForName:@"result"] stringValue];
                //                NSLog(@"status:%@",status);
                if ([status isEqualToString:@"111"]) {
                    MyUser *user = [[MyUser alloc]init];
                    user._userName = [userF text];
                    user._code = [codeF text];
                    user._mail = [mailF text];
                    //                    NSString *msg = [[obj elementForName:@"msg"] stringValue] ;
                    //                    NSLog(@"msg:%@",msg);
                    NSInteger userId = [[[obj elementForName:@"uid"] stringValue] integerValue] ;
                    //                    NSLog(@"userId:%d",userId);
                    user._userId = userId;
                    [user insert];
                    [user release],user = nil;
                    alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@%@",kRegSeven,[userF text]] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    
                    [alert setBackgroundColor:[UIColor clearColor]];
                    
                    [alert setContentMode:UIViewContentModeScaleAspectFit];
                    
                    [alert show];
                    
                    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                    
                    active.center = CGPointMake(alert.bounds.size.width/2, alert.bounds.size.height-40);
                    
                    [alert addSubview:active];
                    
                    [active startAnimating];
                    
                    NSTimer *timer = nil;
                    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(c) userInfo:nil repeats:NO];
                    NSInteger nowId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
                    //    NSLog(@"生词本添加用户：%d",userId);
                    if (nowId<=0) {
                        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:userId] forKey:@"nowUser"];
                    }
                    [self dismissModalViewControllerAnimated:YES];
                }else
                {
//                    NSString *msg = [[obj elementForName:@"message"] stringValue] ;
//                    //                    NSLog(@"msg:%@",msg);
//                    if ([status isEqualToString:@"112"]) {
//                        msg = @"用户名已存在";
//                    }else if ([status isEqualToString:@"113"]) {
//                        msg = @"邮箱已注册";
//                    }else if ([status isEqualToString:@"114"]) {
//                        msg = @"用户名长度错误";
//                    }else{
//                        msg = @"无网络连接或服务器暂不可用";
//                    }
                    NSString *msg = [[obj elementForName:@"msg"] stringValue] ;
                    //                    NSLog(@"msg:%@",msg);
                    switch ([status intValue]) {
                        case 112:
                            msg = @"用户名已存在";
                            break;
                        case 113:
                            msg = @"邮箱已注册";
                            break;
                        case 114:
                            msg = @"用户名长度错误";
                            break;
                        case 104:
                            msg = @"邮箱格式错误";
                            break;
                        case  105:
                            msg = @"密码格式不符(密码过长或过短，禁止全部数字)";
                            break;
                        case  106:
                            msg = @"邮箱不正确(非用户邮箱)";
                            break;
                        default:
                            msg = @"无网络连接或服务器暂不可用";
                            break;
                    }

                    
                    //                    NSLog(@"msg:%@",msg);
                    alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@%@",kRegEight,msg] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    
                    [alert setBackgroundColor:[UIColor clearColor]];
                    
                    [alert setContentMode:UIViewContentModeScaleAspectFit];
                    
                    [alert show];
                    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                    
                    active.center = CGPointMake(alert.bounds.size.width/2, alert.bounds.size.height-40);
                    
                    [alert addSubview:active];
                    
                    [active startAnimating];
                    
                    NSTimer *timer = nil;
                    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(c) userInfo:nil repeats:NO];
                }
            }
        }
    }
    [doc release],doc = nil;
    //    myData = nil;
    //    request.delegate = nil;
}

-(void)c
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    [alert release];
}

//-(BOOL) isExistenceNetwork:(NSInteger)choose
//{
//	BOOL isExistenceNetwork;
//	Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
//    switch ([r currentReachabilityStatus]) {
//        case NotReachable:
//			isExistenceNetwork=FALSE;
//            break;
//        case ReachableViaWWAN:
//			isExistenceNetwork=TRUE;
//            break;
//        case ReachableViaWiFi:
//			isExistenceNetwork=TRUE;
//            break;
//    }
//	if (!isExistenceNetwork) {
//        UIAlertView *myalert = nil;
//        switch (choose) {
//            case 0:
//
//                break;
//            case 1:
//                myalert = [[UIAlertView alloc] initWithTitle:kInfoTwo message:kRegNine delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil,nil];
//                [myalert show];
//                [myalert release];
//                break;
//            default:
//                break;
//        }
//	}
//	return isExistenceNetwork;
//}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [textField setTextColor:[UIColor blackColor]];
    [textField setText:@""];
    if (textField.tag == 1 || textField.tag == 2) {
        [textField setSecureTextEntry:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            if (textField.text.length <3) {
                [textField setText:kLogEleven];
                [textField setTextColor:[UIColor redColor]];
            }else{
            }
            break;
        case 1:
            if (textField.text.length == 0) {
                [textField setSecureTextEntry:NO];
                [textField setText:kLogEight];
                [textField setTextColor:[UIColor redColor]];
            }else{
                [textField setSecureTextEntry:YES];
            }
            break;
        case 2:
            if ([textField.text isEqualToString:codeF.text]) {
                [textField setSecureTextEntry:YES];
            }else{
                [textField setSecureTextEntry:NO];
                [textField setText:kRegTen];
                [textField setTextColor:[UIColor redColor]];
            }
            break;
        case 3:
            //            if ([textField.text isMatchedByRegex:@"^(\\w+((-\\w+)|(\\.\\w+))*)\\+\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z0-9]+$"]){
            if ([textField.text isMatchedByRegex:@"^([a-zA-Z0-9_\\.\\-])+\\@(([a-zA-Z0-9\\-])+\\.)+([a-zA-Z0-9]{2,4})+$"]){
            }else{
                [textField setText:kRegEleven];
                [textField setTextColor:[UIColor redColor]];
            }
        default:
            break;
    }
}

@end
