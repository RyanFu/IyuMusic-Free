//
//  InforViewController.h
//  IyuMusic
//
//  Created by iyuba on 12-8-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface InforViewController : UIViewController
{    
    UIWebView *             _webView;
    BOOL isiPhone;
}

@property (nonatomic, retain) IBOutlet UIWebView *          webView;
@end
