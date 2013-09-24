//
//  WordViewController.h
//  VOA
//
//  Created by song zhao on 12-2-6.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MusicWord.h"
#import "MyLabel.h"
#import "ASIHTTPRequest.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import "RegexKitLite.h"
//#import "MBProgressHUD.h"
#import "WordViewCell.h"
#import "LogController.h"
#import "Constants.h"

@interface WordViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,MyLabelDelegate,ASIHTTPRequestDelegate,UIAlertViewDelegate>{
    UITableView *wordsTableView;
    NSMutableArray *wordsArray;
    UISearchBar *search;
    MusicWord *myWord;
    MyLabel *explainView;
    AVPlayer	*wordPlayerTwo;
    NSInteger isCellPlay;
    MyLabel *defSLabel;
    NSInteger nowUserId;
    NSInteger flg;
    UIImageView     *wordFrame;
    UIAlertView *alert;
    BOOL isiPhone;
}

@property (nonatomic, retain) AVPlayer	*wordPlayerTwo;
@property (nonatomic, retain) NSMutableArray *wordsArray;
@property (nonatomic, retain) IBOutlet UITableView *wordsTableView;
@property (nonatomic, retain) IBOutlet UIImageView *contentBg;
@property (nonatomic, retain) MusicWord *myWord;
@property NSInteger isCellPlay;
@property NSInteger nowUserId;
@property (nonatomic, retain) MyLabel *defSLabel;
@property (nonatomic, retain) UISearchBar *search;
@property (nonatomic, retain) MyLabel *explainView;
//@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) UIImageView     *wordFrame;

- (void)catchWords:(NSString *) word;
+ (NSOperationQueue *)sharedQueue;
- (void)catchAsWordDetails:(NSInteger) wordId;
- (void)catchAsFlg:(NSInteger) wordId mode:(NSString *) mode;
- (void)catchAllByPageNumber:(NSInteger) number;

@end
