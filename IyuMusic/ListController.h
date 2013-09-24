//
//  AllController.h
//  IyuMusic
//
//  Created by iyuba on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayViewController.h"
#import "MusicView.h"
#import <PlausibleDatabase/PlausibleDatabase.h>
#import "MusicViewCell.h"
//#import "UIImageView+WebCache.h"
#import "SearchViewController.h"
//#import "DDXML.h"
//#import "DDXMLElementAdditions.h"
#import "ASIHTTPRequest.h"
#import "MBProgressHUD.h"
//#import "Reachability.h"//isExistenceNetwork
//#import "EGORefreshTableHeaderView.h" 
#import "Constants.h"
#import "DACircularProgressView.h"

@interface ListController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,MBProgressHUDDelegate,UIActionSheetDelegate>
{
    UITableView *musicsTableView;
    UIButton *all;
    UIButton *man;
    UIButton *woman;
    UIButton *band;
    UIButton *old;
    NSMutableArray *musicsArray;
    UISearchBar *search;
    MBProgressHUD *HUD;
//    UIImageView *bg;
    //NSInteger nowSection;
    //NSInteger lastId;
    //NSInteger nowId;
    //NSInteger addNum;
    //NSInteger addNumTwo;
    NSInteger pageNum;
    NSInteger _myicid;
    BOOL isExistNet;
    BOOL isiPhone;
    
    
}
@property (nonatomic,retain)NSMutableArray *musicsArray;
@property (nonatomic,retain)UISearchBar *search;
//@property NSInteger nowSection;
//@property NSInteger lastId;
//@property NSInteger nowId;
//@property NSInteger addNum;
//@property NSInteger addNumTwo;
//@property NSInteger pageNum;
@property (nonatomic,retain)IBOutlet UIImageView *contentImg;
@property (nonatomic,retain)IBOutlet UIView *chView;
@property (nonatomic,retain)IBOutlet UITableView *musicsTableView;
@property (nonatomic,retain)IBOutlet UIImageView *changeImage;
@property(nonatomic,retain)IBOutlet UIButton *all;
@property(nonatomic,retain)IBOutlet UIButton *man;
@property(nonatomic,retain)IBOutlet UIButton *woman;
@property(nonatomic,retain)IBOutlet UIButton *band;
@property(nonatomic,retain)IBOutlet UIButton *old;
//@property(nonatomic,retain)IBOutlet UIImageView *bg;
@property(nonatomic,retain)MBProgressHUD *HUD;


//- (void)catchIntroduction:(NSInteger)maxid pages:(NSInteger)pages pageNum:(NSInteger)pageNumOne;
//- (void)catchDetails:(MusicView *)iid;
//- (BOOL) isExistenceNetwork:(NSInteger)choose;
//- (void)reloadTableViewDataSource; 
//- (void)doneLoadingTableViewData; 
//- (void)catchNetA;
-(IBAction) buttonPressed :(id) sender;

@end

//@protocol PlayerRequestDelegate <NSObject>
//
//@required
//- (void)afterDownload;
//@end
