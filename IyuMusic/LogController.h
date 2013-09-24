//
//  LogController.h
//  IyuMusic
//
//  Created by iyuba on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistViewController.h"
#import "ASIHTTPRequest.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"//contain method isExistenceNetwork
#import "ROUtility.h"
#import "NSString+URLEncoding.h"
#import "ASIFormDataRequest.h"

@interface LogController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *logTable;
    UILabel *userL;
    UILabel *codeL;
    UILabel *nowUser;
    UITextField *userF;
    UITextField *codeF;
    UIButton *remCodeL;
    UIButton *remCode;
    UIButton *registBtnTwo;
    UIButton *logBtnTwo;
    UIButton *logOutBtn;
    UIImageView *photo;
    UIAlertView *alert;
   // UIImageView *afterLog;
    BOOL isiPhone;
    BOOL isExisitNet;
}

@property (nonatomic, retain) IBOutlet UITableView *logTable;
@property (nonatomic, retain) UILabel *userL;
@property (nonatomic, retain) UILabel *codeL;
@property (nonatomic, retain) UITextField *userF;
@property (nonatomic, retain) UITextField *codeF;
@property (nonatomic, retain) IBOutlet UIButton *registBtnTwo;
@property (nonatomic, retain) IBOutlet UIButton *logBtnTwo;
@property (nonatomic, retain) IBOutlet UIButton *logOutBtn;
@property (nonatomic, retain) UIAlertView *alert;
@property (nonatomic, retain) IBOutlet UILabel *nowUser;
@property (nonatomic, retain) IBOutlet UIButton *remCode;
@property (nonatomic, retain) IBOutlet UIButton *remCodeL;
@property (nonatomic, retain) IBOutlet UIImageView *photo;


//@property (nonatomic, retain) IBOutlet UIButton *yubBtn;
//@property (nonatomic, retain) IBOutlet UIButton *yubNumBtn;
//@property (nonatomic, retain) IBOutlet UIImageView *afterLog;

- (IBAction) doRegist:(UIButton *)sender;
//- (IBAction) doCatchYub:(UIButton *)sender;
- (IBAction) doLog:(UIButton *)sender;
-(BOOL) isExistenceNetwork:(NSInteger)choose;
- (void)catchLogs;
//- (void)catchNetA;
//- (void)catchYub:(NSString  *)userID;
- (IBAction) doLogout:(UIButton *)sender;
- (IBAction) doRem:(UIButton *)sender;

@end
