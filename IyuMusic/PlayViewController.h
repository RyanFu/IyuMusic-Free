//
//  PlayViewController.h
//  IyuMusic
//
//  Created by iyuba on 12-7-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicView.h"
#import "MusicFav.h"
#import "timeSwitchClass.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MP3PlayerClass.h"
#import "DatabaseClass.h"
#import "LyricSynClass.h"
#import "MusicContent.h"
#import "TextScrollView.h"
#import "MyLabel.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import "MBProgressHUD.h"
#import "MyPageControl.h"
#import "Constants.h"
#import "SevenProgressBar.h"
#import "ASIFormDataRequest.h"
#import "Reachability.h"
#import "MusicWord.h"
#import "LogController.h"
#import "GADBannerView.h"
#import "LocalWord.h"

@class timeSwitchClass;
#define kHourComponent 0
#define kMinComponent 1
#define kSecComponent 2



@interface PlayViewController : UIViewController<UIAlertViewDelegate,AVAudioPlayerDelegate,ASIHTTPRequestDelegate,MyLabelDelegate,MBProgressHUDDelegate,UIScrollViewDelegate,AVAudioSessionDelegate,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource, GADBannerViewDelegate>{
    
    MusicView *music;
    
    UIImageView    *myImageFrame;
    UIImageView    *myImageView;
    UIImageView    *lyricImage;
    UIImageView    *wordFrame;
    UIImage  *playImage;
    UIImage  *pauseImage;
    UIImage  *loadingImage;
    UIImage  *xunhuanImage;
    UIImage  *shunxuImage;
    UIImage  *danquImage;
    UIImage  *suijiImage;
    
    UIButton  *collectButton;
    UIButton  *switchBtn;
    UIButton  *playButton;
    UIButton  *preButton;
    UIButton  *nextButton;
    UIButton  *playModeButton;
//    UIButton  *backButton;
    UIButton  *listButton;
    UIButton        *fixButton;
    UIButton        *clockButton;
    UIButton		*downloadFlg;
    UIButton        *downloadingFlg;

    
    UILabel   *totalTimeLabel;
    UILabel   *currentTimeLabel;
    UILabel   *myHighLightWord;
    UILabel   *playModeLabel;
    MyLabel   *explainView;
    TextScrollView  *textScroll;
    TextScrollView  *myScroll;
    
    timeSwitchClass  *timeSwitch;
    
    UISlider   *timeSlider;
    SevenProgressBar  *loadProgress;
    
    NSTimer   *sliderTimer;
    NSTimer   *updateTimer;
    NSTimer   *lyricSynTimer;
    NSTimer   *loadTimer;
    
    NSMutableArray  *lyricArray;
    NSMutableArray  *timeArray;
    NSMutableArray  *indexArray;
    NSMutableArray  *lyricLabelArray;
    NSMutableData   *mp3Data;
    NSMutableArray *musicsArray;    
    
    
    int        Lines;
    int        playerFlag;
    int        myTimer;
    NSInteger nowUserId;
    NSInteger nowPlayRow;
    
    AVPlayer   *player;
    AVPlayer   *wordPlayer;
    
    NSURL   *mp3Url;
    
    BOOL localFileExist;
    BOOL downloaded;
    BOOL newFile;
    BOOL switchFlg;
    BOOL needFlush;
    BOOL needFlushAdv;
    BOOL isExistNet;
    BOOL noBuffering;
    BOOL isiPhone;
    BOOL isFixing;
    BOOL isFree;
    NSString   *userPath;
    
    MusicWord  *myWord;
    
    
    MBProgressHUD *HUD;
    
    UIPickerView *myPick;
    
    UIView *viewOne;
    UIView *viewTwo;
    UIView *fixTimeView;
    UIView *containerView;
    
    UITextView *imgWords;
    UILabel *titleWords;
    
    double myStop;
    double seekTo;
    
    UIAlertView *alert;
    
    NSNotificationCenter *myCenter;
    
    UITableView *songList;
      int             fixSeconds;
    MyPageControl *pageControl;
    
    GADBannerView  *bannerView_;
    
}
@property (nonatomic,retain) IBOutlet UIButton *listButton;
@property (nonatomic,retain) IBOutlet UIButton *collectButton;
@property (nonatomic,retain) IBOutlet UIButton *preButton;
@property (nonatomic,retain) IBOutlet UIButton *nextButton;
@property (nonatomic,retain) IBOutlet UIButton *playModeButton;
//@property (nonatomic,retain) UIButton *backButton;
@property (nonatomic,retain) TextScrollView *textScroll;
@property (nonatomic,retain) IBOutlet MyPageControl *pageControl;
@property (nonatomic,retain) IBOutlet UILabel *totalTimeLabel;
@property (nonatomic,retain) IBOutlet UILabel *currentTimeLabel;
@property (nonatomic,retain) IBOutlet UISlider *timeSlider;
@property (nonatomic,retain) IBOutlet UIButton *playButton;
@property (nonatomic,retain) IBOutlet UILabel *playModeLabel;
@property (nonatomic,retain) IBOutlet UILabel *titleWords;
@property (nonatomic,retain) MusicView *music;
@property (nonatomic,retain) UIImageView *myImageView;
@property (nonatomic,retain) UIImageView *lyricImage;
@property (nonatomic,retain) UIImageView *wordFrame;
@property (nonatomic,retain) UIButton  *switchBtn;
@property (nonatomic,retain) timeSwitchClass *timeSwitch;
@property (nonatomic,retain) NSTimer *sliderTimer;
@property (nonatomic,retain) NSTimer *lyricSynTimer;
@property (nonatomic,retain) NSTimer *updateTimer;
@property (nonatomic, retain) NSTimer         *fixTimer;
@property (nonatomic,retain) NSMutableArray *lyricArray;
@property (nonatomic,retain) NSMutableArray *timeArray;
@property (nonatomic,retain) NSMutableArray *indexArray;
@property (nonatomic,retain) NSMutableArray *lyricLabelArray;
@property (nonatomic,retain) NSMutableArray *musicsArray;
@property int    Lines;
@property int    playerFlag;//0:local  1:net

//@property (nonatomic, retain) id <PlayerRequestDelegate> myDelegate;

@property (nonatomic,retain) AVPlayer *player;
@property (nonatomic,retain) AVPlayer *wordPlayer;
@property (nonatomic,retain) UILabel  *myHighLightWord;
@property (nonatomic,retain) UIView *myView;
@property (nonatomic,retain) NSMutableData *mp3Data;
@property (nonatomic,retain) NSString  *userPath;
@property BOOL localFileExist;
@property BOOL downloaded;
@property BOOL newFile;
@property BOOL switchFlg;
@property (nonatomic,retain) MyLabel *explainView;
@property (nonatomic,retain) MusicWord *myWord;
@property (nonatomic,retain) MBProgressHUD *HUD;
@property (nonatomic,retain) UIView *viewOne;
@property (nonatomic,retain) UIView *viewTwo;
@property (nonatomic, retain) IBOutlet UIView *playerView;
@property (nonatomic, retain) IBOutlet UIView *fixTimeView;
@property (nonatomic, retain) IBOutlet UIPickerView *myPick;
@property (nonatomic, retain) IBOutlet UIButton  *fixButton;
@property (nonatomic,retain) IBOutlet TextScrollView *myScroll;
@property (nonatomic,retain) UITextView *imgWords;
@property int myTimer;
@property double myStop;
@property (nonatomic,retain) UIImage *playImage;
@property (nonatomic,retain) UIImage *pauseImage;
@property (nonatomic,retain) UIImage *loadingImage;
@property (nonatomic,retain) UIImage *xunhuanImage;
@property (nonatomic,retain) UIImage *shunxuImage;
@property (nonatomic,retain) UIImage *danquImage;
@property (nonatomic,retain) UIImage *suijiImage;
@property (nonatomic,retain) UIAlertView *alert;
@property (nonatomic,retain) NSNotificationCenter *myCenter;
@property NSInteger nowUserId;
@property NSInteger nowPlayRow;
//@property BOOL isExistNet;
@property (nonatomic) BOOL isFree;
@property (nonatomic, retain) UIButton        *clockButton;
@property (nonatomic, retain) UIButton      *downloadFlg;
@property (nonatomic, retain) UIButton      *downloadingFlg;
@property (nonatomic, retain) NSArray         *hoursArray;
@property (nonatomic, retain) NSArray         *minsArray;
@property (nonatomic, retain) NSArray         *secsArray;

@property (nonatomic,retain) UIImageView *myImageFrame;
@property (nonatomic,retain) UITableView *songList;
@property (nonatomic) BOOL isFixing;
@property (nonatomic) int             fixSeconds;

@property (nonatomic, retain) UITextView        *nowTextView; //
@property (nonatomic, retain) NSString	*selectWord;    //选择的字符串
@property (nonatomic, retain) NSSet *wordTouches;

void RouteChangeListener (void *       inClientData,
                          AudioSessionPropertyID inID,
                          UInt32       inDataSize,
                          const void * inData);
- (IBAction) playButtonPressed:(UIButton *)sender;
- (IBAction) collectButtonPressed:(UIButton *)sender;
- (IBAction) sliderChanged:(UISlider *)sender ;
- (IBAction) goBack:(UIButton *)sender ;
- (IBAction) prePlay:(id)sender;
- (IBAction) aftPlay:(id)sender;
- (IBAction) playMode:(id)sender;

- (void) QueueDownloadMusic;
- (void) catchWords:(NSString *) word;

- (BOOL )isExistenceNetwork :(NSInteger)choose;

- (void)setButtonImage:(UIImage *) image;
- (void)spinButton;
+ (PlayViewController *)sharedPlayer;
+ (NSOperationQueue *)sharedQueue;
-(IBAction)changePage:(UIPageControl *)sender;

- (void) aniToPlay:(UITextView *) myTextView ;

- (CMTime)playerItemDuration;



@end
