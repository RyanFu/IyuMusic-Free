//
//  LogController.m
//  IyuMusic
//
//  Created by iyuba on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LogController.h"
#import "Constants.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


@implementation LogController
@synthesize logTable;
@synthesize userF;
@synthesize userL;
@synthesize codeF;
@synthesize codeL;
@synthesize registBtnTwo;
@synthesize alert;
@synthesize nowUser;
@synthesize logBtnTwo;
@synthesize logOutBtn;
@synthesize remCode;
@synthesize remCodeL;
@synthesize photo;
//@synthesize afterLog;
//@synthesize yubNumBtn;
//@synthesize yubBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    isiPhone = ![Constants isPad];
	if (isiPhone) {
        if (IS_IPHONE_5) {
            self = [super initWithNibName:@"LogController-iPhone5" bundle:nibBundleOrNil];
            
        } else {
            self = [super initWithNibName:@"LogController" bundle:nibBundleOrNil];
            
        }
    }else {
        self = [super initWithNibName:@"LogController-ipad" bundle:nibBundleOrNil];
    }
    if (self) {
        //        NSLog(@"%@",nibNameOrNil);
        
    }
    return self;
}

- (id)init
{
    return [self initWithNibName:@"LogController" bundle:nil];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//- (BOOL)isPad {
//	BOOL isPad = NO;
//#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
//	isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
//#endif
//	return isPad;
//}


#pragma mark - My action
- (IBAction) doRem:(UIButton *)sender{
    NSInteger rem = [[[NSUserDefaults standardUserDefaults] objectForKey:@"remCode"] integerValue];
    if (rem==1) {
        [remCode setImage:[UIImage imageNamed:@"check_box.png"] forState:0];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:0] forKey:@"remCode"];
    }else
    {
        [remCode setImage:[UIImage imageNamed:@"check_box_checked.png"] forState:0];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"remCode"];
    }
}

- (IBAction) doRegist:(UIButton *)sender
{
    if ([self isExistenceNetwork:1]) {
        RegistViewController *myRegist = [[RegistViewController  alloc]init];
        //        [self presentModalViewController:myRegist animated:YES];
        [self.navigationController pushViewController:myRegist animated:YES];
    }
}

//- (IBAction) doCatchYub:(UIButton *)sender {
//    int nowUserID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
//    //    NSLog(@"yub:%d",nowUserID);
////    if ([self isExistenceNetwork:1]&& (nowUserID > 0)) {
////        [self catchYub:[NSString stringWithFormat:@"%d",nowUserID]];
////    }
//}

- (IBAction) doLog:(UIButton *)sender
{
    //    NSString *code =[MyUser findCodeByName:[userF text]];
    //    NSLog(@"userF,text:%@,code:%@,[codeF text]:%@",[userF text],code,[codeF text]);
    //    if ([code isEqualToString:[codeF text]]) {
    ////       NSLog(@"本地已有");
    //        int userId = [MyUser findIdByName:[userF text]];
    //        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:userId] forKey:@"nowUser"];
    //       // [self catchYub:[NSString stringWithFormat:@"%d",userId]];
    //        [userF resignFirstResponder];
    //        [codeF resignFirstResponder];
    //        [nowUser setText:[NSString stringWithFormat:@"%@%@",kLogOne,userF.text]];
    //        [nowUser setHidden:NO];
    ////        [afterLog setHidden:NO];
    //        [logOutBtn setHidden:NO];
    ////        [yubBtn setHidden:NO];
    ////        [yubNumBtn setHidden:NO];
    //        [logBtnTwo setHidden:YES];
    //        [logTable setHidden:YES];
    //        [remCodeL setHidden:YES];
    //        [remCode setHidden:YES];
    //
    //        NSInteger rem = [[[NSUserDefaults standardUserDefaults] objectForKey:@"remCode"] integerValue];
    //        if (rem==1) {
    //            [MyUser acceptRem:userF.text];
    //        }else
    //        {
    //            [MyUser cancelRem:userF.text];
    //        }
    //
    //        alert = [[UIAlertView alloc] initWithTitle:kLogTwo message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    //
    //        [alert setBackgroundColor:[UIColor clearColor]];
    //
    //        [alert setContentMode:UIViewContentModeScaleAspectFit];
    //
    //        [alert show];
    //
    //        UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //
    //        active.center = CGPointMake(alert.bounds.size.width/2, alert.bounds.size.height-40);
    //
    //        [alert addSubview:active];
    //
    //        [active startAnimating];
    //
    //        NSTimer *timer = nil;
    //        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(c) userInfo:nil repeats:NO];
    //    }else
    //    {
    //        NSLog(@"联网登录");
    if ([self isExistenceNetwork:1] && userF.text.length > 0 && codeF.text.length > 0 && userF.textColor == [UIColor blackColor] && codeF.textColor == [UIColor blackColor]) {
        [userF resignFirstResponder];
        [codeF resignFirstResponder];
        [self catchLogs];
    }
    //    }
    
}

- (IBAction) doLogout:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:0] forKey:@"nowUser"];
    [nowUser setHidden:YES];
    //[afterLog setHidden:YES];
    [logOutBtn setHidden:YES];
    //[yubBtn setHidden:YES];
    //[yubNumBtn setHidden:YES];
    [logBtnTwo setHidden:NO];
    [logTable setHidden:NO];
    [remCodeL setHidden:NO];
    [remCode setHidden:NO];
    [userF setText:@""];
    [codeF setText:@""];
    
    [photo setImage:[UIImage imageNamed:@"photo.png"]];
    
}


#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    //    [self catchNetA];
    kNetTest;
    self.navigationController.navigationBarHidden = NO;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:0] forKey:@"remCode"];
    NSInteger userId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    //    NSLog(@"生词本添加用户：%d",userId);
    if (userId>0) {
        [nowUser setHidden:NO];
        //[afterLog setHidden:NO];
        [nowUser setText:[NSString stringWithFormat:@"%@%@",kLogOne,[MyUser findNameById:userId]]];
        [logOutBtn setHidden:NO];
        // [yubNumBtn setHidden:NO];
        //[yubBtn  setHidden:NO];
        [logBtnTwo setHidden:YES];
        [logTable setHidden:YES];
        [remCodeL setHidden:YES];
        [remCode setHidden:YES];
        NSString *photoPath=[NSString stringWithFormat:@"http://apis.iyuba.com/account/image.jsp?uid=%d&size=big",userId];
        NSURL *url = [NSURL URLWithString:photoPath];
        [photo setImageWithURL:url placeholderImage:[UIImage imageNamed:@"photo.png"]];
        
    }
    else
    {
        [nowUser setHidden:YES];
        //        [afterLog setHidden:YES];
        //        [yubNumBtn setHidden:YES];
        //        [yubBtn  setHidden:YES];
        [logBtnTwo setHidden:NO];
        [logTable setHidden:NO];
        [remCodeL setHidden:NO];
        [remCode setHidden:NO];
        [logOutBtn setHidden:YES];
        [photo setImage:[UIImage imageNamed:@"photo.png"]];
    }
    //    int nowUserID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    //    //    NSLog(@"yub:%d",nowUserID);
    //    if (nowUserID > 0) {
    //        [self catchYub:[NSString stringWithFormat:@"%d",nowUserID]];
    //    }
}

- (void)viewDidLoad
{
    [self.navigationItem setTitle:kLogFour];
    isExisitNet = NO;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
}

- (void)backButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.logTable = nil;
    self.userL = nil;
    self.codeL = nil;
    self.userF = nil;
    self.nowUser = nil;
    self.codeF = nil;
    self.remCode = nil;
    self.remCodeL = nil;
    self.registBtnTwo = nil;
    self.remCode = nil;
    self.remCodeL = nil;
    // self.afterLog = nil;
    self.logOutBtn = nil;
    //    self.yubBtn = nil;
    //    self.yubNumBtn = nil;
}

- (void) dealloc
{
    [self.logTable release];
    [self.userL release];
    [self.codeL release];
    [self.nowUser release];
    [self.userF release];
    [self.codeF release];
    [self.remCodeL release];
    [self.remCode release];
    [self.registBtnTwo  release];
    [self.logBtnTwo release];
    [self.logOutBtn release];
    //    [self.afterLog release];
    //    [self.yubNumBtn release];
    //    [self.yubBtn release];
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
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    NSString *identifier = [NSString stringWithFormat:@"LogCell%d",[indexPath row]];
    cell = [logTable dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //        cell = [[UITableViewCell alloc]init];
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
        UIImageView *backgroundView=[[UIImageView alloc]init];
        if (isiPhone) {
            [backgroundView setFrame:CGRectMake(0, 0, 300, 40)];
        } else {
            [backgroundView setFrame:CGRectMake(0, 0, 493, 65)];
        }
        
        //UIImageView *lineView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 39, 300, 1)];
        
        switch ([indexPath row]) {
            case 0:
                if (isiPhone) {
                    [backgroundView setImage:[UIImage imageNamed:@"logPanel.png"]];
                    [cell addSubview:backgroundView];
                    [cell sendSubviewToBack:backgroundView];
                    //[lineView setImage:[UIImage imageNamed:@"lineSep.png"]];
                    //[cell addSubview:lineView];
                    // [cell sendSubviewToBack:lineView];
                    userL = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 60, 30)];
                    [userL setFont:[UIFont fontWithName:@"Arial" size:18]];
                    [userL setBackgroundColor:[UIColor clearColor]];
                    [userL setTextAlignment:UITextAlignmentLeft];
                    [userL setText:kLogFive];
                    [cell addSubview:userL];
                    
                    userF = [[UITextField alloc]initWithFrame:CGRectMake(80, 8, 220, 30)];
                    [userF setFont:[UIFont fontWithName:@"Arial" size:18]];
                    [userF setBackgroundColor:[UIColor clearColor]];
                    [userF setTextAlignment:UITextAlignmentLeft];
                    [userF setPlaceholder:kLogSix];
                    [codeF setTag:0];
                    userF.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    [userF setDelegate:self];
                    [cell addSubview:userF];
                } else {
                    [backgroundView setImage:[UIImage imageNamed:@"logPanel@2x.png"]];
                    [cell addSubview:backgroundView];
                    [cell sendSubviewToBack:backgroundView];
                    //[lineView setImage:[UIImage imageNamed:@"lineSep.png"]];
                    //[cell addSubview:lineView];
                    // [cell sendSubviewToBack:lineView];
                    userL = [[UILabel alloc]initWithFrame:CGRectMake(10, 6, 80, 45)];
                    [userL setFont:[UIFont fontWithName:@"Arial" size:23]];
                    [userL setBackgroundColor:[UIColor clearColor]];
                    [userL setTextAlignment:UITextAlignmentLeft];
                    [userL setText:kLogFive];
                    [cell addSubview:userL];
                    
                    userF = [[UITextField alloc]initWithFrame:CGRectMake(95, 14, 395, 45)];
                    [userF setFont:[UIFont fontWithName:@"Arial" size:23]];
                    [userF setBackgroundColor:[UIColor clearColor]];
                    [userF setTextAlignment:UITextAlignmentLeft];
                    [userF setPlaceholder:kLogSix];
                    [codeF setTag:0];
                    userF.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    [userF setDelegate:self];
                    [cell addSubview:userF];
                }
                
                break;
            case 1:
                if (isiPhone) {
                    [backgroundView setImage:[UIImage imageNamed:@"logPanel.png"]];
                    [cell addSubview:backgroundView];
                    [cell sendSubviewToBack:backgroundView];
                    codeL = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 60, 30)];
                    [codeL setFont:[UIFont fontWithName:@"Arial" size:18]];
                    [codeL setBackgroundColor:[UIColor clearColor]];
                    [codeL setTextAlignment:UITextAlignmentLeft];
                    [codeL setText:kLogSeven];
                    [cell addSubview:codeL];
                    
                    codeF = [[UITextField alloc]initWithFrame:CGRectMake(80, 8, 220, 30)];
                    [codeF setFont:[UIFont fontWithName:@"Arial" size:18]];
                    [codeF setBackgroundColor:[UIColor clearColor]];
                    [codeF setTextAlignment:UITextAlignmentLeft];
                    [codeF setPlaceholder:kLogEight];
                    [codeF setSecureTextEntry:YES];
                    [codeF setTag:1];
                    codeF.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    [codeF setDelegate:self];
                    [cell addSubview:codeF];
                    
                } else {
                    [backgroundView setImage:[UIImage imageNamed:@"logPanel@2x.png"]];
                    [cell addSubview:backgroundView];
                    [cell sendSubviewToBack:backgroundView];
                    codeL = [[UILabel alloc]initWithFrame:CGRectMake(10, 6, 80, 45)];
                    [codeL setFont:[UIFont fontWithName:@"Arial" size:23]];
                    [codeL setBackgroundColor:[UIColor clearColor]];
                    [codeL setTextAlignment:UITextAlignmentLeft];
                    [codeL setText:kLogSeven];
                    [cell addSubview:codeL];
                    
                    codeF = [[UITextField alloc]initWithFrame:CGRectMake(95, 14, 395, 45)];
                    [codeF setFont:[UIFont fontWithName:@"Arial" size:23]];
                    [codeF setBackgroundColor:[UIColor clearColor]];
                    [codeF setTextAlignment:UITextAlignmentLeft];
                    [codeF setPlaceholder:kLogEight];
                    [codeF setSecureTextEntry:YES];
                    [codeF setTag:1];
                    codeF.autocapitalizationType = UITextAutocapitalizationTypeNone;
                    [codeF setDelegate:self];
                    [cell addSubview:codeF];
                    
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
    return (isiPhone?45.0f:75.0f);
}

#pragma mark - Http connect
//-(BOOL) isExistenceNetwork:(NSInteger)choose
//{
//	BOOL isExistenceNetwork;
//	Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
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
//                break;
//            case 1:
//                myalert = [[UIAlertView alloc] initWithTitle:kInfoTwo message:kFeedbackFour delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil,nil];
//                [myalert show];
//                [myalert release];
//                break;
//            default:
//                break;
//        }
//	}
//	return isExistenceNetwork;
//}
-(BOOL) isExistenceNetwork:(NSInteger)choose
{
    UIAlertView *myalert = nil;
    kNetTest;
    switch (choose) {
        case 0:
            
            break;
        case 1:
            if (kNetIsExist) {
                
            }else {
                myalert = [[UIAlertView alloc] initWithTitle:kInfoTwo message:kFeedbackFour delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil,nil];
                [myalert show];
                [myalert release];
            }
            break;
        default:
            break;
    }
	return kNetIsExist;
}

//- (void)catchNetA
//{
//    NSString *url = @"http://www.baidu.com";
//    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    request.delegate = self;
//    [request setUsername:@"catchnet"];
//    [request startAsynchronous];
//    request = nil;
//    [request release];
//}

//- (void)catchYub:(NSString  *)userID
//{
//    NSString *url = [NSString stringWithFormat:@"http://app.iyuba.com/pay/checkApi.jsp?userId=%@",userID];
//    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    request.delegate = self;
//    [request setUsername:@"yub"];
//    [request startAsynchronous];
//    request = nil;
//    [request release];
//}

- (void)catchLogs
{
    NSString *url = [NSString stringWithFormat:@"http://apis.iyuba.com/v2/api.iyuba?protocol=10001"];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setPostValue:[userF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"username"];
    NSString *password = [ROUtility md5HexDigest:codeF.text];
    [request setPostValue:password   forKey:@"password"];
    //   [request setPostValue:@"0"   forKey:@"md5status"];
    [request setPostValue:@"xml" forKey:@"format"];
    NSString *sign = [ROUtility md5HexDigest:[NSString stringWithFormat:@"10001%@%@iyubaV2",userF.text,password]];
    ////    NSLog(@"10001%@%@iyubaV2",userF.text,password);
    ////    NSLog(@"sign:%@",sign);
    [request setPostValue:sign forKey:@"sign"];
    
    // get 方法
    //    NSString *urlStr = [NSString stringWithFormat:@"http://apis.iyuba.com/v2/api.iyuba?protocol=10001&username=%@&password=%@&format=xml&sign=%@",userF.text,password,sign];
    //    urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    NSLog(@"urlstr:%@",urlStr);
    //    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    request.delegate = self;
    [request setRequestMethod:@"POST"];
    [request setUsername:@"log"];
    [request startSynchronous];
    //    request = nil;
    //    [request release];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    kNetTest;
    if ([request.username isEqualToString:@"log" ]) {
        alert = [[UIAlertView alloc] initWithTitle:kVoaWordOne message:kLogNine delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    kNetEnable;
    if ([request.username isEqualToString:@"catchnet"]) {
        //        NSLog(@"有网络");
        isExisitNet = YES;
        return;
    }
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
    if ([request.username isEqualToString:@"log" ]) {
        NSArray *items = [doc nodesForXPath:@"response" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                NSString *status = [[obj elementForName:@"result"] stringValue];
                //                s(@"status:%@",status);
                if ([status isEqualToString:@"101"]) {
                    MyUser *user = [[MyUser alloc]init];
                    user._userName = [userF text];
                    user._code = [codeF text];
                    NSString *msg = [[obj elementForName:@"imgSrc"] stringValue] ;
                    NSURL *url = [NSURL URLWithString:msg];
                    [photo setImageWithURL:url placeholderImage:[UIImage imageNamed:@"photo.png"]];
                    //                    NSLog(@"msg:%@",msg);
                    NSInteger userId = [[[obj elementForName:@"uid"] stringValue] integerValue] ;
                    //                    NSLog(@"userId:%d",userId);
                    user._userId = userId;
                    
                    [user insert];
                    [user release],user = nil;
                    [nowUser setText:[NSString stringWithFormat:@"%@%@",kLogOne,[MyUser findNameById:userId]]];
                    [nowUser setHidden:NO];
                    //  [afterLog setHidden:NO];
                    [logOutBtn setHidden:NO];
                    //                    [yubBtn setHidden:NO];
                    //                    [yubNumBtn setHidden:NO];
                    
                    [logBtnTwo setHidden:YES];
                    [logTable setHidden:YES];
                    [remCodeL setHidden:YES];
                    [remCode setHidden:YES];
                    
                    
                    
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:userId] forKey:@"nowUser"];
                    NSInteger rem = [[[NSUserDefaults standardUserDefaults] objectForKey:@"remCode"] integerValue];
                    if (rem==1) {
                        [MyUser acceptRem:userF.text];
                    }else
                    {
                        [MyUser cancelRem:userF.text];
                    }
                    
                    alert = [[UIAlertView alloc] initWithTitle:kLogTwo message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    
                    [alert setBackgroundColor:[UIColor clearColor]];
                    
                    [alert setContentMode:UIViewContentModeScaleAspectFit];
                    
                    [alert show];
                    
                    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                    
                    active.center = CGPointMake(alert.bounds.size.width/2, alert.bounds.size.height-40);
                    
                    [alert addSubview:active];
                    
                    [active startAnimating];
                    
                    NSTimer *timer = nil;
                    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(c) userInfo:nil repeats:NO];
                    
                }else
                {
                    //                    NSString *msg = [[obj elementForName:@"msg"] stringValue] ;
                    NSString *msg = [[obj elementForName:@"message"] stringValue] ;
                    if ([status isEqualToString:@"102"]) {
                        msg = @"用户名不存在";
                    }else if ([status isEqualToString:@"103"]) {
                        msg = @"密码错误";
                    }else {
                        msg = @"无网络连接或服务器暂不可用";
                    }
                    //                    NSLog(@"msg:%@",msg);
                    alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@%@",kLogTen,msg] message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    
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
    } else {
        //        if ([request.username isEqualToString:@"yub" ]) {
        //            NSArray *items = [doc nodesForXPath:@"response" error:nil];
        //            if (items) {
        //                for (DDXMLElement *obj in items) {
        //                //    NSString *amount = [[obj elementForName:@"amount"] stringValue];
        //                //    [yubNumBtn setTitle:amount forState:UIControlStateNormal];
        //                }
        //            }
        // }
    }
    [doc release],doc = nil;
    //    [myData release], myData = nil;
    //    request.delegate = nil;
}

-(void)c
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    [alert release];
}

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
    if (textField.tag == 1) {
        
        NSString *code = [MyUser findCodeByName:userF.text];
        [textField setSecureTextEntry:YES];
        //        NSLog(@"自动密码kai:%@",code);
        if (code) {
            [codeF setText:code];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            if (textField.text.length <4) {
                [textField setText:kLogEleven];
                [textField setTextColor:[UIColor redColor]];
            }else{
                [textField setTextColor:[UIColor blackColor]];
                NSString *code = [MyUser findCodeByName:textField.text];
                //                NSLog(@"自动密码wan:%@",code);
                if (code) {
                    [codeF setText:code];
                }
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
        default:
            break;
    }
}

@end
