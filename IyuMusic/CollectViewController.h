//
//  CollectViewController.h
//  IyuMusic
//
//  Created by iyuba on 12-8-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayViewController.h"
#import "MusicView.h"
#import "MusicFav.h"
#import <PlausibleDatabase/PlausibleDatabase.h>
#import "MusicViewCell.h"
#import "SearchViewController.h"
#import "Constants.h"

@interface CollectViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *musicsTableView;
    UIButton *all;
    UIButton *man;
    UIButton *woman;
    UIButton *band;
    UIButton *old;
//    UIImageView *bg;
    NSMutableArray *musicsArray;
    NSMutableArray *favArray;
    UISearchBar *search;
    //NSInteger nowSection;
    //NSInteger lastId;
    //NSInteger nowId;
    //NSInteger addNum;
    //NSInteger addNumTwo;
    //NSInteger pageNum;
    NSInteger _myicid;
    BOOL isExistNet;
    BOOL isiPhone;
    
    MBProgressHUD *HUD;
}
@property (nonatomic,retain)NSMutableArray *musicsArray;
@property (nonatomic,retain)NSMutableArray *favArray;
@property (nonatomic,retain)UISearchBar *search;
//@property NSInteger nowSection;
//@property NSInteger lastId;
//@property NSInteger nowId;
//@property NSInteger addNum;
//@property NSInteger addNumTwo;
//@property NSInteger pageNum;
@property (nonatomic,retain) IBOutlet UIImageView *changeImage;
@property (nonatomic,retain)IBOutlet UIImageView *contentImg;
@property (nonatomic,retain)IBOutlet UIView *chView;
@property (nonatomic,retain)IBOutlet UITableView *musicsTableView;
@property(nonatomic,retain)IBOutlet UIButton *all;
@property(nonatomic,retain)IBOutlet UIButton *man;
@property(nonatomic,retain)IBOutlet UIButton *woman;
@property(nonatomic,retain)IBOutlet UIButton *band;
@property(nonatomic,retain)IBOutlet UIButton *old;
//@property(nonatomic,retain)IBOutlet UIImageView *bg;
@property NSInteger _myicid;
-(IBAction) buttonPressed :(id) sender;
@property (nonatomic,retain) MBProgressHUD *HUD;
//- (void)catchIntroduction:(NSInteger)maxid pages:(NSInteger)pages pageNum:(NSInteger)pageNumOne;
//- (void)catchDetails:(MusicView *)iid;
//- (BOOL) isExistenceNetwork:(NSInteger)choose;
//- (void)reloadTableViewDataSource; 
//- (void)doneLoadingTableViewData; 
//- (void)catchNetA;

@end