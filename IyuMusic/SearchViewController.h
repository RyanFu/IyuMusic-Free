//
//  SearchViewController.h
//  IyuMusic
//
//  Created by iyuba on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicView.h"
#import "MusicViewCell.h"
//#import "UIImageView+WebCache.h"
#import "PlayViewController.h"
#import "Constants.h"

@interface SearchViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate,UIAlertViewDelegate> 
{
    NSMutableArray *_contentsArray;
    NSMutableArray *_contentsSrArray;
    UITableView *musicsTableView;
    NSString *_searchWords;
    NSInteger addNum;
    NSInteger searchFlg;
    MBProgressHUD *HUD;
    BOOL isiPhone;
}

@property (nonatomic, retain) NSMutableArray *_contentsArray;
@property (nonatomic, retain) NSMutableArray *_contentsSrArray;
@property (nonatomic, retain) IBOutlet UITableView *musicsTableView;
@property (nonatomic, retain) IBOutlet UIImageView *contentBg;
@property (nonatomic, retain) NSString *_searchWords;
@property (nonatomic, retain) MBProgressHUD *HUD;
@property NSInteger searchFlg;
@property NSInteger addNum;

//- (void)catchDetails:(MusicView *) iid;
//- (void)catchResult:(NSString *) searchWord page:(NSInteger)page;


@end
