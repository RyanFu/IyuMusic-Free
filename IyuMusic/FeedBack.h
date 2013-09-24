//
//  FeedBack.h
//  IyuMusic
//
//  Created by iyuba on 12-8-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import "Reachability.h"//isExistenceNetwork
#import "Constants.h"

@interface FeedBack : UIViewController<ASIHTTPRequestDelegate,UITextFieldDelegate,UITextViewDelegate>{
    UITextView *feedback;
    UITextField *mail;
    UIAlertView *alert;
    UIImageView *bg;
    BOOL isiPhone;
}
@property(nonatomic,retain) IBOutlet UITextView *feedback;
@property(nonatomic,retain) IBOutlet UITextField *mail;
@property(nonatomic,retain) IBOutlet UIImageView *bg;
- (void)sendFeedback;

@end
