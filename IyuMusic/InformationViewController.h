//
//  InformationViewController.h
//  IyuMusic
//
//  Created by iyuba on 12-8-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InforViewController.h"
#import "Reachability.h"//isExistenceNetwork
#import "Constants.h"

@interface InformationViewController : UIViewController{
    BOOL isiPhone;
    UIButton *more;
}
- (IBAction)goUrl:(id)sender;
- (BOOL) isExistenceNetwork:(NSInteger)choose;
@property (nonatomic,retain) IBOutlet UIButton *more;
@end
