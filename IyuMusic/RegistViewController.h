//
//  RegistViewController.h
//  IyuMusic
//
//  Created by iyuba on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Reachability.h"//isExistenceNetwork
#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import "MyUser.h"
#import "RegexKitLite.h"
#import "Constants.h"
#import "ASIFormDataRequest.h"
#import "ROUtility.h"
#import "NSString+URLEncoding.h"


@interface RegistViewController : UIViewController<UITextFieldDelegate>
{
    UITableView *logTable;
    UILabel *userL;
    UILabel *codeL;
    UILabel *codeAgainL;
    UILabel *mailL;
    UITextField *userF;
    UITextField *codeF;
    UITextField *codeAgainF;
    UITextField *mailF;
    UIButton *registBtn;
    UIAlertView *alert;
    BOOL isiPhone;
//    UIImageView *backgroundView;
    
}

@property (nonatomic, retain) IBOutlet UITableView *logTable;
@property (nonatomic, retain) UILabel *userL;
@property (nonatomic, retain) UILabel *codeL;
@property (nonatomic, retain) UILabel *codeAgainL;
@property (nonatomic, retain) UILabel *mailL;
@property (nonatomic, retain) UITextField *userF;
@property (nonatomic, retain) UITextField *codeF;
@property (nonatomic, retain) UITextField *codeAgainF;
@property (nonatomic, retain) UITextField *mailF;
@property (nonatomic, retain) UIButton *registBtn;
@property (nonatomic, retain) UIAlertView *alert;
//@property (nonatomic, retain) UIImageView *backgroundView;

- (IBAction) goBack:(UIButton *)sender;
- (IBAction) doRegist:(UIButton *) sender;
- (void)catchRegists;


@end
