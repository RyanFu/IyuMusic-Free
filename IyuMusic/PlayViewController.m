//
//  PlayViewController.m
//  IyuMusic
//
//  Created by iyuba on 12-7-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PlayViewController.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

//@interface PlayViewController ()

//@end

@implementation PlayViewController

@synthesize music;
@synthesize myImageView;
@synthesize lyricImage;
@synthesize collectButton;
@synthesize switchBtn;
@synthesize textScroll;
@synthesize timeSwitch;
@synthesize totalTimeLabel;
@synthesize currentTimeLabel;
@synthesize timeSlider;
@synthesize sliderTimer;
@synthesize lyricSynTimer;
@synthesize lyricArray;
@synthesize timeArray;
@synthesize indexArray;
@synthesize lyricLabelArray;
@synthesize Lines;
@synthesize downloadFlg;
@synthesize wordPlayer;
@synthesize playButton;
@synthesize playModeButton;
@synthesize myHighLightWord;
@synthesize mp3Data;
@synthesize localFileExist;
@synthesize downloaded;
@synthesize newFile;
@synthesize userPath;
@synthesize myView;
@synthesize explainView;
@synthesize myWord;
@synthesize switchFlg;
@synthesize HUD;
@synthesize viewOne;
@synthesize viewTwo;
@synthesize myScroll;
@synthesize imgWords;
@synthesize titleWords;
@synthesize player;
@synthesize playerFlag;
@synthesize updateTimer;
@synthesize myTimer;
@synthesize myStop;
@synthesize playImage;
@synthesize pauseImage;
@synthesize loadingImage;
@synthesize shunxuImage;
@synthesize xunhuanImage;
@synthesize danquImage;
@synthesize suijiImage;
@synthesize alert;
@synthesize myCenter;
@synthesize nowUserId;
@synthesize pageControl;
@synthesize wordFrame;
@synthesize downloadingFlg;
//@synthesize isExistNet;
@synthesize preButton;
@synthesize nextButton;
@synthesize musicsArray;
@synthesize nowPlayRow;
//@synthesize backButton;
@synthesize playModeLabel;
@synthesize myImageFrame;
@synthesize songList;
@synthesize listButton;
@synthesize fixButton;
@synthesize fixTimer;
@synthesize fixTimeView;
@synthesize isFixing;
@synthesize myPick;
@synthesize clockButton;
@synthesize secsArray;
@synthesize minsArray;
@synthesize hoursArray;
@synthesize fixSeconds;
@synthesize playerView;
@synthesize isFree;
@synthesize selectWord;
@synthesize nowTextView;
@synthesize wordTouches;
//@synthesize myDelegate;

extern NSMutableArray *downLoadList;
extern ASIHTTPRequest *nowrequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    isiPhone =![Constants isPad];
    if(isiPhone){
        self = [super initWithNibName:@"PlayViewController" bundle:nibBundleOrNil];
    }else{
        self = [super initWithNibName:@"PlayViewController-ipad" bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
        //NSLog(@"%@",nibNameOrNil);
    
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
#pragma mark   - My action

- (void) showFix:(id)sender
{
    //设置两个View切换时的淡入淡出效果
    [UIView beginAnimations:@"Switch" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:.5];
    [fixTimeView setAlpha:0.7];
    [UIView commitAnimations];
}

- (IBAction) doFix:(id)sender
{
    //    [self changeTimer];
    if (isFixing) {
        isFixing = NO;
        [fixButton setTitle:@"开启定时" forState:UIControlStateNormal];
        if (isiPhone) {
            [clockButton setImage:[UIImage imageNamed:@"clockBBC.png"] forState:UIControlStateNormal];
        } else {
            [clockButton setImage:[UIImage imageNamed:@"clockBBCP.png"] forState:UIControlStateNormal];
        }
        
        [self changeTimer];
        //        [myPick selectRow:[myPick selectedRowInComponent:kMinComponent]+1 inComponent:kMinComponent animated:YES];
    } else {
        
        NSString *fixHour = [hoursArray objectAtIndex:[myPick selectedRowInComponent:kHourComponent]];
        NSString *fixMinute = [minsArray objectAtIndex:[myPick selectedRowInComponent:kMinComponent]];
        NSString *fixSecond = [minsArray objectAtIndex:[myPick selectedRowInComponent:kSecComponent]];
        fixSeconds = ([fixHour intValue]*60 + [fixMinute intValue])*60 + [fixSecond intValue];
        if (fixSeconds>0) {
            isFixing = YES;
            [fixButton setTitle:@"取消定时" forState:UIControlStateNormal];
            if (isiPhone) {
                [clockButton setImage:[UIImage imageNamed:@"clockedBBC.png"] forState:UIControlStateNormal];
            } else {
                [clockButton setImage:[UIImage imageNamed:@"clockedBBCP.png"] forState:UIControlStateNormal];
            }
            
            //            NSLog(@"%@时%@分%@秒--共:%d秒", fixHour, fixMinute,fixSecond,fixSeconds);
            [self changeTimer];
        }
        //        if (fixTimeView.hidden == NO) {
        //            [UIView beginAnimations:@"Switch" context:nil];
        //            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        //            [UIView setAnimationDuration:.5];
        //            [fixTimeView setHidden:YES];
        //            [UIView commitAnimations];
        //        }
    }
}

-(void)changeTimer
{
    //    //时间间隔
    //    NSTimeInterval timeInterval =1.0 ;
    //定时器
    if ([fixTimer isValid]) {
        [fixTimer invalidate];
        fixTimer = nil;
    } else {
        fixTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                    target:self
                                                  selector:@selector(handleFixTimer)
                                                  userInfo:nil
                                                   repeats:YES];
    }
}

-(void) handleFixTimer {
    fixSeconds--;
    if (fixSeconds != 0) {
        int sec = [myPick selectedRowInComponent:kSecComponent];
        int min = [myPick selectedRowInComponent:kMinComponent];
        int hour = [myPick selectedRowInComponent:kHourComponent];
        if (sec > 0) {
            [myPick selectRow:sec-1 inComponent:kSecComponent animated:YES];
        } else {
            if (min > 0) {
                [myPick selectRow:[self.secsArray count]-1 inComponent:kSecComponent animated:YES];
                [myPick selectRow:min-1 inComponent:kMinComponent animated:YES];
            } else {
                if (hour > 0) {
                    [myPick selectRow:[self.secsArray count]-1 inComponent:kSecComponent animated:YES];
                    [myPick selectRow:[self.minsArray count]-1 inComponent:kMinComponent animated:YES];
                    [myPick selectRow:hour-1 inComponent:kHourComponent animated:YES];
                }
                /*这句话其实可以不用写，为了保险起见就写了吧，。。*/
                else {
                    if ([self isPlaying]) {
                        [self playButtonPressed:playButton];
                    }
                    [myPick selectRow:0 inComponent:kSecComponent animated:YES];
                    [fixTimer invalidate];
                    fixTimer = nil;
                    isFixing = NO;
                    [fixButton setTitle:@"开启定时" forState:UIControlStateNormal];
                    if (isiPhone) {
                        [clockButton setImage:[UIImage imageNamed:@"clockBBC.png"] forState:UIControlStateNormal];
                    } else {
                        [clockButton setImage:[UIImage imageNamed:@"clockBBCP.png"] forState:UIControlStateNormal];
                    }
                }
            }
        }
    } else {
        if ([self isPlaying]) {
            [self playButtonPressed:playButton];
        }
        [myPick selectRow:0 inComponent:kSecComponent animated:YES];
        [fixTimer invalidate];
        fixTimer = nil;
        isFixing = NO;
        [fixButton setTitle:@"开启定时" forState:UIControlStateNormal];
        if (isiPhone) {
            [clockButton setImage:[UIImage imageNamed:@"clockBBC.png"] forState:UIControlStateNormal];
        } else {
            [clockButton setImage:[UIImage imageNamed:@"clockBBCP.png"] forState:UIControlStateNormal];
        }
        
    }
    
    
}
- (CMTime)playerItemDuration
{
    if ( [[[UIDevice currentDevice] systemVersion] floatValue]>= 4.3){
        AVPlayerItem *playerItem =[player currentItem];
        return ([playerItem duration]);
    }else {
        NSArray *seekRanges =[player.currentItem seekableTimeRanges];
        if (seekRanges.count >0)
        {
            CMTimeRange range = [[seekRanges objectAtIndex: 0] CMTimeRangeValue];
            double duration = CMTimeGetSeconds(range.start)+CMTimeGetSeconds(range.duration);
            return CMTimeMakeWithSeconds(duration, NSEC_PER_SEC);
        }
        return CMTimeMakeWithSeconds(0.f, NSEC_PER_SEC);
    }
}

- (IBAction) goBack:(UIButton *)sender
{
    if (![explainView isHidden]) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
    }
    if (songList.frame.size.height!=0) {
        [sender setBackgroundColor:[UIColor clearColor]];
        if (isiPhone) {
            if (IS_IPHONE_5) {
                [songList setFrame:CGRectMake(140,(isFree ?351+88:401+88), 180,0)];
                
            } else {
                [songList setFrame:CGRectMake(140, (isFree?351:401), 180,0)];
                
            }
        }else{
            [songList setFrame:CGRectMake(468,(isFree? 835:925), 300, 0)];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)changePage:(UIPageControl *)sender
{
    int page =pageControl.currentPage;
    CGRect frame =myScroll.frame;
    frame.origin.x = frame.size.width*page;
    frame.origin.y = 0;
    [myScroll scrollRectToVisible:frame animated:YES];
}

- (void) addWordPressed:(UIButton *)sender
{
    nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    //    NSLog(@"生词本添加用户：%d",nowUserId);
    myWord.userId = nowUserId;
    if (nowUserId>0) {
        if ([myWord alterCollect]) {
            alert = [[UIAlertView alloc] initWithTitle:kWordTwo message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
            
            [alert setBackgroundColor:[UIColor clearColor]];
            
            [alert setContentMode:UIViewContentModeScaleAspectFit];
            
            [alert show];
            
            NSTimer *timer = nil;
            timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(c) userInfo:nil repeats:NO];
        }
    }else
    {
        UIAlertView *addAlert = [[UIAlertView alloc] initWithTitle:kColFour message:kWordThree delegate:self cancelButtonTitle:kWordFour otherButtonTitles:nil ,nil];
        [addAlert setTag:3];
        [addAlert show];
    }
}

- (void) playWord:(UIButton *)sender
{
    if (wordPlayer) {
        [wordPlayer release];
    }
    wordPlayer =[[AVPlayer alloc]initWithURL:[NSURL URLWithString:myWord.audio]];
    [wordPlayer play];
}
- (BOOL)isPlaying
{
    return [player rate] !=0.f;
}


-(IBAction)prePlay:(id)sender
{
    [self prPlay];
    
}

-(IBAction)aftPlay:(id)sender
{
    if ([self isExistenceNetwork:1]) {
        [self nextPlay];
    }
    
}
-(IBAction)playMode:(id)sender
{
    NSTimer *timer = nil;
    switch ([[NSUserDefaults standardUserDefaults] integerForKey: @"playMode"]) {
        case 1:
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:2] forKey:@"playMode"];
            [playModeButton setImage:xunhuanImage forState:0];
//            alert = [[UIAlertView alloc] initWithTitle:@"循环播放" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
//            [alert setBackgroundColor:[UIColor blackColor]];
//            [alert setContentMode:UIViewContentModeScaleAspectFit];
//            [alert show];
            [playModeLabel setText:@"循环播放"];
            [playModeLabel setHidden:NO];
            timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(d) userInfo:nil repeats:NO];
            break;
        case 2:
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:3] forKey:@"playMode"];
            [playModeButton setImage:danquImage forState:0];
            [playModeLabel setText:@"单曲循环"];
            [playModeLabel setHidden:NO];
            timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(d) userInfo:nil repeats:NO];

            break;
        case 3:
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:4] forKey:@"playMode"];
            [playModeButton setImage:suijiImage forState:0];
            [playModeLabel setText:@"随机播放"];
            [playModeLabel setHidden:NO];

            timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(d) userInfo:nil repeats:NO];
            break;
        case 4:
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"playMode"];
            [playModeButton setImage:shunxuImage forState:0]; 
            [playModeLabel setText:@"顺序播放"];
            [playModeLabel setHidden:NO];
            timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(d) userInfo:nil repeats:NO];
            break;
        default:
            break;
    }
}
- (IBAction)listButtonPressed:(UIButton *)sender
{
    if (songList.frame.size.height!=0) {
        [UIView beginAnimations:@"classAniOne" context:nil];
        [UIView setAnimationDuration:0.6];
        [UIView setAnimationCurve:UIViewAnimationOptionCurveEaseInOut];
        [sender setBackgroundColor:[UIColor clearColor]];
        if (isiPhone) {
            if (IS_IPHONE_5) {
                [songList setFrame:CGRectMake(140, (isFree?351+88:401+88), 180,0)];

            } else {
                [songList setFrame:CGRectMake(140, (isFree?351:401), 180,0)];

            }
        }else{
            [songList setFrame:CGRectMake(468,(isFree?835:925), 300, 0)];
        }
        [UIView commitAnimations];
    
    } else {
        [songList reloadData];
        [UIView beginAnimations:@"classAniTwo" context:nil];
        [UIView setAnimationDuration:0.6];
        [UIView setAnimationCurve:UIViewAnimationOptionCurveEaseInOut];
        [sender setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.44f]];
        if (isiPhone) {
            if (IS_IPHONE_5) {
                [songList setFrame:CGRectMake(140, (isFree ?111+88:161+88), 180, 240)];

            } else {
                [songList setFrame:CGRectMake(140, (isFree?111:161), 180, 240)];

            }
        }else{
            [songList setFrame:CGRectMake(468,(isFree ?355:445), 300, 480)];
        }
        [UIView commitAnimations];
        
    }
}
- (IBAction)playButtonPressed:(UIButton *)sender
{
    
    if (localFileExist) {
        playerFlag = 0;
        if(downloaded){
            [lyricSynTimer invalidate];
            lyricSynTimer = nil;
            [loadProgress setProgress:1.0f];
            [player pause];
            [player release];
            player = nil;
            //            [localPlayer release];
            [playButton.layer removeAllAnimations];
            alert = [[UIAlertView alloc] initWithTitle:kPlayOne message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
            
            [alert setBackgroundColor:[UIColor clearColor]];
            
            [alert setContentMode:UIViewContentModeScaleAspectFit];
            
            [alert show];
            
            NSTimer *timer = nil;
            timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(c) userInfo:nil repeats:NO];
            
            NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            //创建audio份目录在Documents文件夹下，not to back up
            NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];
            
            mp3Url = [NSURL fileURLWithPath:[audioPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", music._audio]]];
            //            NSError *error = nil;
            player = [[AVPlayer alloc] initWithURL:mp3Url];
            CMTime playerDuration = [self playerItemDuration];
            double duration = CMTimeGetSeconds(playerDuration);
            
            CMTime playerProgress = [player currentTime];
            double progress = CMTimeGetSeconds(playerProgress);
                      //  NSLog(@"download wancheng");  
            //  获取mp3起止时间	
            [totalTimeLabel setHidden:NO];
            [currentTimeLabel setHidden:NO];
            currentTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:progress];
            //            NSLog(@"%@", [timeSwitchClass timeToSwitchAdvance:localPlayer.currentTime]);
            totalTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:duration];
            downloaded = NO;
        }
        if ([self isPlaying])
        {
            [lyricSynTimer invalidate];
            lyricSynTimer = nil;
            [self setButtonImage:pauseImage];
        }else {
            [self setButtonImage:playImage];
#if 1
            lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
                                                             target:self 
                                                           selector:@selector(lyricSyn) 
                                                           userInfo:nil 
                                                            repeats:YES];
#endif
        }
        
        CMTime playerDuration = [self playerItemDuration];
        double duration = CMTimeGetSeconds(playerDuration);
        //  Set the maximum value of the UISlider
        timeSlider.maximumValue = duration;
        
        //	Play the audio
        [MP3PlayerClass playButton:playButton 
                       localPlayer:player];
    }
    else
    {
        if ([self isExistenceNetwork:1]) {
            myStop = -1;
            playerFlag = 1;
            [currentTimeLabel setHidden:NO];
            
            if ([self isPlaying])
            {
                [lyricSynTimer invalidate];
                lyricSynTimer = nil;
                [self setButtonImage:pauseImage];
            }else {
                [self setButtonImage:playImage];
#if 1
                lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
                                                                 target:self 
                                                               selector:@selector(lyricSyn) 
                                                               userInfo:nil 
                                                                repeats:YES];
#endif
            }
            
            CMTime playerProgress = [player currentTime];
            double progress = CMTimeGetSeconds(playerProgress);
            CMTime playerDuration = [self playerItemDuration];
            double duration = CMTimeGetSeconds(playerDuration);
            currentTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:progress];
            //            NSLog(@"%@", [timeSwitchClass timeToSwitchAdvance:player.progress]);
            totalTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:duration];
            if (progress < duration ) {
                timeSlider.maximumValue = duration;
            }

            [MP3PlayerClass playButton:playButton 
                           localPlayer:player];
            //            if ([self isPlaying]) {
            //                #if 1
            //                            lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
            //                                                                            target:self 
            //                                                                           selector:@selector(lyricSyn) 
            //                                                                           userInfo:nil 
            //                                                                            repeats:YES];
            //                #endif
            //            }
            
        }
    }
}

-(void)c
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    [alert release];
}

-(void)d{
    [playModeLabel setHidden:YES];
}
- (void) setButtonImage:(UIImage *)image
{
    //NSLog(@"%@",playButton.layer);
    [playButton.layer removeAllAnimations];
    if(!image)
    {
        [playButton setImage:playImage forState:0];
    }
    else 
    {
        [playButton setImage:image forState:0];
        if ([playButton.currentImage isEqual:loadingImage])
        {
            [self spinButton];
        }
    }
}


- (void)spinButton
{
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    CGRect frame = [playButton frame];
    playButton.layer.anchorPoint = CGPointMake(0.5, 0.5);
    playButton.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
    [CATransaction commit];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
    [CATransaction setValue:[NSNumber numberWithFloat:120.0] forKey:kCATransactionAnimationDuration];
    
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:120 * M_PI];
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    animation.delegate = self;
    [playButton.layer addAnimation:animation forKey:@"rotationAnimation"];
    [CATransaction commit];
	
}

- (IBAction)collectButtonPressed:(UIButton *)sender {
    //NSLog(@"%d,%@,%d",[music _iid],[music _title],[music _icid]);
	UIAlertView *downAlert = [[UIAlertView alloc] initWithTitle:kPlayTwo message:kPlayThree delegate:self cancelButtonTitle:kFeedbackFive otherButtonTitles:kPlayFour,nil];
    [downAlert setTag:1];
	[downAlert show];
}

- (IBAction) sliderChanged:(UISlider *)slider{
    noBuffering = NO;
    seekTo = [slider value];
    [self setButtonImage:loadingImage];
    [MP3PlayerClass timeSliderChanged:slider 
                           timeSlider:timeSlider 
                          localPlayer:player 
                               button:playButton];
    //    [timeSlider setEnabled:NO];
}

// Update the slider about the music time
- (void)updateSlider {	
    CMTime playerProgress = [player currentTime];
    double progress = CMTimeGetSeconds(playerProgress);
    double duration = CMTimeGetSeconds([self playerItemDuration]);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.3){
        //        NSLog(@"Version>=4.3");
    }else {
        //        NSArray* seekRanges = [player.currentItem seekableTimeRanges];
        //        if (seekRanges.count > 0)  
        //        {  
        //            CMTimeRange range = [[seekRanges objectAtIndex:0] CMTimeRangeValue];  
        //            duration = CMTimeGetSeconds(range.start) + CMTimeGetSeconds(range.duration);  
        //            NSLog(@"duration2:%g", duration);  
        totalTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:duration];
        timeSlider.maximumValue = duration;
        //        }
    }
    
    NSArray* loadedRanges = player.currentItem.loadedTimeRanges;  
    if (loadedRanges.count > 0 && playerFlag == 1)  
    {  
        CMTimeRange range = [[loadedRanges objectAtIndex:0] CMTimeRangeValue];  
        double loaded = CMTimeGetSeconds(range.start) + CMTimeGetSeconds(range.duration);  
        //        NSLog(@"loaded:%g", loaded);
        if (duration>0.f) {
            [loadProgress setProgress:(loaded/duration)];
        }
    }
    
    if (!noBuffering && progress<seekTo && progress > 1) {
        
    }
    else {
        noBuffering = YES;
//        timeSlider.value = progress;
        if (progress > 0.f) {//#$$#
            [totalTimeLabel setHidden:NO];
            totalTimeLabel.text = [NSString stringWithFormat:@"%@", [timeSwitchClass timeToSwitchAdvance:duration]];
            //            NSLog(@"duration:%f", duration);
            self.timeSlider.maximumValue = duration;
            //        }
            //    }
            
            //        NSLog(@"当前进度:%f",progress);
            //        NSLog(@"数目:%i",[_timeArray count]);
            if (progress < duration) {
                self.timeSlider.value = progress;
                currentTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:progress];
            } else {
                self.timeSlider.value = duration;
                currentTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:duration];
            }
        }

//        currentTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:progress];
        if (progress == 0.f) {
            [player play];
            [playButton.layer removeAllAnimations];
            [playButton setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        }   
//        NSLog(@"timeslider:%f,timeslider:%f",timeSlider.maximumValue,timeSlider.value);
        if (timeSlider.maximumValue <= timeSlider.value+0.3f) {
            //[playButton.layer removeAllAnimations];
            //[player seekToTime:kCMTimeZero];
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"playMode"]==3) {
//                NSLog(@"danquxunhuan");
                [player seekToTime:kCMTimeZero];

            }else{
                kNetTest;
                if (kNetIsExist) {
//                    NSLog(@"%d",isExistNet);
                    [self nextPlay];
                }
                          }
            //            timeSlider.value = 0.f;
            //            [playButton setImage:[UIImage imageNamed:@"PplayPressed.png"] forState:UIControlStateNormal];
        }
    }
    
}

// 歌词同步
- (void)lyricSyn {
    //    NSLog(@"按钮监测");
    CMTime playerDuration = [self playerItemDuration];
    double duration = CMTimeGetSeconds(playerDuration);
    
    CMTime playerProgress = [player currentTime];
    double progress = CMTimeGetSeconds(playerProgress);
    if (!noBuffering && progress<seekTo && progress > 1) {
        //        NSLog(@"等待");
        [self setButtonImage:loadingImage];
    }
    else {
        noBuffering = YES;
        if ([self isPlaying])
        {
            //            NSLog(@"播放");
            [self setButtonImage:playImage];
        }
        else if (player.status == AVPlayerItemStatusReadyToPlay)
        {
            //            NSLog(@"暂停");
            [self setButtonImage:pauseImage];
        }else if (progress<duration&&!localFileExist)
        {
            //            NSLog(@"等待");
            [self setButtonImage:loadingImage];
        }
    }
    
    [LyricSynClass lyricSyn : (NSMutableArray *)lyricLabelArray
                      index : (NSMutableArray *)indexArray
                       time : (NSMutableArray *)timeArray
                localPlayer : (AVPlayer *)player 
                     scroll : (TextScrollView *)textScroll];    
	
}

/*- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
	
    //	[playButton setTitle:@"播放" forState:UIControlStateNormal];
    //	Music completed 
    //	这段加上之后,播放结束时会自动退出，不知原因?
#if 0
	if (flag) {
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"playMode"]==3) {
            NSLog(@"danquxunhuan");
            [sliderTimer invalidate];
        }else{
            NSLog(@"biedezoufa");
            [self nextPlay];
        }
        
    }
	
#endif
	
}
*/
- (void)modalView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//点击确定下载为0，取消为1
        if (alertView.tag == 1) {
            [self QueueDownloadMusic];
            [collectButton setHidden:YES];
        }
        else if (alertView.tag == 2){
            
            [myWord alterCollect];
        }else if (alertView.tag == 3)
        {
           LogController *myLog = [[LogController alloc]init];
            [self.navigationController pushViewController:myLog animated:YES];
        }
    }
    [alertView release];
}

-(BOOL) isExistenceNetwork:(NSInteger)choose
{
    UIAlertView *myalert = nil;
    kNetTest;
    switch (choose) {
        case 0:
            
            break;
        case 1:
            if (kNetIsExist) {
                
            }else {
                myalert = [[UIAlertView alloc] initWithTitle:kInfoTwo message:kRegNine delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil,nil];
                [myalert show];
                [myalert release];
            }
            break;
        default:
            break;
    }    
	return kNetIsExist;
}

- (void) showChDefine {
    //    NSLog(@"selectWord:%@", selectWord);
    @try {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"catchPause"] && [self isPlaying]) {
            [self playButtonPressed:playButton];
//            [player pause];
            //            [self setButtonImage:pauseImage];
            //            NSLog(@"pause");
        }
        selectWord = [nowTextView.text substringWithRange:nowTextView.selectedRange];
        [selectWord retain];
        LocalWord *word = [LocalWord findByKey:selectWord];
        myWord.wordId = [MusicWord findLastId] + 1;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kBePro"] && word) {
            //        if (word) {
            //            if (word) {
            //            myWord.wordId = [VOAWord findLastId] + 1;
            myWord.key = word.key;
            myWord.audio = word.audio;
            myWord.pron = [NSString stringWithFormat:@"%@",word.pron] ;
            if (myWord.pron == nil) {
                myWord.pron = @" ";
            }
            myWord.def = [[word.def stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
            [word release];
            [self wordExistDisplay];
            //            }
        } else {
            kNetTest;
            if (kNetIsExist) {
                //            NSLog(@"有网");
                [self catchWords:selectWord];
            } else {
                myWord.key = selectWord;
                myWord.audio = @"";
                myWord.pron = @" ";
                myWord.def = @"";
                [self wordNoDisplay];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"NSException");
    }
    @finally {
        //        NSLog(@"selectWord:%@", selectWord);
    }
}

//- (void) showSpeed {}
//
//- (void) showAB {}

- (void) aniToPlay:(UITextView *) myTextView {
    //    CGPoint windowPoint = [myTextView convertPoint:myTextView.bounds.origin toView:self.view];
    //    CGRect senRect = [myTextView frame];
    //    NSLog(@"text:%@", [myTextView text]);
    //    shareStr = [myTextView text];
    //    [shareStr retain];
    //    NSLog(@"str:%@", shareStr);
    [self screenTouchWord: myTextView];
    //    [self showSenShareBtn];
    //    senImage = [[UIImageView alloc] initWithFrame:senRect];
    //    [senImage setImage:[LyricSynClass screenshot:CGRectMake(windowPoint.x, windowPoint.y+ 20, senRect.size.width, senRect.size.height)]];
    //    [textScroll addSubview:senImage];
    //    [senImage release];
    //    [UIView beginAnimations:@"SwitchOne" context:nil];
    //    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //    [UIView setAnimationDuration:1.5];
    //    CATransition *animation = [CATransition animation];
    //    animation.delegate = self;
    //    animation.duration = 2.0;
    //    //        animation.timingFunction = UIViewAnimationCurveEaseInOut;
    //    animation.type = @"rippleEffect";
    //    [[myTextView layer] addAnimation:animation forKey:@"animation"];
    //    [senImage setFrame:CGRectMake(senRect.origin.x + senRect.size.width/2, senRect.origin.y + senRect.size.height/2, 1,1)];
    //    //        [shareSenBtn setFrame:CGRectMake(620, 200, 20, 20)];
    //    [UIView commitAnimations];
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
        if (action == @selector(showChDefine)) {
            
            //            UITextView *myText = sender;
            //            if(myText.selectedRange.length>0) {
            //                NSLog(@"%@", [myText.text substringWithRange:myText.selectedRange]);
            //            }
            return YES;
            
        }
    
    return NO;
}

- (void)closeExplaView {
    [explainView setHidden:YES];
}
- (void)wordExistDisplay {
    for (UIView *sView in [explainView subviews]) {
        if (![sView isKindOfClass:[UIImageView class]]) {
            [sView removeFromSuperview];
        }
    }
    
    UIFont *Courier = [UIFont fontWithName:@"Arial" size:14];
    UIFont *CourierTwo = [UIFont fontWithName:@"Arial" size:12];
    UIFont *CourierP = [UIFont fontWithName:@"Courier" size:16];
    UIFont *CourierTwoP = [UIFont fontWithName:@"Arial" size:14];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    
    [addButton addTarget:self action:@selector(addWordPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    if (isiPhone) {
        [addButton setImage:[UIImage imageNamed:@"addWord.png"] forState:UIControlStateNormal];
        [addButton setFrame:CGRectMake(280, 13, 33, 33)];
        
    } else {
        [addButton setImage:[UIImage imageNamed:@"addWord@2x.png"] forState:UIControlStateNormal];
        [addButton setFrame:CGRectMake(688, 24,66, 66)];
        
    }
    [explainView addSubview:addButton];
    
    UILabel *wordLabel = [[UILabel alloc]init];
    if (isiPhone) {
        [wordLabel setFont :Courier];
        
        [wordLabel setFrame:CGRectMake(5, 5, [myWord.key sizeWithFont:Courier].width+10, 20)];
    } else {
        [wordLabel setFont :CourierP];
        
        [wordLabel setFrame:CGRectMake(10,10, [myWord.key sizeWithFont:CourierP].width+20, 30)];
    }
    wordLabel.textColor = [UIColor whiteColor];
    [wordLabel setTextAlignment:UITextAlignmentCenter];
    wordLabel.text = myWord.key;
    wordLabel.backgroundColor = [UIColor clearColor];
    [explainView addSubview:wordLabel];
    [wordLabel release];
    
    UILabel *pronLabel = [[UILabel alloc]init];
    if (isiPhone) {
        [pronLabel setFrame:CGRectMake(15+[myWord.key sizeWithFont:Courier].width, 5, [[NSString stringWithFormat:@"[%@]", myWord.pron] sizeWithFont:Courier].width+10, 20)];
        [pronLabel setFont :CourierTwo];
    } else {
        [pronLabel setFrame:CGRectMake(35+[myWord.key sizeWithFont:CourierP].width,10, [[NSString stringWithFormat:@"[%@]", myWord.pron] sizeWithFont:CourierTwoP].width+20, 30)];
        [pronLabel setFont :CourierTwoP];
    }
    
    pronLabel.textColor = [UIColor whiteColor];
    [pronLabel setTextAlignment:UITextAlignmentLeft];
    if ([myWord.pron isEqualToString:@" "]) {
        pronLabel.text = @"";
    }else
    {
        pronLabel.text = [NSString stringWithFormat:@"[%@]", myWord.pron];
    }
    pronLabel.backgroundColor = [UIColor clearColor];
    [explainView addSubview:pronLabel];
    
    if (wordPlayer) {
        [wordPlayer release];
    }
    wordPlayer =[[AVPlayer alloc]initWithURL:[NSURL URLWithString:myWord.audio]];
    [wordPlayer play];
    
    UIButton *audioButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    if (isiPhone) {
        [audioButton setImage:[UIImage imageNamed:@"wordSound.png"] forState:UIControlStateNormal];
        [audioButton setFrame:CGRectMake(25+[myWord.key sizeWithFont:Courier].width + [[NSString stringWithFormat:@"[%@]", myWord.pron] sizeWithFont:Courier].width, 5, 20, 20)];
    } else {
        [audioButton setImage:[UIImage imageNamed:@"wordSound@2x.png"] forState:UIControlStateNormal];
        [audioButton setFrame:CGRectMake(55+[myWord.key sizeWithFont:Courier].width + [[NSString stringWithFormat:@"[%@]", myWord.pron] sizeWithFont:CourierP].width,10, 30, 30)];
    }
    
    [audioButton addTarget:self action:@selector(playWord:) forControlEvents:UIControlEventTouchUpInside];
    
    [explainView addSubview:audioButton];
    

    
    UITextView *defTextView = [[UITextView alloc] init];
    if (isiPhone) {
        [defTextView  setFrame:CGRectMake(0, 22,275, 30)];
        [defTextView setFont :CourierTwo];
    } else {
        [defTextView  setFrame:CGRectMake(0, 44,670, 60)];
        [defTextView setFont :CourierTwoP];
    }
    
    if ([myWord.def isEqualToString:@" "]) {
        defTextView.text = kPlaySeven;
        //                    NSLog(@"未联网无法查看释义!");
    }else{
        defTextView.text = myWord.def;
    }
    [defTextView setEditable:NO];
    
    defTextView.textColor = [UIColor whiteColor];
    defTextView.backgroundColor = [UIColor clearColor];
    [explainView addSubview:defTextView];
    [defTextView release];
    [explainView setAlpha:1];
    [explainView setHidden:NO];
}

- (void)wordNoDisplay {
    myWord.audio = @"";
    myWord.pron = @" ";
    myWord.def = @"";
    for (UIView *sView in [explainView subviews]) {
        if (![sView isKindOfClass:[UIImageView class]]) {
            [sView removeFromSuperview];
        }
    }
    UIFont *Courier = [UIFont fontWithName:@"Arial" size:14];
    UIFont *CourierTwo = [UIFont fontWithName:@"Arial" size:12];
    UIFont *CourierP = [UIFont fontWithName:@"Courier" size:16];
    UIFont *CourierTwoP = [UIFont fontWithName:@"Arial" size:14];
    
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    
    [addButton addTarget:self action:@selector(addWordPressed:) forControlEvents:UIControlEventTouchUpInside];
    if (isiPhone) {
        [addButton setImage:[UIImage imageNamed:@"addWord.png"] forState:UIControlStateNormal];
        [addButton setFrame:CGRectMake(280, 13, 33, 33)];
        
    } else {
        [addButton setImage:[UIImage imageNamed:@"addWord@2x.png"] forState:UIControlStateNormal];
        [addButton setFrame:CGRectMake(688, 24,66, 66)];
        
    }
    [explainView addSubview:addButton];
    
    UILabel *wordLabel = [[UILabel alloc]init];
    if (isiPhone) {
        [wordLabel setFont :Courier];
        
        [wordLabel setFrame:CGRectMake(5, 5, [myWord.key sizeWithFont:Courier].width+10, 20)];
    } else {
        [wordLabel setFont :CourierP];
        
        [wordLabel setFrame:CGRectMake(10,10, [myWord.key sizeWithFont:CourierP].width+20, 30)];
    }
    
    [wordLabel setTextAlignment:UITextAlignmentCenter];
    wordLabel.text = myWord.key;
    wordLabel.backgroundColor = [UIColor clearColor];
    wordLabel.textColor = [UIColor whiteColor];
    [explainView addSubview:wordLabel];
    
    [wordLabel release];
    
    UILabel *defLabel = [[UILabel alloc]init];
    if (isiPhone) {
        [defLabel setFont :CourierTwo];
        [defLabel  setFrame:CGRectMake(5, 22, 275, 30)];
    } else {
        [defLabel setFont :CourierTwoP];
        [defLabel  setFrame:CGRectMake(10, 44, 670, 60)];
    }
    
    
    defLabel.backgroundColor = [UIColor clearColor];
    [defLabel setLineBreakMode:UILineBreakModeWordWrap];
    [defLabel setNumberOfLines:1];
    defLabel.textColor = [UIColor whiteColor];
    defLabel.text = kWordEight;
    //                                NSLog(@"无查找结果!");
    [explainView addSubview:defLabel];
    [defLabel release];
    [explainView setAlpha:1];
    [explainView setHidden:NO];
}
/**
 *  屏幕取词
 */
-(void)screenTouchWord:(UITextView *)mylabel{
    int lineHeight = [@"a" sizeWithFont:mylabel.font].height;
    int LineStartlocation = 0;
    if (mylabel.tag == 2000) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
        return;
    }
    if (![explainView isHidden]) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
    }
    //    NSLog(@"取词:%@",mylabel.text);
    NSString * WordIFind = nil;
    UITouch *touch=[wordTouches anyObject];
    CGPoint point = [touch locationInView:mylabel];
//    int lineHeight = [@"a" sizeWithFont:mylabel.font].height;
//    int LineStartlocation = 0;
    //    int numberoflines = self.frame.size.height / lineHeight;
    int tagetline = ceilf(point.y/lineHeight);    //    int numberoflines = self.frame.size.height / lineHeight;
    //    NSString * sepratorString = @", ，。.?!:\"“”-()'’‘";
    NSString * sepratorString = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    //    NSString * text = @"...idowrhu wpe gre dddd.. 'eow.ei, we u";
    NSCharacterSet * sepratorSet = [[NSCharacterSet characterSetWithCharactersInString:sepratorString] invertedSet];
    NSArray * splitStr = [mylabel.text componentsSeparatedByCharactersInSet:sepratorSet];
    //    NSLog(@"%@",splitStr);
    int nullnum=0;
    for (int i=0; i<[splitStr count]; i++) {
        if ([[splitStr objectAtIndex:i]isEqualToString:@""]) {
            nullnum++;
        }
    }
    //    NSLog(@"nullnum:%d",nullnum);
    if (nullnum>[splitStr count]/2) {
        return;
    }
    //    NSArray * splitStr = [self.text componentsMatchedByRegex:<#(NSString *)#>
    //    NSArray * splitStr = [self.text componentsSeparatedByString:@" "];
    int WordIndex = 0;
    int count = [splitStr count];
    BOOL WordFound = NO;
    NSString * string = @"";
    NSString * string2 = @"";
    CGSize maxSize = CGSizeMake(textScroll.frame.size.width, CGFLOAT_MAX);
    
    for (int i = 0; i < count && !WordFound; i++) {
        string = [string stringByAppendingString:[NSString stringWithFormat:@"%@.",[splitStr objectAtIndex:i]]];
        
        if (![[splitStr objectAtIndex:i] isMatchedByRegex:@"[a-zA-Z0-9]"]) {
            //           NSLog(@"%@is not an English word",[splitStr objectAtIndex:i]);
            //            continue;
        }
        CGSize mysize = CGSizeZero;
        @try {
            //            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@.",[splitStr objectAtIndex:i]]];
            
            //            NSString * substr = [self.text substringWithRange:NSMakeRange(LineStartlocation, i == count - 1 ? [string length]-1:[string length])];
            NSString * substr = [mylabel.text substringWithRange:NSMakeRange(LineStartlocation, [string length]-1)];
            mysize = [substr sizeWithFont:mylabel.font constrainedToSize:maxSize ];
            //            NSLog(@"string:%@。substr:%@",string,substr);
        }
        @catch (NSException *exception) {
            continue;
        }
        int  taget=mysize.height/lineHeight;
        if (taget==0) {
            taget=1;
        }
        if (taget == tagetline && !WordFound) {
            LineStartlocation = [string length] - [[splitStr objectAtIndex:i] length] -1;
            //            if (tagetline!=1) {
            //            if (![[mylabel.text substringWithRange:NSMakeRange(LineStartlocation-1, 1)] isMatchedByRegex:@", ，。.?!:\"“”-()'’‘"]) {
            //                LineStartlocation--;
            //            }
            //            }
            //            NSLog(@"string length:%d,splitstr length:%d,linestart:%d",[string length],[[splitStr objectAtIndex:i]length],LineStartlocation);
            for (; i < count; i++) {
                
                string2 = [string2 stringByAppendingString:[NSString stringWithFormat:@"%@.",[splitStr objectAtIndex:i]]];
                //                NSLog(@"i:%i,linestart:%d,splitStr:%@,string:%@,string2:%@",i,LineStartlocation,[splitStr objectAtIndex:i],string,string2);
                NSString * substr2 = nil;
                @try {
                    //                    substr2 = [self.text substringWithRange:NSMakeRange(LineStartlocation, i == count - 1 ? [string2 length]-1:[string2 length])];
                    substr2 = [mylabel.text substringWithRange:NSMakeRange(LineStartlocation, [string2 length]-1)];
                    //                    NSLog(@"string2:%@,substr2:%@",string2,substr2);
                    
                    CGSize thissize = [substr2 sizeWithFont:mylabel.font constrainedToSize:maxSize];
                    if (thissize.height/lineHeight > 1) {
                        return;
                    }
                    
                    if (thissize.width > point.x) {
                        
                        WordIndex = i;
                        WordFound = YES;
                        break;
                    }
                }
                
                
                @catch (id exception) {
                    if ([exception isKindOfClass:[NSException class]]) {
                        //                        NSLog(@"exception:%@",exception);
                    }
                    else {
                        //                        NSLog(@"unknown exception");
                    }
                    continue;
                }
            }
        }
        
    }
    if (WordFound) {
        @try {
            
            WordIFind = [splitStr objectAtIndex:WordIndex];
            
            CGFloat pointY = (tagetline -1 ) * lineHeight;
            CGFloat width = [[splitStr objectAtIndex:WordIndex] sizeWithFont:mylabel.font].width;
            
            NSRange Range1 = [string2 rangeOfString:[splitStr objectAtIndex:WordIndex] options:NSBackwardsSearch];
            //            NSLog(@"%@",string2);
            NSString * str = [[mylabel.text substringFromIndex:LineStartlocation ] substringToIndex:Range1.location];
            //            int i = 0;
            //            while ([[str substringToIndex:i] isEqual:@"."]) {
            //                str = [str substringFromIndex:i+1];
            //                i++;
            //
            //            }
            //            NSLog(@"str:%@",str);
            CGFloat pointX = [str sizeWithFont:mylabel.font].width;
            //            CGFloat pointX = [substr
            
            LocalWord *word = [LocalWord findByKey:WordIFind];
            myWord.wordId = [MusicWord findLastId] + 1;
            if ([[NSUserDefaults standardUserDefaults] boolForKey:kBePro] && word) {
                //            if (word) {
                //        if (word) {
                //            if (word) {
                //            myWord.wordId = [VOAWord findLastId] + 1;
                myWord.key = word.key;
                myWord.audio = word.audio;
                myWord.pron = [NSString stringWithFormat:@"%@",word.pron] ;
                if (myWord.pron == nil) {
                    myWord.pron = @" ";
                }
                myWord.def = [[word.def stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
                [word release];
                [self wordExistDisplay];
                //            }
            } else {
                kNetTest;
                if (kNetIsExist) {
                    //            NSLog(@"有网");
                    [self catchWords:WordIFind];
                } else {
                    myWord.key = WordIFind;
                    myWord.audio = @"";
                    myWord.pron = @" ";
                    myWord.def = @"";
                    [self wordNoDisplay];
                }
            }
            
            
            
            [myHighLightWord setFrame:CGRectMake(pointX+7, mylabel.frame.origin.y + pointY, width, lineHeight)];
            [myHighLightWord setAlpha:1.0];
            [myHighLightWord setHighlighted:YES];
            [myHighLightWord setHighlightedTextColor:[UIColor whiteColor]];
            [myHighLightWord setBackgroundColor:[UIColor colorWithRed:136.0/255 green:179.0/255 blue:1.0 alpha:1]];
            [textScroll insertSubview:myHighLightWord belowSubview:mylabel];
            [myHighLightWord setHidden:NO];
        }
        @catch (id exception) {
            if ([exception isKindOfClass:[NSException class]]) {
                //                NSLog(@"exception:%@",exception);
            }
            else {
                //                     NSLog(@"unknown exception");
            }
            return;
        }
        //        wordBack = [[UIView alloc] initWithFrame:CGRectMake(pointX, pointY, width, lineHeight)];
        //        wordBack.backgroundColor = [UIColor colorWithRed:1.0 green:0.651 blue:0.098 alpha:0.5];
        //        [self insertSubview:wordBack atIndex:0];
        //        [self GetExplain:WordIFind];
    }   
    
}

#pragma mark - View lifecycle
-(void)play{
    //    NSLog(@"nowPlayRow:%d",nowPlayRow);
    music =[musicsArray objectAtIndex:nowPlayRow];
    needFlush = NO;
    noBuffering = YES;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:self.music._iid] forKey:@"lastPlay"];
    //        [[NSNotificationCenter defaultCenter]removeObserver:self name:ASStatusChangedNotification object:player];
    [playButton.layer removeAllAnimations];
    myTimer = 0;
    // [MusicView alterRead:music._iid];
    downloaded = NO;
    if (player) {
        [player pause];
        [player release];
        player = nil;
    }
    [lyricSynTimer invalidate];
    [sliderTimer invalidate];
    timeSlider.value = 0;
    [loadProgress setProgress:0.f];
    self.navigationController.navigationBarHidden = YES;
    CGPoint startOffet = CGPointMake(0, 0);
    //    UIFont *Courier = [UIFont fontWithName:@"Arial" size:18];
    //    [titleWords setFont:Courier];
    NSString *title =[[NSString alloc] initWithFormat:@"%@",music._title];
    [titleWords setText:title];
    //    [titleWords setContentOffset:startOffet];
    //NSURL *url = [NSURL URLWithString: music._pic];
    //[myImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:picname]];
    NSString *picname =[[NSString alloc]initWithFormat:@"image%@.jpg",music._pic];
    [myImageView setImage:[UIImage imageNamed:picname]];
    if (isiPhone) {
        [myImageFrame setImage:[UIImage imageNamed:@"imageFrame.png"]];
    } else {
        [myImageFrame setImage:[UIImage imageNamed:@"imageFrame@2x.png"]];
    }
    
    [imgWords setTextColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.7]];
    [imgWords setTextAlignment:UITextAlignmentLeft];
    [imgWords setContentOffset:startOffet];
    [imgWords setText:music._intro];
    //刚进入页面时让歌词显示在开头
    [textScroll setContentOffset:startOffet];
    [myScroll setContentOffset:startOffet];
    [timeSlider addTarget:self
                   action:@selector(sliderChanged:)
         forControlEvents:UIControlEventValueChanged];
    [playButton addTarget:self
                   action:@selector(playButtonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    //        [playButton addTarget:self
    //                       action:@selector(playButtonPressed:)
    //             forControlEvents:UIEventSubtypeMotionShake];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //创建audio份目录在Documents文件夹下，not to back up
    NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];;
    userPath = [audioPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", music._audio]];
    localFileExist = [[NSFileManager defaultManager] fileExistsAtPath:userPath];
    mp3Url = [NSURL fileURLWithPath:userPath];
    player = nil;
    if (localFileExist) {
        [loadProgress setProgress:1.f];
        player = [[AVPlayer alloc] initWithURL:mp3Url];
        AudioSessionInitialize(NULL, NULL, NULL, NULL);
        [[AVAudioSession sharedInstance] setDelegate: self];
        playerFlag = 0;
        //            [player release];
        //            player = nil;
        [downloadFlg setHidden:NO];
        [collectButton setHidden:YES];
        [downloadingFlg setHidden:YES];
        //            NSLog(@"cunzai");
        //  获取mp3起止时间
        [totalTimeLabel setHidden:NO];
        [currentTimeLabel setHidden:NO];
        CMTime playerDuration = [self playerItemDuration];
        double duration = CMTimeGetSeconds(playerDuration);
        
        CMTime playerProgress = [player currentTime];
        double progress = CMTimeGetSeconds(playerProgress);
        currentTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:progress];
        //            NSLog(@"%@", [timeSwitchClass timeToSwitchAdvance:localPlayer.currentTime]);
        totalTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:duration];
        timeSlider.maximumValue = duration;
        [self setButtonImage:loadingImage];
        [player play];
        //            [playButton setImage:[UIImage imageNamed:@"PplayPressed.png"] forState:UIControlStateNormal];
    }else
    {
        //NSLog(@"1");
        player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://static2.iyuba.com/go/musichigh/%@", music._audio]]];
        playerFlag = 1;
        // NSLog(@"%@  %@",music._title,music._singer);
        /*if ([MusicView isDownloading:music._iid]) {
         [downloadingFlg setHidden:NO];
         [downloadFlg setHidden:YES];
         [collectButton setHidden:YES];
         }else {*/
        int i=0;
        for (; i<[downLoadList count]; i++) {
            int downloadid = [[downLoadList objectAtIndex:i]intValue];
            if (downloadid ==music._iid) {
                break;
            }
        }
        if (i<[downLoadList count])  {
            [downloadFlg setHidden:YES];
            [collectButton setHidden:YES];
            [downloadingFlg setHidden:NO];
            localFileExist = NO;
        } else {
            [downloadFlg setHidden:YES];
            [collectButton setHidden:NO];
            [downloadingFlg setHidden:YES];
            localFileExist = NO;
        }
        //}
        //            NSLog(@"3");
        [totalTimeLabel setHidden:YES];
        [currentTimeLabel setHidden:YES];
        
        //            NSLog(@"开始取时间");
        //            CMTime playerDuration = [self playerItemDuration];
        //            double duration = CMTimeGetSeconds(playerDuration);
        ////            double duration = CMTimeGetSeconds([[player currentItem] duration]);
        //            NSLog(@"duration1:%lf",duration);
        
        //            NSArray* loadedRanges = player.currentItem.loadedTimeRanges;
        //            if (loadedRanges.count > 0)
        //            {
        //                CMTimeRange range = [[loadedRanges objectAtIndex:0] CMTimeRangeValue];
        //                double duration = CMTimeGetSeconds(range.start) + CMTimeGetSeconds(range.duration);
        //                NSLog(@"duration2:%g", duration);
        //            }
        //
        //            CMTime playerProgress = [player currentTime];
        //            double progress = CMTimeGetSeconds(playerProgress);
        ////            NSLog(@"progress:%lf",progress);
        kNetTest;
        if (kNetIsExist) {
            [player play];
            //                NSArray* loadedRanges = player.currentItem.seekableTimeRanges;
            //                double duration;
            //                if (loadedRanges.count > 0)
            //                {
            //                    CMTimeRange range = [[loadedRanges objectAtIndex:0] CMTimeRangeValue];
            //                    duration = CMTimeGetSeconds(range.start) + CMTimeGetSeconds(range.duration);
            //                    NSLog(@"duration2:%g", duration);
            //                }
            
            CMTime playerProgress = [player currentTime];
            double progress = CMTimeGetSeconds(playerProgress);
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.3){
                //                    NSLog(@"Version>=4.3");
                CMTime playerDuration = [self playerItemDuration];
                double duration = CMTimeGetSeconds(playerDuration);
                totalTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:duration];
                timeSlider.maximumValue = duration;
            }else {
                
            }
            //            NSLog(@"progress:%lf",progress);
            
            [totalTimeLabel setHidden:NO];
            [currentTimeLabel setHidden:NO];
            currentTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:progress];
            //                totalTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:duration];
            //                timeSlider.maximumValue = duration;
            timeSlider.value = progress;
            [self setButtonImage:loadingImage];
        }else
        {
            needFlush = YES;
        }
        downloaded = NO;
    }
    //缓冲进度显示
    
    //时间可调
    sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                   target:self
                                                 selector:@selector(updateSlider)
                                                 userInfo:nil
                                                  repeats:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lyricArray removeAllObjects];
        [timeArray removeAllObjects];
        [indexArray removeAllObjects];
        [DatabaseClass querySQL:(NSMutableArray *)lyricArray
                   timeResultIn:(NSMutableArray *)timeArray
                  indexResultIn:(NSMutableArray *)indexArray
                  musicResultIn:(MusicView *)music];
        dispatch_async(dispatch_get_main_queue (), ^{
            for (UIView *deleteView in [textScroll subviews]) {
                [deleteView removeFromSuperview];
            }
            //    for(int i=0;i<[timeArray count];i++)
            //    {
            //        NSLog(@"time:%@,lyricarray:%@",[timeArray objectAtIndex:i],[lyricArray objectAtIndex:i]);
            //    }
            lyricLabelArray = [[NSMutableArray alloc] init];//释放
            int setY = [LyricSynClass lyricView : (NSMutableArray *)lyricLabelArray
                                          index : (NSMutableArray *)indexArray
                                          lyric : (NSMutableArray *)lyricArray
                                         scroll : (TextScrollView *)textScroll
                        //                         myLabelDelegate: (id <MyLabelDelegate>) self
                                          Lines : (int *)&Lines];
            nowTextView = [lyricLabelArray objectAtIndex:0];
            
            CGSize newSize = CGSizeMake(textScroll.frame.size.width, setY);
            [textScroll setContentSize:newSize];
            [myScroll addSubview:textScroll];
            
            //        NSLog(@"3");
            //  歌词同步的实现
            //#if 1
            lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                             target:self
                                                           selector:@selector(lyricSyn)
                                                           userInfo:nil
                                                            repeats:YES];
            //#endif
        });
    });
    
    kNetTest;
    if (needFlushAdv && kNetIsExist) {
        needFlushAdv = NO;
        [bannerView_ loadRequest:[GADRequest request]];
    }
    
    [HUD hide:YES];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self catchNetA];
    kNetTest;
    //    NSLog(@"字体大小：%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"mulValueFont"]);
    //    NSLog(@"字体颜色：%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"mulValueColor"]);
    //    NSLog(@"app");
    //    //开启外部控制音频播放
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];  
//    [self becomeFirstResponder]; 
    [songList reloadData];
    [[UIApplication sharedApplication] setIdleTimerDisabled:[[NSUserDefaults standardUserDefaults] boolForKey:@"keepScreenLight"]];
    
    nowUserId = 0;
    nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    if ([MusicFav isCollected:music._iid]) {
        [downloadFlg setHidden:NO];
        [collectButton setHidden:YES];
        [downloadingFlg setHidden:YES];
    } else
    {
        int i=0;
        for (; i<[downLoadList count]; i++) {
            int downloadid = [[downLoadList objectAtIndex:i]intValue];
            if (downloadid ==music._iid) {
                break;
            }
        }
        if (i<[downLoadList count])  {
        [downloadFlg setHidden:YES];
        [collectButton setHidden:YES];
        [downloadingFlg setHidden:NO];
        localFileExist = NO;
        } else {
        [downloadFlg setHidden:YES];
        [collectButton setHidden:NO];
        [downloadingFlg setHidden:YES];
        localFileExist = NO;
        }
    }
    
    //    if (newFile == NO && (needFlush == NO || (needFlush == YES && [self isExistenceNetwork:0] == NO))) {
    kNetTest;
    if (newFile == NO && (needFlush == NO || (needFlush == YES && kNetIsExist == NO))) {
            UILabel *test = [lyricLabelArray objectAtIndex:0];
            int fontSize = 15;
            if ([Constants isPad]) {
                fontSize = 20;
            }
            int mulValueFont = [[NSUserDefaults standardUserDefaults] integerForKey:@"mulValueFont"];
            if (mulValueFont > 0) {
                fontSize = mulValueFont;
            }
            UIFont *Courier = [UIFont systemFontOfSize:fontSize];//初始15
//            if (test.font == Courier) {
//            NSLog(@"font:%@!!", [test.font fontName]);
            if (test.font == Courier) {
                NSLog(@"same!!");
                
            } else {
                NSLog(@"not same!!");
                for (UIView *deleteView in [textScroll subviews]) {
                    [deleteView removeFromSuperview];
                }
                
                /*
                 *  清空lyricLabelArray与lyricCnLabelArray两个数组
                 */
                for (UIView *deleteView in lyricLabelArray) {
                    [deleteView removeFromSuperview];
                }
                
                [lyricLabelArray removeAllObjects];
                int setY = [LyricSynClass lyricView : (NSMutableArray *)lyricLabelArray
                                             index : (NSMutableArray *)indexArray
                                              lyric : (NSMutableArray *)lyricArray
                                              scroll : (TextScrollView *)textScroll
//                                     myLabelDelegate: (id <MyLabelDelegate>) self
                                           Lines : (int *)&Lines];
                nowTextView = [lyricLabelArray objectAtIndex:0];
                //        NSLog(@"lyricLabelArrayretainnumber:%i", [self.lyricLabelArray retainCount]);
                CGSize newSize = CGSizeMake(textScroll.frame.size.width, setY);
                [textScroll setContentSize:newSize];
            }
        self.navigationController.navigationBarHidden = YES;
    }else{
        [self play];

    }
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated]; 
    newFile = NO;
    //    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    //    //有关外部控制音频播放
//    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];  
//    [self resignFirstResponder]; 
}

- (void)viewDidLoad
{
    [self.view setFrame:[UIScreen mainScreen].bounds];
//    isExistNet = YES;
    isFree = ![[NSUserDefaults standardUserDefaults] boolForKey:kBePro];
//    isFree = NO;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setDelegate:self];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    
    //开启外部控制音频播放
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];  
    //自己添加
//    UIBackgroundTaskIdentifier newTaskId= UIBackgroundTaskInvalid;
//    UIBackgroundTaskIdentifier oldTaskId= UIBackgroundTaskInvalid;
//
//    newTaskId =[[UIApplication sharedApplication]beginBackgroundTaskWithExpirationHandler:NULL];
//    if(newTaskId !=UIBackgroundTaskInvalid&&oldTaskId!=UIBackgroundTaskInvalid){
//        [[UIApplication sharedApplication]endBackgroundTask:oldTaskId];
//    }
//    oldTaskId=newTaskId;
    [self becomeFirstResponder]; 
    
    [[fixButton layer] setCornerRadius:8.0f];
    [[fixButton layer] setMasksToBounds:YES];
    isFixing=NO;
    localFileExist = NO;
    switchFlg = YES;
    //    [shareButton setBackgroundImage:[UIImage imageNamed:@"sinaLogo.png"] forState:UIControlStateNormal];
    UIMenuItem *menuItem = [[UIMenuItem alloc]initWithTitle:@"中译" action:@selector(showChDefine)];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:[NSArray arrayWithObject:menuItem]];
    [menuItem release];
    
    isiPhone = ![Constants isPad];
    if (isiPhone) {
        if (IS_IPHONE_5) {
            loadProgress = [[SevenProgressBar alloc] initWithFrame:CGRectMake(63,(isFree? 363+88:413+88), 194, 2) andbackImg:[UIImage imageNamed:@"SliderBg.png"] frontimg:[UIImage imageNamed:@"SliderLoad.png"]];
        } else {
            loadProgress = [[SevenProgressBar alloc] initWithFrame:CGRectMake(63,(isFree? 363:413), 194,2) andbackImg:[UIImage imageNamed:@"SliderBg.png"] frontimg:[UIImage imageNamed:@"SliderLoad.png"]];
        }
        
    }else {
        loadProgress = [[SevenProgressBar alloc] initWithFrame:CGRectMake(112 ,(isFree?850:940), 544,4) andbackImg:[UIImage imageNamed:@"SliderBg@2x.png"] frontimg:[UIImage imageNamed:@"SliderLoad@2x.png"]];
    }
    
    [self.view insertSubview:loadProgress belowSubview:timeSlider];
    if (isiPhone) {
        if (IS_IPHONE_5) {
            [timeSlider setFrame:CGRectMake(61,(isFree? 356+88:406+88),198, 16)];
        } else {
            [timeSlider setFrame:CGRectMake(61, (isFree?356:406), 198,16)];
        }
    
    } else {
        [timeSlider setFrame:CGRectMake(110,(isFree? 842:932), 548, 20)];
    }
    pageControl.backgroundColor = [UIColor clearColor];
	[pageControl setImagePageStateNormal:[UIImage imageNamed:@"dotcrt.png"]];
	[pageControl setImagePageStateHightlighted:[UIImage imageNamed:@"dotbhd.png"]];
    
    //    [loadProgress setTrackImage:[UIImage imageNamed:@"slider.png"]];
    //    [loadProgress setProgressImage:[UIImage imageNamed:@"sliderMin.png"]];
    
    [timeSlider setMaximumTrackImage:[UIImage imageNamed:@"SliderMax.png"] forState:UIControlStateNormal];
    [timeSlider setMinimumTrackImage:[UIImage imageNamed:@"SliderDone.png"] forState:UIControlStateNormal];
    [timeSlider setThumbImage:[UIImage imageNamed:@"thumb.png"] forState:UIControlStateNormal];
    
    UIFont *CourierOne = [UIFont systemFontOfSize:15];
    UIFont *CourierTwo = [UIFont systemFontOfSize:20];
    //    UIFont *tFont = [UIFont fontWithName:[[UIFont fontNamesForFamilyName:@"AppleGothic"] objectAtIndex:0] size:20];
    
    if (isiPhone) {
        if (IS_IPHONE_5) {
            
            if (isFree) {
                [playerView setFrame:CGRectMake(0, 350+88, 320, 60)];
                textScroll = [[TextScrollView alloc]initWithFrame:CGRectMake(354, 10, 253, 275+88)];
                imgWords = [[UITextView alloc] initWithFrame:CGRectMake(15, 160, 290, 130+88)];
                songList = [[UITableView alloc] initWithFrame:CGRectMake(140, 350+88, 180, 0)];
                [myScroll setContentSize:CGSizeMake(640, 300)];
                [myScroll setFrame:CGRectMake(0, 66, 320, 300+88)];
                [pageControl setFrame:CGRectMake(141, 325+88, 31, 36)];
                [playModeLabel setFrame:CGRectMake(120, 332+84, 70, 30)];
           
            } else {
                [playerView setFrame:CGRectMake(0, 400+88, 320, 60)];
                textScroll = [[TextScrollView alloc]initWithFrame:CGRectMake(354, 10, 253, 325+88)];
                
                imgWords = [[UITextView alloc] initWithFrame:CGRectMake(15, 160, 290, 180+88)];
                songList = [[UITableView alloc] initWithFrame:CGRectMake(140, 400+88, 180, 0)];
                [myScroll setContentSize:CGSizeMake(640, 350)];
                [myScroll setFrame:CGRectMake(0, 66, 320, 350+88)];
                [pageControl setFrame:CGRectMake(141, 375+88, 31, 36)];
                [playModeLabel setFrame:CGRectMake(120, 382+84, 70, 30)];
            }
            myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 25, 120, 120)];
            myImageFrame = [[UIImageView alloc]initWithFrame:CGRectMake(75,20 , 130, 130)];
            [imgWords setFont:CourierOne];
            collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [collectButton setImage:[UIImage imageNamed:@"PcollectPressedBBC.png"] forState:UIControlStateNormal];
            [collectButton setFrame:CGRectMake(240, 100, 40, 40)];
            [collectButton addTarget:self action:@selector(collectButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            downloadFlg = [UIButton buttonWithType:UIButtonTypeCustom];
            [downloadFlg setImage:[UIImage imageNamed:@"downloadedBBC.png"] forState:UIControlStateNormal];
            [downloadFlg setFrame:CGRectMake(240, 100, 40, 40)];
            //        downloadingFlg  = [[UIButton alloc]init];
            downloadingFlg = [UIButton buttonWithType:UIButtonTypeCustom];
            [downloadingFlg setImage:[UIImage imageNamed:@"downloadingBBC.png"] forState:UIControlStateNormal];
            //        [downloadingFlg.titleLabel setTextColor:[UIColor whiteColor]];
            [downloadingFlg setFrame:CGRectMake(240, 100, 40, 40)];
            
            clockButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [clockButton setImage:[UIImage imageNamed:@"clockBBC.png"] forState:UIControlStateNormal];
            [clockButton setFrame:CGRectMake(240, 35, 35, 35)];
            [clockButton addTarget:self action:@selector(showFix:) forControlEvents:UIControlEventTouchUpInside];
            [clockButton setBackgroundColor:[UIColor clearColor]];
            
            //        shareButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 10, 40, 40)];
        } else {
            if (isFree) {
                textScroll = [[TextScrollView alloc]initWithFrame:CGRectMake(354, 10, 253, 275)];
              
                imgWords = [[UITextView alloc] initWithFrame:CGRectMake(15, 160, 290, 130)];
                songList = [[UITableView alloc] initWithFrame:CGRectMake(140, 350, 180, 0)];
                [myScroll setContentSize:CGSizeMake(640, 300)];
                [myScroll setFrame:CGRectMake(0, 66, 320, 300)];

            } else {
                textScroll = [[TextScrollView alloc]initWithFrame:CGRectMake(354, 10, 253, 325)];
                imgWords = [[UITextView alloc] initWithFrame:CGRectMake(15, 160, 290, 180)];
                songList = [[UITableView alloc] initWithFrame:CGRectMake(140, 400, 180, 0)];
                [playerView setFrame:CGRectMake(0, 400, 320, 60)];
                [myScroll setContentSize:CGSizeMake(640, 350)];
                [pageControl setFrame:CGRectMake(141, 375, 31, 36)];
                [myScroll setFrame:CGRectMake(0, 66, 320, 350)];

            }
            myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 25, 120, 120)];
            myImageFrame = [[UIImageView alloc]initWithFrame:CGRectMake(75, 20, 130, 130)];
            [imgWords setFont:CourierOne];
            collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [collectButton setImage:[UIImage imageNamed:@"PcollectPressedBBC.png"] forState:UIControlStateNormal];
            [collectButton setFrame:CGRectMake(240, 100, 40, 40)];
            [collectButton addTarget:self action:@selector(collectButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            downloadFlg = [UIButton buttonWithType:UIButtonTypeCustom];
            [downloadFlg setImage:[UIImage imageNamed:@"downloadedBBC.png"] forState:UIControlStateNormal];
            [downloadFlg setFrame:CGRectMake(240, 100, 40, 40)];
            //        downloadingFlg  = [[UIButton alloc]init];
            downloadingFlg = [UIButton buttonWithType:UIButtonTypeCustom];
            [downloadingFlg setImage:[UIImage imageNamed:@"downloadingBBC.png"] forState:UIControlStateNormal];
            //        [downloadingFlg.titleLabel setTextColor:[UIColor whiteColor]];
            [downloadingFlg setFrame:CGRectMake(240, 100, 40, 40)];
            
            clockButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [clockButton setImage:[UIImage imageNamed:@"clockBBC.png"] forState:UIControlStateNormal];
            [clockButton setFrame:CGRectMake(240, 35, 35, 35)];
            [clockButton addTarget:self action:@selector(showFix:) forControlEvents:UIControlEventTouchUpInside];
            [clockButton setBackgroundColor:[UIColor clearColor]];
//        shareButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 10, 40, 40)];
        }
       
    }else {
        if (isFree) {
            textScroll = [[TextScrollView alloc]initWithFrame:CGRectMake(808, 15, 688, 690)];
            myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(284, 50, 200, 200)];
            myImageFrame = [[UIImageView alloc]initWithFrame:CGRectMake(274,40 , 220, 220)];
            imgWords = [[UITextView alloc] initWithFrame:CGRectMake(140, 330, 488, 400)];
            songList = [[UITableView alloc] initWithFrame:CGRectMake(468, 835, 300, 0)];
            [playerView setFrame:CGRectMake(0, 835, 768,79 )];
            [myScroll setContentSize:CGSizeMake(1536, 740)];
            [myScroll setFrame:CGRectMake(0, 94, 768, 740)];
            [pageControl setFrame:CGRectMake(353, 782, 60, 36)];

        } else {
            textScroll = [[TextScrollView alloc]initWithFrame:CGRectMake(808, 15, 688, 790)];
            myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(284, 50, 200, 200)];
            myImageFrame = [[UIImageView alloc]initWithFrame:CGRectMake(274,40 , 220, 220)];
            imgWords = [[UITextView alloc] initWithFrame:CGRectMake(140, 330, 488, 490)];
            songList = [[UITableView alloc] initWithFrame:CGRectMake(468, 925, 300, 0)];
            [myScroll setContentSize:CGSizeMake(1536, 830)];
            [playerView setFrame:CGRectMake(0, 925, 768,79 )];
            [myScroll setFrame:CGRectMake(0, 94, 768, 830)];
            [pageControl setFrame:CGRectMake(353, 882, 60, 36)];
        }
        [imgWords setFont:CourierTwo];
        
        collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [collectButton setImage:[UIImage imageNamed:@"PcollectPressedBBCP.png"] forState:UIControlStateNormal];
        [collectButton setFrame:CGRectMake(284, 270, 40, 40)];
        [collectButton addTarget:self action:@selector(collectButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        downloadFlg = [UIButton buttonWithType:UIButtonTypeCustom];
        [downloadFlg setImage:[UIImage imageNamed:@"downloadedBBCP.png"] forState:UIControlStateNormal];
        [downloadFlg setFrame:CGRectMake(284, 270, 40, 40)];
        //        downloadingFlg  = [[UIButton alloc]init];
        downloadingFlg = [UIButton buttonWithType:UIButtonTypeCustom];
        [downloadingFlg setImage:[UIImage imageNamed:@"downloadingBBCP.png"] forState:UIControlStateNormal];
        //        [downloadingFlg.titleLabel setTextColor:[UIColor whiteColor]];
        [downloadingFlg setFrame:CGRectMake(284, 270, 40, 40)];
        
        clockButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [clockButton setImage:[UIImage imageNamed:@"clockBBCP.png"] forState:UIControlStateNormal];
        [clockButton setFrame:CGRectMake(443, 269, 42, 42)];
        [clockButton addTarget:self action:@selector(showFix:) forControlEvents:UIControlEventTouchUpInside];
        [clockButton setBackgroundColor:[UIColor clearColor]];
        

           }
    [songList setDataSource:self];
    [songList setDelegate:self];
    [songList setBackgroundColor:[UIColor colorWithRed:240.0/255 green:245.0/255 blue:1 alpha:1]];
    [songList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [imgWords setBackgroundColor:[UIColor clearColor]];
    [imgWords setEditable:NO];
    textScroll.showsVerticalScrollIndicator = NO;
    [textScroll setBackgroundColor:[UIColor clearColor]];
    [myScroll addSubview:myImageView];
    [myScroll addSubview:myImageFrame];
    [myScroll addSubview:imgWords];
    [imgWords setTextAlignment:UITextAlignmentLeft];
    [myScroll addSubview:textScroll];
    [myScroll addSubview:collectButton];
    [myScroll addSubview:downloadFlg];
    [myScroll addSubview:downloadingFlg];
    [myScroll addSubview:clockButton];
    if (isiPhone) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"pause" ofType:@"png"];
        playImage = [[UIImage alloc] initWithContentsOfFile:path];
        path = [[NSBundle mainBundle] pathForResource:@"play" ofType:@"png"];
        pauseImage = [[UIImage alloc] initWithContentsOfFile:path];
        path = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"png"];
        loadingImage = [[UIImage alloc] initWithContentsOfFile:path];
        path = [[NSBundle mainBundle] pathForResource:@"seqMode" ofType:@"png"];
        shunxuImage =[[UIImage alloc] initWithContentsOfFile:path];
        path = [[NSBundle mainBundle] pathForResource:@"cycMode" ofType:@"png"];
        xunhuanImage =[[UIImage alloc] initWithContentsOfFile:path];
        path = [[NSBundle mainBundle] pathForResource:@"sinMode" ofType:@"png"];
        danquImage =[[UIImage alloc] initWithContentsOfFile:path];
        path = [[NSBundle mainBundle] pathForResource:@"ranMode" ofType:@"png"];
        suijiImage =[[UIImage alloc] initWithContentsOfFile:path];
    } else {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"pause-iPad" ofType:@"png"];
        playImage = [[UIImage alloc] initWithContentsOfFile:path];
        path = [[NSBundle mainBundle] pathForResource:@"play-iPad" ofType:@"png"];
        pauseImage = [[UIImage alloc] initWithContentsOfFile:path];
        path = [[NSBundle mainBundle] pathForResource:@"loading-iPad" ofType:@"png"];
        loadingImage = [[UIImage alloc] initWithContentsOfFile:path];
        path = [[NSBundle mainBundle] pathForResource:@"seqMode-iPad" ofType:@"png"];
        shunxuImage =[[UIImage alloc] initWithContentsOfFile:path];
        path = [[NSBundle mainBundle] pathForResource:@"cycMode-iPad" ofType:@"png"];
        xunhuanImage =[[UIImage alloc] initWithContentsOfFile:path];
        path = [[NSBundle mainBundle] pathForResource:@"sinMode-iPad" ofType:@"png"];
        danquImage =[[UIImage alloc] initWithContentsOfFile:path];
        path = [[NSBundle mainBundle] pathForResource:@"ranMode-iPad" ofType:@"png"];
        suijiImage =[[UIImage alloc] initWithContentsOfFile:path];
    }
    selectWord = [[NSString alloc]init];
    myWord = [[MusicWord alloc]init];
    userPath = [[NSString alloc] init];
    mp3Data = [[NSMutableData alloc] initWithLength:0];
    lyricArray = [[NSMutableArray alloc] init];//释放
	timeArray = [[NSMutableArray alloc] init];//释放
	indexArray = [[NSMutableArray alloc] init];//释放
    wordTouches = [[NSSet alloc] init];
    
    NSArray *myHrsArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23", nil];
    self.hoursArray = myHrsArray;
    [myHrsArray release];
    
    NSArray *myMesArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",nil];
    self.minsArray = myMesArray;
    [myMesArray release];
    
    NSArray *mySesArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",nil];
    self.secsArray = mySesArray;
    [mySesArray release];

    
//    musicsArray = [[NSMutableArray alloc] init];//$$$$$$$
    explainView = [[MyLabel alloc]init];
    explainView.tag = 2000;
    explainView.delegate = self;
    if (isiPhone) {
        if (IS_IPHONE_5) {
            [explainView setFrame:CGRectMake(0,(isFree?293+88:343+88), 320, 58)];
        } else {
            [explainView setFrame:CGRectMake(0,(isFree?293:343), 320, 58)];
        }
    
    }else {
        [explainView setFrame:CGRectMake(0,(isFree?719:819), 768, 116)];
    }
//    explainView.layer.cornerRadius = 10.0;
    [explainView setBackgroundColor:[UIColor clearColor]];
    wordFrame = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, explainView.frame.size.width, explainView.frame.size.height)];
    if (isiPhone) {
        [wordFrame setImage:[UIImage imageNamed:@"addWordBg.png"]];

    } else {
        [wordFrame setImage:[UIImage imageNamed:@"addWordBg@2x.png"]];

    }
    [explainView addSubview:wordFrame];
    [explainView setHidden:YES];
    [self.view addSubview:explainView];
    myHighLightWord = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    [myHighLightWord setHidden:YES];
    [myHighLightWord setTag:1000];
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"playMode"]) {
        case 1:
            [playModeButton setImage:shunxuImage forState:0];
            break;
        case 2:
            [playModeButton setImage:xunhuanImage forState:0];        
            break;
        case 3:
            [playModeButton setImage:danquImage forState:0];   
            break;
        case 4:
            [playModeButton setImage:suijiImage forState:0];
            break;
        default:
            break;
    }
    // Create a view of the standard size at the bottom of the screen.
    if (isFree) {
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (isiPhone) {
                    if (IS_IPHONE_5) {
                        bannerView_ = [[GADBannerView alloc]
                                       initWithFrame:CGRectMake(0.0,
                                                                self.view.frame.size.height -
                                                                GAD_SIZE_320x50.height,
                                                                GAD_SIZE_320x50.width,
                                                                GAD_SIZE_320x50.height)];
                        
                    } else {
                        bannerView_ = [[GADBannerView alloc]
                                       initWithFrame:CGRectMake(0.0,
                                                                self.view.frame.size.height -
                                                                GAD_SIZE_320x50.height,
                                                                GAD_SIZE_320x50.width,
                                                                GAD_SIZE_320x50.height)];
                        
                    }
                    
                }else{
                    bannerView_ = [[GADBannerView alloc]
                                   initWithFrame:CGRectMake(20.0,
                                                            self.view.frame.size.height -
                                                            GAD_SIZE_728x90.height,
                                                            GAD_SIZE_728x90.width,
                                                            GAD_SIZE_728x90.height)];
                }
                // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
                bannerView_.adUnitID = @"a150373754a247b";
                
                // Let the runtime know which UIViewController to restore after taking
                // the user wherever the ad goes and add it to the view hierarchy.
                bannerView_.rootViewController = self;
                [bannerView_ setDelegate:self];
                [self.view addSubview:bannerView_];
                
                
                // Initiate a generic request to load it with an ad.
                [bannerView_ loadRequest:[GADRequest request]];
                [bannerView_ setBackgroundColor:[UIColor clearColor]];
                //        kNetTest;
                if (!kNetIsExist) {
                    needFlushAdv = YES;
                }
                [bannerView_ setHidden:NO];
            });
        });
    }
    //    
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];//开启接受外部控制音频播放
    
//    backButton=[[UIButton alloc]init];
//    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setImage:[UIImage imageWithContentsOfFile:
//								[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"return"] ofType:@"png"]] 
//					  forState:UIControlStateNormal];
//	backButton.titleLabel.font=[UIFont systemFontOfSize:12];
//    [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    backButton.frame = CGRectMake(5, 5, 35, 40);
//    [self.view addSubview:backButton];
    [self.view addSubview:songList];
    [songList release];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    //有关外部控制音频播放
}

/**
 * 外部控制音频播放所需重置
 */
- (BOOL)canBecomeFirstResponder  
{
    return YES;  
} 

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    //    NSLog(@"aaaa");
	[collectButton release];
    [textScroll release];
    [pageControl release];
	[totalTimeLabel release];
	[currentTimeLabel release];
	[timeSlider release];
	[playButton release];
	[downloadFlg release];
    [downloadingFlg release];
	[titleWords release];
    [playModeButton release];
//    [backButton release];
    [music release];
    [myImageView release];
    [lyricImage release];
    [wordFrame release];
    
    [switchBtn release];
    [timeSwitch release];
    [sliderTimer release];
    [lyricSynTimer release];
    
    [updateTimer release];
    [lyricArray release];
    [timeArray release];
    
    [indexArray release];
    [lyricLabelArray release];
    //    [localPlayer release];
    
    [player release];
    [wordPlayer release];
    [myHighLightWord release];
    [myView release];
    
    [mp3Data release];
    [userPath release];
    [explainView release];
    [myWord release];
    
//    [HUD release];
    [viewOne release];
    [viewTwo release];
    [myScroll release];
    
    [imgWords release];
    [playImage release];
    [pauseImage release];
    [loadingImage release];
    [alert release];
    [myCenter release];
    [shunxuImage release];
    [danquImage release];
    [xunhuanImage release];
    [suijiImage release];
    [bannerView_ release];
    [playModeLabel release];
    [super dealloc];
}

#pragma mark - GADBannerViewDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    needFlushAdv = NO;
}

- (void)adView:(GADBannerView *)bannerView
didFailToReceiveAdWithError:(GADRequestError *)error {
    needFlushAdv = YES;
    //    NSLog(@"adView:didFailToReceiveAdWithError:%@", [error localizedDescription]);
}

#pragma mark - Http connect
- (void)QueueDownloadMusic
{
       // NSLog(@"Queue 预备: %d",music._iid);
    NSOperationQueue *myQueue = [PlayViewController sharedQueue];
    [myQueue setMaxConcurrentOperationCount:1];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://static2.iyuba.com/go/musichigh/%@", music._audio]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setTag:music._iid];
    [request setDidStartSelector:@selector(requestSoundStarted:)];
    [request setDidFinishSelector:@selector(requestSoundDone:)];
    [request setDidFailSelector:@selector(requestSoundWentWrong:)];
    [myQueue addOperation:request]; //queue is an NSOperationQueue
    
    [MusicView alterDownload:request.tag];
    [downLoadList addObject:[NSNumber numberWithInt:request.tag]];
    
    if (request.tag == music._iid) {
        [downloadFlg setHidden:YES];
        [collectButton setHidden:YES];
        [downloadingFlg setHidden:NO];
    }

}

- (void)requestSoundStarted:(ASIHTTPRequest *)request
{
    nowrequest = request;
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    //创建audio份目录在Documents文件夹下，not to back up
	NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];
    MusicView *nowmusic=[MusicView find:request.tag];
    userPath = [audioPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", nowmusic._audio]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:userPath]) {
        [request cancel];
    }
   
    
    if (request.tag == music._iid) {
        [downloadFlg setHidden:YES];
        [collectButton setHidden:YES];
        [downloadingFlg setHidden:NO];
    }
    
      // NSLog(@"Queue 开始: %d",request.tag);
}
   

- (void)requestSoundDone:(ASIHTTPRequest *)request{
    kNetEnable;
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    //创建audio份目录在Documents文件夹下，not to back up
	NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];
	NSFileManager *fm = [NSFileManager defaultManager];
    MusicView *nowmusic=[MusicView find:request.tag];
    userPath = [audioPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", nowmusic._audio]];
    NSData *responseData = [request responseData]; 
    //    NSLog(@"requestFinished。大小：%d", [responseData length]);
	if ([fm createFileAtPath:userPath contents:responseData attributes:nil]) {
	}
    if (request.tag == music._iid) {
        localFileExist = YES;
        downloaded = YES;
        [downloadFlg setHidden:NO];
        [collectButton setHidden:YES];
        [downloadingFlg setHidden:YES];
    }
   // MusicView *nowmusic=[MusicView find:request.tag];
    
    [MusicFav alterCollect:request.tag  icid:nowmusic._icid];
	[fm release];
    [MusicView clearDownload:request.tag];
    for (int i =0; i<[downLoadList count]; i++) {
        if ([[downLoadList objectAtIndex:i]intValue]==request.tag) {
            [downLoadList removeObjectAtIndex:i];
            break;
        }
    }
//    [myDelegate afterDownload];
}

- (void)requestSoundWentWrong:(ASIHTTPRequest *)request
{
    kNetTest;
    [MusicView clearDownload:request.tag];
    for (int i =0; i<[downLoadList count]; i++) {
        if ([[downLoadList objectAtIndex:i]intValue]==request.tag) {
            [downLoadList removeObjectAtIndex:i];
            break;
        }
    }

    MusicView *nowmusic=[MusicView find:request.tag];
    UIAlertView *netAlert = [[UIAlertView alloc] initWithTitle:kPlayFive message:[NSString stringWithFormat:@"%@%@", nowmusic._audio,kPlayFive] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    if (request.tag == music._iid) {
        [collectButton setHidden:NO];
        [downloadingFlg setHidden:YES];
    }
   
    [netAlert show];
    [netAlert release];
}

//- (void)catchNetA
//{
//    NSString *url = @"http://www.baidu.com";
//    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    request.delegate = self;
//    [request setUsername:@"catchnet"];
//    [request startAsynchronous];
//    request = nil;
//    [request release];
//}


- (void)catchWords:(NSString *) word
{
    NSString *url = [NSString stringWithFormat:@"http://word.iyuba.com/words/apiWord.jsp?q=%@",word];
    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    request.delegate = self;
    [request setUsername:word];
    [request startAsynchronous];
   
    [request release],request = nil;
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    kNetTest;
    if ([request.username isEqualToString:@"catchnet"]) {
        //        NSLog(@"有网络");
        isExistNet = NO;
        [self isExistenceNetwork:1];
        return;
    }
    [myWord init];
    myWord.wordId = [MusicWord findLastId]+1;
    myWord.checks = 0;
    myWord.remember = 0;
    myWord.key = request.username;
    myWord.audio = @"";
    myWord.pron = @" ";
    myWord.def = @"";
    myWord.userId = nowUserId;
    for (UIView *sView in [explainView subviews]) {
        if (![sView isKindOfClass:[UIImageView class]]) {
            [sView removeFromSuperview];
        }
    }
    UIFont *Courier = [UIFont fontWithName:@"Courier" size:14];
    UIFont *CourierTwo = [UIFont fontWithName:@"Arial" size:12];
    UIFont *CourierP = [UIFont fontWithName:@"Courier" size:16];
    UIFont *CourierTwoP = [UIFont fontWithName:@"Arial" size:14];
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    
    [addButton addTarget:self action:@selector(addWordPressed:) forControlEvents:UIControlEventTouchUpInside];
    if (isiPhone) {
        [addButton setImage:[UIImage imageNamed:@"addWord.png"] forState:UIControlStateNormal];
        [addButton setFrame:CGRectMake(280, 13, 33, 33)];

    } else {
        [addButton setImage:[UIImage imageNamed:@"addWord@2x.png"] forState:UIControlStateNormal];
        [addButton setFrame:CGRectMake(688, 24,66, 66)];

    }
        [explainView addSubview:addButton];
    
    UILabel *wordLabel = [[UILabel alloc]init];
    if (isiPhone) {
        [wordLabel setFont :Courier];

        [wordLabel setFrame:CGRectMake(5, 5, [myWord.key sizeWithFont:Courier].width+10, 20)];
    } else {
        [wordLabel setFont :CourierP];

        [wordLabel setFrame:CGRectMake(10,10, [myWord.key sizeWithFont:CourierP].width+20, 30)];
    }
    
    [wordLabel setTextAlignment:UITextAlignmentCenter];
    wordLabel.text = myWord.key;
    wordLabel.textColor = [UIColor whiteColor];
    wordLabel.backgroundColor = [UIColor clearColor];
    [explainView addSubview:wordLabel];
    [wordLabel release];
    
    UILabel *defLabel = [[UILabel alloc]init];
    if (isiPhone) {
        [defLabel setFont :CourierTwo];
        [defLabel  setFrame:CGRectMake(5, 22, 275, 30)];
    } else {
        [defLabel setFont :CourierTwoP];
        [defLabel  setFrame:CGRectMake(10, 44, 670, 60)];
    }
    
    
    defLabel.backgroundColor = [UIColor clearColor];
    defLabel.textColor = [UIColor whiteColor];
    [defLabel setLineBreakMode:UILineBreakModeWordWrap];
    [defLabel setNumberOfLines:1];
    
    defLabel.text = kPlaySix;
    //    NSLog(@"未联网无法查看释义!");
    
    [explainView addSubview:defLabel];
    [defLabel release];
    [explainView setAlpha:1];
    
    [explainView setHidden:NO];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    kNetEnable;
    if ([request.username isEqualToString:@"catchnet"]) {
        //        NSLog(@"有网络");
        isExistNet = YES;
        return;
    }
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];;
    //[myWord init];
    int result = 0;
    NSArray *items = [doc nodesForXPath:@"data" error:nil];
    if (items) {
        for (DDXMLElement *obj in items) {
            myWord.wordId = [MusicWord findLastId]+1;
            myWord.checks = 0;
            myWord.remember = 0;
            myWord.userId = nowUserId;
            result = [[obj elementForName:@"result"] stringValue].intValue;
            if (result) {
                myWord.key = [[obj elementForName:@"key"] stringValue];
                myWord.audio = [[obj elementForName:@"audio"] stringValue];
                myWord.pron = [[obj elementForName:@"pron"] stringValue];
                if (myWord.pron == nil) {
                    myWord.pron = @" ";
                }
                myWord.def = [[[[obj elementForName:@"def"] stringValue] stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
                [self wordExistDisplay];
//                for (UIView *sView in [explainView subviews]) {
//                    if (![sView isKindOfClass:[UIImageView class]]) {
//                        [sView removeFromSuperview];
//                    }
//                }
//                
//                UIFont *Courier = [UIFont fontWithName:@"Arial" size:14];
//                UIFont *CourierTwo = [UIFont fontWithName:@"Arial" size:12];
//                UIFont *CourierP = [UIFont fontWithName:@"Courier" size:16];
//                UIFont *CourierTwoP = [UIFont fontWithName:@"Arial" size:14];
//
//                UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
//                
//                [addButton addTarget:self action:@selector(addWordPressed:) forControlEvents:UIControlEventTouchUpInside];
//               
//                if (isiPhone) {
//                    [addButton setImage:[UIImage imageNamed:@"addWord.png"] forState:UIControlStateNormal];
//                    [addButton setFrame:CGRectMake(280, 13, 33, 33)];
//                    
//                } else {
//                    [addButton setImage:[UIImage imageNamed:@"addWord@2x.png"] forState:UIControlStateNormal];
//                    [addButton setFrame:CGRectMake(688, 24,66, 66)];
//                    
//                }
//                [explainView addSubview:addButton];
//               // 
//                UILabel *wordLabel = [[UILabel alloc]init];
//                if (isiPhone) {
//                    [wordLabel setFont :Courier];
//                    
//                    [wordLabel setFrame:CGRectMake(5, 5, [myWord.key sizeWithFont:Courier].width+10, 20)];
//                } else {
//                    [wordLabel setFont :CourierP];
//                    
//                    [wordLabel setFrame:CGRectMake(10,10, [myWord.key sizeWithFont:CourierP].width+20, 30)];
//                }
//                wordLabel.textColor = [UIColor whiteColor];
//                [wordLabel setTextAlignment:UITextAlignmentCenter];
//                wordLabel.text = myWord.key;
//                wordLabel.backgroundColor = [UIColor clearColor];
//                [explainView addSubview:wordLabel];
//                
//                UILabel *pronLabel = [[UILabel alloc]init];
//                if (isiPhone) {
//                    [pronLabel setFrame:CGRectMake(15+[myWord.key sizeWithFont:Courier].width, 5, [[NSString stringWithFormat:@"[%@]", myWord.pron] sizeWithFont:Courier].width+10, 20)];
//                    [pronLabel setFont :CourierTwo];
//                } else {
//                    [pronLabel setFrame:CGRectMake(35+[myWord.key sizeWithFont:CourierP].width,10, [[NSString stringWithFormat:@"[%@]", myWord.pron] sizeWithFont:CourierTwoP].width+20, 30)];
//                    [pronLabel setFont :CourierTwoP];
//                }
//               
//                pronLabel.textColor = [UIColor whiteColor];
//                [pronLabel setTextAlignment:UITextAlignmentLeft];
//                if ([myWord.pron isEqualToString:@" "]) {
//                    pronLabel.text = @"";
//                }else
//            {
//                   pronLabel.text = [NSString stringWithFormat:@"[%@]", myWord.pron];
//                }
//                pronLabel.backgroundColor = [UIColor clearColor];
//                [explainView addSubview:pronLabel];
//                
//                if (wordPlayer) {
//                    [wordPlayer release];
//               }
//               wordPlayer =[[AVPlayer alloc]initWithURL:[NSURL URLWithString:myWord.audio]];
//                [wordPlayer play];
//                
//                UIButton *audioButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
//                if (isiPhone) {
//                    [audioButton setImage:[UIImage imageNamed:@"wordSound.png"] forState:UIControlStateNormal];
//                    [audioButton setFrame:CGRectMake(25+[myWord.key sizeWithFont:Courier].width + [[NSString stringWithFormat:@"[%@]", myWord.pron] sizeWithFont:Courier].width, 5, 20, 20)];
//                } else {
//                    [audioButton setImage:[UIImage imageNamed:@"wordSound@2x.png"] forState:UIControlStateNormal];
//                    [audioButton setFrame:CGRectMake(55+[myWord.key sizeWithFont:Courier].width + [[NSString stringWithFormat:@"[%@]", myWord.pron] sizeWithFont:CourierP].width,10, 30, 30)];
//                }
//                
//                [audioButton addTarget:self action:@selector(playWord:) forControlEvents:UIControlEventTouchUpInside];
//                
//                [explainView addSubview:audioButton];
//                
//                UITextView *defTextView = [[UITextView alloc] init];
//                if (isiPhone) {
//                    [defTextView  setFrame:CGRectMake(0, 22,275, 30)];
//                    [defTextView setFont :CourierTwo];
//                } else {
//                    [defTextView  setFrame:CGRectMake(0, 44,670, 60)];
//                    [defTextView setFont :CourierTwoP];
//                }
//                
//                if ([myWord.def isEqualToString:@" "]) {
//                    defTextView.text = kPlaySeven;
//                    //                    NSLog(@"未联网无法查看释义!");             
//                }else{
//                    defTextView.text = myWord.def;
//               }
//                [defTextView setEditable:NO];
//                
//                defTextView.textColor = [UIColor whiteColor];
//                defTextView.backgroundColor = [UIColor clearColor];
//                [explainView addSubview:defTextView];         
//                [explainView setAlpha:1];
//               [explainView setHidden:NO];
                
            }else
            {
                myWord.key = request.username;
                myWord.audio = @"";
                myWord.pron = @" ";
                myWord.def = @"";
                [self wordNoDisplay];
//                for (UIView *sView in [explainView subviews]) {
//                    if (![sView isKindOfClass:[UIImageView class]]) {
//                        [sView removeFromSuperview];
//                    }
//                }
//                UIFont *Courier = [UIFont fontWithName:@"Arial" size:14];
//                UIFont *CourierTwo = [UIFont fontWithName:@"Arial" size:12];
//                UIFont *CourierP = [UIFont fontWithName:@"Courier" size:16];
//                UIFont *CourierTwoP = [UIFont fontWithName:@"Arial" size:14];
//                
//
//                UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
//                
//                [addButton addTarget:self action:@selector(addWordPressed:) forControlEvents:UIControlEventTouchUpInside];
//                if (isiPhone) {
//                    [addButton setImage:[UIImage imageNamed:@"addWord.png"] forState:UIControlStateNormal];
//                    [addButton setFrame:CGRectMake(280, 13, 33, 33)];
//                    
//                } else {
//                    [addButton setImage:[UIImage imageNamed:@"addWord@2x.png"] forState:UIControlStateNormal];
//                    [addButton setFrame:CGRectMake(688, 24,66, 66)];
//                    
//                }
//                [explainView addSubview:addButton];
//                
//                UILabel *wordLabel = [[UILabel alloc]init];
//                if (isiPhone) {
//                    [wordLabel setFont :Courier];
//                    
//                    [wordLabel setFrame:CGRectMake(5, 5, [myWord.key sizeWithFont:Courier].width+10, 20)];
//                } else {
//                    [wordLabel setFont :CourierP];
//                    
//                    [wordLabel setFrame:CGRectMake(10,10, [myWord.key sizeWithFont:CourierP].width+20, 30)];
//                }
//
//               [wordLabel setTextAlignment:UITextAlignmentCenter];
//                wordLabel.text = myWord.key;
//                wordLabel.backgroundColor = [UIColor clearColor];
//                wordLabel.textColor = [UIColor whiteColor];
//               [explainView addSubview:wordLabel];
//                
//                UILabel *defLabel = [[UILabel alloc]init];
//                if (isiPhone) {
//                    [defLabel setFont :CourierTwo];
//                    [defLabel  setFrame:CGRectMake(5, 22, 275, 30)];
//                } else {
//                    [defLabel setFont :CourierTwoP];
//                    [defLabel  setFrame:CGRectMake(10, 44, 670, 60)];
//                }
//                
//
//               defLabel.backgroundColor = [UIColor clearColor];
//                [defLabel setLineBreakMode:UILineBreakModeWordWrap];
//               [defLabel setNumberOfLines:1];
//                defLabel.textColor = [UIColor whiteColor];
//                defLabel.text = kWordEight;
////                                NSLog(@"无查找结果!");
//               [explainView addSubview:defLabel];
//               
//               [explainView setAlpha:1];
//            [explainView setHidden:NO]; 
            }
        }
    }
    [doc release];
    request.delegate = nil;
}

#pragma Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];

    if (fixTimeView.alpha > 0.5) {
        [UIView beginAnimations:@"Switch" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:.5];
        [fixTimeView setAlpha:0];
        [UIView commitAnimations];
    }

    if (![explainView isHidden]) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
    }else
    {
        if (switchFlg) {
            self.switchFlg = NO;
            [switchBtn setTitle:@"开" forState:UIControlStateNormal] ;
            for (UIView *hideView in textScroll.subviews) {
                if (hideView.tag < 200) {
                    [hideView setHidden:YES]; 
                }
            }
        }else{
            self.switchFlg = YES;
            [switchBtn setTitle:@"关" forState:UIControlStateNormal] ;
            for (UIView *hideView in textScroll.subviews) {
                if (hideView.tag < 200) {
                    [hideView setHidden:NO]; 
                }
            }
        }
        
    }
}

#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    [HUD release];
	HUD = nil;
}

#pragma mark - Background Player Control
/**
 * 接受外部音频控制
 */
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {  

    if (event.type == UIEventTypeRemoteControl) {  
        switch (event.subtype) {  
                
            case UIEventSubtypeRemoteControlTogglePlayPause:  
                [self playButtonPressed:playButton];  
                break;  
                
            case UIEventSubtypeRemoteControlPreviousTrack:  
                [self prePlay:preButton];  
                break;  
                
            case UIEventSubtypeRemoteControlNextTrack:  
                [self aftPlay:nextButton];  
                break;  
                
            default:  
                break;  
        }  
    } 
    
}

#pragma mark - MyLabelDelegate
- (void)touchUpInside: (NSSet *)touches mylabel:(MyLabel *)mylabel {
    if (mylabel.tag == 2000) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
        return;
    }
    if (![explainView isHidden]) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
    }
//    
//    NSString * WordIFind = nil;
//    UITouch *touch=[touches anyObject];
//    CGPoint point = [touch locationInView:mylabel];
//    int lineHeight = [@"a" sizeWithFont:mylabel.font].height;
//    int LineStartlocation = 0;
//    //    int numberoflines = self.frame.size.height / lineHeight;
//    int tagetline = ceilf(point.y/lineHeight);
//    NSLog(@"tagetline:%d",tagetline);
//    if (tagetline==0) {
//        return;
//    }
//    int WordIndex = 0;
//    BOOL WordFound = NO;
//    NSString * string = @"";
//    NSString * string2 = @"";
//    NSString * string3 = @"";
//    CGSize maxSize = CGSizeMake(textScroll.frame.size.width, CGFLOAT_MAX);
//    
//    for (int i = 0; i <[mylabel.text length]  && !WordFound; i++) {
//        string = [mylabel.text substringToIndex:i];
//        NSLog(@"string:%@",string);
//        CGSize mysize = CGSizeZero;
//        @try {
//            //            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@.",[splitStr objectAtIndex:i]]];
//            
//            //            NSString * substr = [self.text substringWithRange:NSMakeRange(LineStartlocation, i == count - 1 ? [string length]-1:[string length])];
//            NSString * substr = [mylabel.text substringWithRange:NSMakeRange(LineStartlocation, [string length])];
//            mysize = [substr sizeWithFont:mylabel.font constrainedToSize:maxSize lineBreakMode:mylabel.lineBreakMode];
//            NSLog(@"substr:%@",substr);
//        }
//        @catch (NSException *exception) {
//            //[SevenLabel RemoveBackground];
//            continue;
//        }
//        if (mysize.height/lineHeight == tagetline && !WordFound) {
//        NSString *currentChar =[mylabel.text substringWithRange:NSMakeRange(i-1,1)];
//            
//            NSLog(@"%@",currentChar);
//            NSString *preChar=currentChar; int preIndex=i-2;
//            if ([currentChar isMatchedByRegex:@"[a-zA-Z]"]&&tagetline!=1)
//            {
//                while ([preChar isMatchedByRegex:@"[a-zA-Z《]"] &&preIndex>=0) {
//                    preChar=[mylabel.text substringWithRange:NSMakeRange(preIndex,1)];
//                    preIndex--;
//                    NSLog(@"preindex:%d,preChar:%@",preIndex,preChar);
//                }
//                string=[mylabel.text substringToIndex:preIndex+3];
//                i=preIndex+2;
//                NSLog(@"修正string:%@",string);
//            }
//            if ([currentChar isMatchedByRegex:@"[,.，。]"]&&tagetline!=1) {
//                preChar=[mylabel.text substringWithRange:NSMakeRange(preIndex, 1)];
//                NSLog(@"prechar::%@",preChar);
//                if ([preChar isMatchedByRegex:@"[a-zA-Z》]"]) {
//                    while ([preChar isMatchedByRegex:@"[a-zA-Z》]"] &&preIndex>=0) {
//                        preChar=[mylabel.text substringWithRange:NSMakeRange(preIndex,1)];
//                        preIndex--;
//                        NSLog(@"preindex:%d,preChar:%@",preIndex,preChar);
//                    }
//                    string=[mylabel.text substringToIndex:preIndex+3];
//                    i=preIndex+2;
//                    NSLog(@"修正string:%@",string);
//                        } else {
//                            string =[mylabel.text substringToIndex:preIndex];
//                            i=preIndex-1;
//                            NSLog(@"else修正string：%@",string);
//                                }
//            }
//            LineStartlocation = [string length] - 1;
//            NSLog(@"linestart:%d",LineStartlocation);
//            for (; i <=[mylabel.text length]; i++) {
//                string3=[mylabel.text substringFromIndex:LineStartlocation];
//                NSLog(@"string3:%@",string3);
//                string2 = [string3 substringToIndex:i-LineStartlocation];
//                NSLog(@"string2:%@",string2);
//                NSString * substr2 = nil;
//                @try {
//                    currentChar=[mylabel.text substringWithRange:NSMakeRange(i-1, 1)];
//                    WordIndex = i-1;
//                    NSLog(@"currentChar2:%@",currentChar);
//                    NSString *aftChar=currentChar;int aftIndex=i-LineStartlocation;
//                    if ([currentChar isMatchedByRegex:@"[a-zA-Z]"])
//                    {
//                        while ([aftChar isMatchedByRegex:@"[a-zA-Z]"] &&aftIndex<[mylabel.text length]-LineStartlocation) {
//                            aftChar=[string3 substringWithRange:NSMakeRange(aftIndex,1)];
//                            aftIndex++;
//                            NSLog(@"aftIndex:%d,aftChar:%@",aftIndex,aftChar);
//                        }
//                        string2=[string3 substringToIndex:aftIndex];
//                        NSLog(@"修正string2:%@",string2);
//                    }
//
//                    
//                    substr2 = [mylabel.text substringWithRange:NSMakeRange(LineStartlocation, [string2 length])];
//                    NSLog(@"substr2:%@",substr2);
//                    
//                    CGSize thissize = [substr2 sizeWithFont:mylabel.font constrainedToSize:maxSize lineBreakMode:mylabel.lineBreakMode];
//                    if (thissize.height/lineHeight > 1) {
//                        return;
//                    }
//                    
//                    if (thissize.width > point.x) {
//                        
//                        
//                        WordFound = YES;
//                        break;
//                    }
//                }
//                
//                
//                @catch (id exception) {
//                   // [SevenLabel RemoveBackground];
//                    if ([exception isKindOfClass:[NSException class]]) {
//                        NSLog(@"exception:%@",exception);
//                    }
//                    else {
//                        NSLog(@"unknown exception");
//                    }
//                    continue;
//                }
//            }
//        }
//        
//    }
//    if (WordFound) {
//        @try {
//            
//            NSString *currentChar =[mylabel.text substringWithRange:NSMakeRange(WordIndex,1)];
//            NSLog(@"wordFound:currentChar:%@",currentChar);
//            NSString *preChar=currentChar; int preIndex=WordIndex-1;
//            NSString *aftChar=currentChar; int aftIndex=WordIndex+1;
//            if ([currentChar isMatchedByRegex:@"[a-zA-Z]"])
//            {
//                    while ([preChar isMatchedByRegex:@"[a-zA-Z]"]&&preIndex>=0) {
//                    preChar=[mylabel.text substringWithRange:NSMakeRange(preIndex,1)];
//                    preIndex--;
//                    NSLog(@"preindex:%d,preChar:%@",preIndex,preChar);
//                             
//                }
//                while ([aftChar isMatchedByRegex:@"[a-zA-Z]"]&&aftIndex<=[mylabel.text length]-1) {
//                    aftChar=[mylabel.text substringWithRange:NSMakeRange(aftIndex,1)];
//                    aftIndex++;
//                    NSLog(@"aftindex:%d,aftChar:%@",aftIndex,aftChar);
//
//                }
//                if (preIndex>=0&&aftIndex<=[mylabel.text length]-1) {
//                    NSLog(@"1");
//                     WordIFind= [mylabel.text substringWithRange:NSMakeRange(preIndex+2,aftIndex-preIndex-3)];
//                }else if(preIndex<0&&[preChar isMatchedByRegex:@"[a-zA-Z]"]){
//                    NSLog(@"2");
//                     WordIFind= [mylabel.text substringWithRange:NSMakeRange(preIndex+1,aftIndex-preIndex-2)];
//                }else if(preIndex<0&&[preChar isMatchedByRegex:@"[a-zA-Z]"]==false)
//                {
//                    NSLog(@"3");
//                    WordIFind= [mylabel.text substringWithRange:NSMakeRange(preIndex+2,aftIndex-preIndex-3)];
//                }
//                else {
//                    NSLog(@"4");
//                     WordIFind= [mylabel.text substringWithRange:NSMakeRange(preIndex+2,aftIndex-preIndex-2 )];
//                }
//                NSLog(@"wordifind:%@",WordIFind);
//                
//            } else {
//                        NSLog(@"This is not English Words.");
//                        return;
//                            }            
//            CGFloat pointY = (tagetline -1 ) * lineHeight;
//            CGFloat width = [WordIFind sizeWithFont:mylabel.font].width;
//            NSString * str=nil;
//            CGFloat pointX;
//            if (preIndex !=-1) {
//            str = [string3 substringToIndex:preIndex-LineStartlocation+2];
//            }
//            else if (preIndex ==-1 &&[preChar isMatchedByRegex:@"[a-zA-Z]"]==FALSE) {
//                str = preChar;
//            }
//            pointX = [str sizeWithFont:mylabel.font].width; 
//                        
//            NSLog(@"str:%@",str);
            //            int i = 0;
            //            while ([[str substringToIndex:i] isEqual:@"."]) {
            //                str = [str substringFromIndex:i+1];
            //                i++;
            //                
            //            }
//            CGFloat pointX = [str sizeWithFont:mylabel.font].width;        //        if (wordBack) {
        //            [wordBack removeFromSuperview];
        //            wordBack = nil;
        //        }
    NSString * WordIFind = nil;
    UITouch *touch=[touches anyObject];
    CGPoint point = [touch locationInView:mylabel];
    int lineHeight = [@"a" sizeWithFont:mylabel.font].height;
    int LineStartlocation = 0;
      //    int numberoflines = self.frame.size.height / lineHeight;
    int tagetline = ceilf(point.y/lineHeight);    //    int numberoflines = self.frame.size.height / lineHeight;
    //    NSString * sepratorString = @", ，。.?!:\"“”-()'’‘";
    NSString * sepratorString = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    //    NSString * text = @"...idowrhu wpe gre dddd.. 'eow.ei, we u";
    NSCharacterSet * sepratorSet = [[NSCharacterSet characterSetWithCharactersInString:sepratorString] invertedSet];
    NSArray * splitStr = [mylabel.text componentsSeparatedByCharactersInSet:sepratorSet];
//    NSLog(@"%@",splitStr);
    int nullnum=0;
    for (int i=0; i<[splitStr count]; i++) {
        if ([[splitStr objectAtIndex:i]isEqualToString:@""]) {
            nullnum++;
        }
    }
//    NSLog(@"nullnum:%d",nullnum);
    if (nullnum>[splitStr count]/2) {
        return;
    }
    //    NSArray * splitStr = [self.text componentsMatchedByRegex:<#(NSString *)#>
    //    NSArray * splitStr = [self.text componentsSeparatedByString:@" "];
    int WordIndex = 0;
    int count = [splitStr count];
    BOOL WordFound = NO;
    NSString * string = @"";
    NSString * string2 = @"";
    CGSize maxSize = CGSizeMake(textScroll.frame.size.width, CGFLOAT_MAX);
    
    for (int i = 0; i < count && !WordFound; i++) {
        string = [string stringByAppendingString:[NSString stringWithFormat:@"%@.",[splitStr objectAtIndex:i]]];
        
        if (![[splitStr objectAtIndex:i] isMatchedByRegex:@"[a-zA-Z0-9]"]) {
//           NSLog(@"%@is not an English word",[splitStr objectAtIndex:i]);
//            continue;
        }
        CGSize mysize = CGSizeZero;
        @try {
            //            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@.",[splitStr objectAtIndex:i]]];
            
            //            NSString * substr = [self.text substringWithRange:NSMakeRange(LineStartlocation, i == count - 1 ? [string length]-1:[string length])];
            NSString * substr = [mylabel.text substringWithRange:NSMakeRange(LineStartlocation, [string length]-1)];
            mysize = [substr sizeWithFont:mylabel.font constrainedToSize:maxSize lineBreakMode:mylabel.lineBreakMode];
//            NSLog(@"string:%@。substr:%@",string,substr);
        }
        @catch (NSException *exception) {
            continue;
        }
        int  taget=mysize.height/lineHeight;
        if (taget==0) {
            taget=1;
        }
        if (taget == tagetline && !WordFound) {
            LineStartlocation = [string length] - [[splitStr objectAtIndex:i] length] -1;
//            if (tagetline!=1) {
//            if (![[mylabel.text substringWithRange:NSMakeRange(LineStartlocation-1, 1)] isMatchedByRegex:@", ，。.?!:\"“”-()'’‘"]) {
//                LineStartlocation--;
//            }
//            }
//            NSLog(@"string length:%d,splitstr length:%d,linestart:%d",[string length],[[splitStr objectAtIndex:i]length],LineStartlocation);
            for (; i < count; i++) {
                
                string2 = [string2 stringByAppendingString:[NSString stringWithFormat:@"%@.",[splitStr objectAtIndex:i]]];
//                NSLog(@"i:%i,linestart:%d,splitStr:%@,string:%@,string2:%@",i,LineStartlocation,[splitStr objectAtIndex:i],string,string2);
                NSString * substr2 = nil;
                @try {
                    //                    substr2 = [self.text substringWithRange:NSMakeRange(LineStartlocation, i == count - 1 ? [string2 length]-1:[string2 length])];
                    substr2 = [mylabel.text substringWithRange:NSMakeRange(LineStartlocation, [string2 length]-1)];
//                    NSLog(@"string2:%@,substr2:%@",string2,substr2);
                    
                    CGSize thissize = [substr2 sizeWithFont:mylabel.font constrainedToSize:maxSize lineBreakMode:mylabel.lineBreakMode];
                    if (thissize.height/lineHeight > 1) {
                        return;
                    }
                    
                    if (thissize.width > point.x) {
                        
                        WordIndex = i;
                        WordFound = YES;
                        break;
                    }
                }
                
                
                @catch (id exception) {
                    if ([exception isKindOfClass:[NSException class]]) {
//                        NSLog(@"exception:%@",exception);
                    }
                    else {
//                        NSLog(@"unknown exception");
                    }
                    continue;
                }
            }
        }
        
    }
    if (WordFound) {
        @try {
            
            WordIFind = [splitStr objectAtIndex:WordIndex];
            
            CGFloat pointY = (tagetline -1 ) * lineHeight;
            CGFloat width = [[splitStr objectAtIndex:WordIndex] sizeWithFont:mylabel.font].width;
            
            NSRange Range1 = [string2 rangeOfString:[splitStr objectAtIndex:WordIndex] options:NSBackwardsSearch];
//            NSLog(@"%@",string2);
            NSString * str = [[mylabel.text substringFromIndex:LineStartlocation ] substringToIndex:Range1.location];
            //            int i = 0;
            //            while ([[str substringToIndex:i] isEqual:@"."]) {
            //                str = [str substringFromIndex:i+1];
            //                i++;
            //                
            //            }
//            NSLog(@"str:%@",str);
            CGFloat pointX = [str sizeWithFont:mylabel.font].width;
            //            CGFloat pointX = [substr
            
            LocalWord *word = [LocalWord findByKey:WordIFind];
            myWord.wordId = [MusicWord findLastId] + 1;
            if ([[NSUserDefaults standardUserDefaults] boolForKey:kBePro] && word) {
//            if (word) {
                               //        if (word) {
                //            if (word) {
                //            myWord.wordId = [VOAWord findLastId] + 1;
                myWord.key = word.key;
                myWord.audio = word.audio;
                myWord.pron = [NSString stringWithFormat:@"%@",word.pron] ;
                if (myWord.pron == nil) {
                    myWord.pron = @" ";
                }
                myWord.def = [[word.def stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
                [word release];
                [self wordExistDisplay];
                //            }
            } else {
                kNetTest;
                if (kNetIsExist) {
                    //            NSLog(@"有网");
                    [self catchWords:WordIFind];
                } else {
                    myWord.key = WordIFind;
                    myWord.audio = @"";
                    myWord.pron = @" ";
                    myWord.def = @"";
                    [self wordNoDisplay];
                }
            }
            
        
        
        [myHighLightWord setFrame:CGRectMake(pointX, mylabel.frame.origin.y + pointY, width, lineHeight)];
        [myHighLightWord setAlpha:1.0];
        [myHighLightWord setHighlighted:YES];
        [myHighLightWord setHighlightedTextColor:[UIColor whiteColor]];
        [myHighLightWord setBackgroundColor:[UIColor colorWithRed:136.0/255 green:179.0/255 blue:1.0 alpha:1]];
        [textScroll insertSubview:myHighLightWord belowSubview:mylabel];
        [myHighLightWord setHidden:NO];
        }
        @catch (id exception) {
            if ([exception isKindOfClass:[NSException class]]) {
//                NSLog(@"exception:%@",exception);
            }
                 else {
//                     NSLog(@"unknown exception");
                 }
                 return;
        }
        //        wordBack = [[UIView alloc] initWithFrame:CGRectMake(pointX, pointY, width, lineHeight)];
        //        wordBack.backgroundColor = [UIColor colorWithRed:1.0 green:0.651 blue:0.098 alpha:0.5];
        //        [self insertSubview:wordBack atIndex:0];
        //        [self GetExplain:WordIFind];
    }   
    
}

//- (void)touchUpInside: (NSSet *)touches mylabel:(MyLabel *)mylabel {
//    if (mylabel.tag == 2000) {
//        [explainView setHidden:YES];
//        [myHighLightWord setHidden:YES];
//        return;
//    }
//    if (![explainView isHidden]) {
//        [explainView setHidden:YES];
//        [myHighLightWord setHidden:YES];
//    }
//    UITouch *touch = [touches anyObject];    
//    CGPoint touchPoint = [touch locationInView:self.textScroll];
//    int fontSize = [[NSUserDefaults standardUserDefaults] integerForKey:@"nowValueFont"];
//    NSLog(@"nowValueFont:%d",fontSize);
//    UIFont *Courier = [UIFont fontWithName:@"Courier" size:fontSize];
//    //    if (!isiPhone) {
//    //        Courier = [UIFont fontWithName:@"Courier" size:fontSize];
//    //    }
//    double engHight = [@"a" sizeWithFont:Courier].height;
//    float single = [@" " sizeWithFont:Courier].width ;//每个字符宽度，为9
//    NSLog(@"single:%f single:%f",single,[@" " sizeWithFont:Courier constrainedToSize:CGSizeMake(textScroll.frame.size.width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].width);
//    //    float enHeight = [@"a" sizeWithFont:Courier].height - 1;
//    float space = 0.f;
//    //    NSLog(@"space:%f",space);
//    //    NSLog(@"single:%f",single);
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
//        //        space = 9;
//        space = [@" " sizeWithFont:Courier].width-1;
//    }else {
//        space = [@" " sizeWithFont:Courier].width+1;
//    }
//    int rowOne = (touchPoint.y - mylabel.frame.origin.y)/engHight + 1;
//    
//    //    NSLog(@"row:%d",rowOne);
//    //    NSLog(@"触摸：%f %f", touchPoint.x,touchPoint.y);
//    int rowTwo = 1;
//    int location = 0;
//    
//    float total = textScroll.frame.size.width;
////    NSLog(@"total:%f",textScroll.frame.size.width);
//    float myWith =-space;
//    float compare = -space;
//    float add = -space;
//    BOOL flg = YES;
//    BOOL firstFlg = NO;
//    int i = 0;
//    NSString *regEx = @"\\S+";
//    NSString *wordEx = @"\\w+";
//    NSString *nonWordEx = @"\\W+";
//    for(NSString *matchOne in [mylabel.text componentsMatchedByRegex:regEx]) {
//        //        NSLog(@"正则后one： %@ %d", matchOne,[matchOne length]);
//        i  = 0;
//        location = 0;
//        add = matchOne.length*single + space;
//        firstFlg = NO;
//        if ([matchOne isEqualToString:@"--"]&&(myWith+2*single)>(total-space)&&(myWith+2*single)<(total)) {
//            rowTwo++;
//            myWith=space;
//            continue;
//        }
//        for(NSString *matchTwo in [matchOne componentsMatchedByRegex:wordEx]) {
//            firstFlg = YES;
//            NSRange substr = [matchOne rangeOfString:matchTwo];
//            flg = (matchTwo.length == matchOne.length);
//            for(NSString *matchThree in [matchOne componentsMatchedByRegex:nonWordEx]) {
//                if (([matchThree isEqualToString:@"‘"]||[matchThree isEqualToString:@"’"]||[matchThree isEqualToString:@"“"]||[matchThree isEqualToString:@"”"])&&(myWith+single+matchOne.length*single>total)) {
//                    rowTwo++;
//                    //                        NSLog(@"0myWith:%f", myWith);
//                    myWith=-space;
//                    break;
//                }
//            }   
//            //                NSLog(@"flg:%d",flg);
//            if (flg) {
//                if ((myWith+space+matchTwo.length*single)>total) {
//                    rowTwo++;
//                    //                    NSLog(@"1width:%f", myWith);
//                    myWith = -space;
//                    //                    NSLog(@"1width:%f", myWith);
//                }
//                add = matchTwo.length*single + space;
//                compare = myWith + space;
//            }
//            else{
//                if (i==0) {
//                    myWith += substr.location*single+ space;
//                    //                    NSLog(@"width:%f, %d %d",myWith, location, substr.location);
//                }
//                else
//                {
//                    //                    NSLog(@"width1.%d:%f", i,myWith);
//                    //                    NSLog(@"hahahah : %c",[matchOne characterAtIndex:(substr.location-1)]);
//                    if ([matchOne characterAtIndex:(substr.location-1)] == '-') {
//                        myWith += (substr.location - location-1)*single+space;
//                    }else
//                    {
//                        myWith += (substr.location - location)*single;
//                    }
//                    //                    NSLog(@"width1.%d:%f, %d %d",i,myWith, location, substr.location);
//                }
//                char cc;
//                if ((substr.location+matchTwo.length)<matchOne.length) {
//                    cc = [matchOne characterAtIndex:(substr.location+matchTwo.length)];
//                    if ((cc=='.'||cc=='-'||cc==',')&&(myWith+matchTwo.length*single+space) > total)
//                    {
//                        rowTwo++;
//                        myWith=0;
//                    }
//                }
//                if ((myWith + matchTwo.length*single) > total) 
//                {
//                    rowTwo++;
//                    //                    NSLog(@"3width:%f", myWith);
//                    myWith=0;
//                }
//                location = substr.location;
//                compare = myWith;
//            }
//            i++;
//            if ((rowOne==rowTwo)&&(touchPoint.x>compare)&&(touchPoint.x<(compare+matchTwo.length*single))) {
//                //                NSLog(@"正则后two： %@ %d", matchTwo,[matchTwo length]);
//                //                NSLog(@"我找到了！词为:%@,x:%f,y:%f,width:%f,height:20.0", matchTwo, compare, mylabel.frame.origin.y + (rowTwo-1)*19.0, [matchTwo length] * single);
//                [self catchWords:matchTwo];
//                
//                
//                [myHighLightWord setFrame:CGRectMake(compare, mylabel.frame.origin.y + (rowTwo-1)*engHight, [matchTwo length] * single, engHight)];
//                [myHighLightWord setAlpha:0.5];
//                [myHighLightWord setHighlighted:YES];
//                [myHighLightWord setHighlightedTextColor:[UIColor whiteColor]];
//                [myHighLightWord setBackgroundColor:[UIColor blueColor]];
//                [textScroll addSubview:myHighLightWord];
//                [myHighLightWord setHidden:NO];
//                return;
//            }
//            if (rowTwo > rowOne) {
//                return;
//            }
//            
//        }
//        if (firstFlg) {
//            if (flg) {
//                
//                myWith+=add;
//                //                NSLog(@"5width:%f", myWith);
//            }
//            else
//            {
//                myWith += (matchOne.length - location)*single;
//                //                NSLog(@"6width:%f", myWith);
//            }
//        } else{
//            myWith += matchOne.length*single + space;
//        }
//        
//    }    
//    
//}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = myScroll.frame.size.width;
    int page = floor((myScroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSArray *subView = pageControl.subviews;     // UIPageControl的每个点
    pageControl.currentPage = page;
    for (int i = 0; i < [subView count]; i++) {
		UIImageView *dot = [subView objectAtIndex:i];
		dot.image = (pageControl.currentPage == i ? [UIImage imageNamed:@"dotbhd.png"] : [UIImage imageNamed:@"dotcrt.png"]);
	}
    
}

#pragma mark - AVAudioSessionDelegate
- (void)beginInterruption
{
    //    NSLog(@"beginInterruption");
    //    if (localFileExist) {
    [player pause];
    [playButton setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
    //    }
    //    else {
    //        [player pause];
    ////        [playButton setImage:[UIImage imageNamed:@"PplayPressed.png"] forState:UIControlStateNormal];
    //    }
    //    [playButton setImage:[UIImage imageNamed:@"PpausePressed.png"] forState:UIControlStateNormal];
    //    [playButton setImage:[UIImage imageNamed:@"PplayPressed.png"] forState:UIControlStateNormal];
}

//- (void)endInterruption
//{
//     NSLog(@"endInterruption");
//    if (localFileExist) {
//        [playButton setImage:[UIImage imageNamed:@"PplayPressed.png"] forState:UIControlStateNormal];
//        [localPlayer play];
//    }else {
////        [player pause];
//    }
//}
#pragma mark - static method
+ (PlayViewController *)sharedPlayer
{
    static PlayViewController *sharedPlayer;
    
    @synchronized(self)
    {
        if (!sharedPlayer){
            sharedPlayer = [[PlayViewController alloc] init];
            //            sharedPlayer.voa = voa;
        }
        else{
            
        }
        
        return sharedPlayer;
    }
}

+ (NSOperationQueue *)sharedQueue
{
    static NSOperationQueue *sharedSingleQueue;
    
    @synchronized(self)
    {
        if (!sharedSingleQueue){
            sharedSingleQueue = [[NSOperationQueue alloc] init];
            [sharedSingleQueue setMaxConcurrentOperationCount:1];
        }
        return sharedSingleQueue;
    }
}
#pragma mark - Motion
/*
 * 检测振动，控制播放
 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //    NSLog(@"%d",[[NSUserDefaults standardUserDefaults] boolForKey:@"shakeCtrlPlay"]);
    if ((motion == UIEventSubtypeMotionShake)&&([[NSUserDefaults standardUserDefaults] boolForKey:@"shakeCtrlPlay"]))
    {
        //        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"title" message:@"this is a test." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [servicesDisabledAlert show];
        //        [servicesDisabledAlert release];
        [self playButtonPressed:playButton]; 
    }
}


#pragma mark - PlayMode
/*
 控制上一首，下一首
 */

- (void) nextPlay{
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"playMode"]) {
        case 1:
            if (nowPlayRow==[musicsArray count]-1) {
//                NSLog(@"shunxuPlay: now: %d all:%d",nowPlayRow,[musicsArray count]);
                [player pause];
                [self setButtonImage:pauseImage];
            }else {
//                 NSLog(@"shunxuPlay: now: %d all:%d",nowPlayRow,[musicsArray count]);     
                 nowPlayRow++;
                HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
                [[UIApplication sharedApplication].keyWindow addSubview:HUD];
                HUD.delegate = self;
                HUD.labelText = @"Loading";
                [HUD show:YES];
                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self play];
                    });
                });
            }
            
            break;
        case 2:
            if (nowPlayRow==[musicsArray count]-1) {
//                 NSLog(@"xunhuanPlay: now: %d all:%d",nowPlayRow,[musicsArray count]);                
                nowPlayRow=0;
                HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
                [[UIApplication sharedApplication].keyWindow addSubview:HUD];
                HUD.delegate = self;
                HUD.labelText = @"Loading";
                [HUD show:YES];
                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self play];
                    });
                });
            }else {
//                 NSLog(@"xunhuanPlay: now: %d all:%d",nowPlayRow,[musicsArray count]);                
                nowPlayRow++;
                HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
                [[UIApplication sharedApplication].keyWindow addSubview:HUD];
                HUD.delegate = self;
                HUD.labelText = @"Loading";
                [HUD show:YES];
                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self play];
                    });
                });
            }
            break;
        case 3:
            if ([musicsArray objectAtIndex: nowPlayRow]==[musicsArray lastObject]) {
//                 NSLog(@"danquPlay: now: %d all:%d",nowPlayRow,[musicsArray count]);               
                [player pause];
                [self setButtonImage:pauseImage];
            }else {
//                 NSLog(@"danquPlay: now: %d all:%d",nowPlayRow,[musicsArray count]);                
                nowPlayRow++;
                HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
                [[UIApplication sharedApplication].keyWindow addSubview:HUD];
                HUD.delegate = self;
                HUD.labelText = @"Loading";
                [HUD show:YES];
                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self play];
                    });
                });
            }
            break;
        case 4:
            nowPlayRow=rand()%[musicsArray count];
//             NSLog(@"suijiPlay: now: %d all:%d",nowPlayRow,[musicsArray count]);          
            HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
            [[UIApplication sharedApplication].keyWindow addSubview:HUD];
            HUD.delegate = self;
            HUD.labelText = @"Loading";
            [HUD show:YES];
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self play];
                });
            });

            break;
        default:
            break;
    }
}

- (void) prPlay
{
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"playMode"]) {
    case 1:
        if (nowPlayRow==0) {
//             NSLog(@"shunxuPlay: now: %d all:%d",nowPlayRow,[musicsArray count]);            
            [player pause];
            [self setButtonImage:pauseImage];
        }else {
//             NSLog(@"shunxuPlay: now: %d all:%d",nowPlayRow,[musicsArray count]);
            nowPlayRow--;
            HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
            [[UIApplication sharedApplication].keyWindow addSubview:HUD];
            HUD.delegate = self;
            HUD.labelText = @"Loading";
            [HUD show:YES];
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self play];
                });
            });
        }
        
        break;
    case 2:
        if (nowPlayRow==0) {
//             NSLog(@"xunhuanPlay: now: %d all:%d",nowPlayRow,[musicsArray count]);       
            nowPlayRow=[musicsArray count]-1;
            HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
            [[UIApplication sharedApplication].keyWindow addSubview:HUD];
            HUD.delegate = self;
            HUD.labelText = @"Loading";
            [HUD show:YES];
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self play];
                });
            });
        }else {
//             NSLog(@"xunhuanPlay: now: %d all:%d",nowPlayRow,[musicsArray count]);
            nowPlayRow--;
            HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
            [[UIApplication sharedApplication].keyWindow addSubview:HUD];
            HUD.delegate = self;
            HUD.labelText = @"Loading";
            [HUD show:YES];
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self play];
                });
            });

        }
        break;
    case 3:
            if (nowPlayRow==0) {
//                 NSLog(@"danquPlay: now: %d all:%d",nowPlayRow,[musicsArray count]);         
                [player pause];
                [self setButtonImage:pauseImage];
            }else {
//                 NSLog(@"danquPlay: now: %d all:%d",nowPlayRow,[musicsArray count]);  
                nowPlayRow--;
                HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
                [[UIApplication sharedApplication].keyWindow addSubview:HUD];
                HUD.delegate = self;
                HUD.labelText = @"Loading";
                [HUD show:YES];
                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self play];
                    });
                });

            }

        break;
    case 4:
        nowPlayRow=rand()%[musicsArray count];
//        NSLog(@"suijiPlay: now: %d all:%d",nowPlayRow,[musicsArray count]);       
            HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
            [[UIApplication sharedApplication].keyWindow addSubview:HUD];
            HUD.delegate = self;
            HUD.labelText = @"Loading";
            [HUD show:YES];
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self play];
                });
            });
        break;
    default:
        break;
}     
}
//- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    if (motion == UIEventSubtypeMotionShake)
//    {
//        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"title" message:@"this is a test." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [servicesDisabledAlert show];
//        [servicesDisabledAlert release];
//    }
//}

#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView //明确cell数目
 numberOfRowsInSection:(NSInteger)section {
    return [musicsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    UIFont *songListFo;
    if (isiPhone) {
        songListFo = [UIFont systemFontOfSize:10];
    } else {
        songListFo = [UIFont systemFontOfSize:14];
    }
    
    //            UIFont *classFoPad = [UIFont systemFontOfSize:20];
    static NSString *ListCell= @"ListCell";
    UITableViewCell *cellThree = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:ListCell];
    if (!cellThree) {
        cellThree = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ListCell] autorelease];
        UILabel *titleLabel = [[UILabel alloc] init];
        UILabel *nowPlay = [[UILabel alloc] init];
        if (isiPhone) {
            [titleLabel setFrame:CGRectMake(5, 0, 160, 25)];
            [titleLabel setFont:songListFo];
            [nowPlay setFrame:CGRectMake(0, 0, 4, 22)];
        } else {
            [titleLabel setFrame:CGRectMake(10, 0, 330, 50)];
            [titleLabel setFont:songListFo];
            [nowPlay setFrame:CGRectMake(0, 0, 4, 44)];
        }
        [nowPlay setTag:2];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTag:1];
        [titleLabel setTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8f]];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        UIImageView *line = [[UIImageView alloc]init];
        if (isiPhone) {
            [line setImage:[UIImage imageNamed:@"listLine.png"]];

            [line setFrame:CGRectMake(0, 23, 180, 2)];
        } else {
            [line setImage:[UIImage imageNamed:@"listLine.png"]];

            [line setFrame:CGRectMake(0, 46, 360, 4)];
        }
        
        [cellThree addSubview:titleLabel];
        [cellThree addSubview:line];
//        if (row == nowPlayRow) {
//            UILabel *nowPlay = [[UILabel alloc] init];
//            [nowPlay setFrame:CGRectMake(0, 0, 4, 22)];
//            [nowPlay setBackgroundColor:[UIColor colorWithRed:112.0/255 green:144.0/255 blue:200.0/255 alpha:1]];
//            [cellThree addSubview:nowPlay];
//            [nowPlay release];
//        }
        [cellThree addSubview:nowPlay];
        [nowPlay release];
        [titleLabel release];
        [line release];
    }

    for (UIView *nLabel in [cellThree subviews]) {
        
        if (nLabel.tag == 1) {
            MusicView *musiclist = [musicsArray objectAtIndex:row];
            [(UILabel*)nLabel setText:[NSString stringWithFormat:@" %@ - %@",musiclist._singer,musiclist._title]];
        }
        if (nLabel.tag == 2 ) {
            if (row == nowPlayRow) {
//                NSLog(@"row:%d,nowPlay:%d",row,nowPlayRow);
                [(UILabel *)nLabel setBackgroundColor:[UIColor colorWithRed:112.0/255 green:144.0/255 blue:200.0/255 alpha:1]];
            }else{
                [(UILabel *)nLabel setBackgroundColor:[UIColor clearColor]];
            }

        }
        
    }
    
    [cellThree setSelectionStyle:UITableViewCellSelectionStyleGray];
    cellThree.backgroundColor = [UIColor clearColor];
    //        [cellThree.textLabel setText:[classArray objectAtIndex:row]];
    //        [cellThree.textLabel setTextAlignment:NSTextAlignmentRight];
    //        [cellThree.textLabel setBackgroundColor:[UIColor clearColor]];
    //        [cellThree.textLabel setTextColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.8f]];
    return cellThree;
    
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (isiPhone?25.0f:50.0f);
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    nowPlayRow = [indexPath row];
    HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [HUD show:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self play];
        });
    });

    [UIView beginAnimations:@"classAniTwo" context:nil];
    [UIView setAnimationDuration:0.6];
    [UIView setAnimationCurve:UIViewAnimationOptionCurveEaseInOut];
    if (isiPhone) {
        if (IS_IPHONE_5) {
            [songList setFrame:CGRectMake(140,(isFree? 351+88:401+88), 180, 0)];

        } else {
            [songList setFrame:CGRectMake(140, (isFree?351:401), 180, 0)];

        }
     }else{
         [songList setFrame:CGRectMake(468, (isFree?835:925), 300, 0)];
    }
    [UIView commitAnimations];
    [listButton setBackgroundColor:[UIColor clearColor]];

    
}

#pragma mark - Picker Data Source Methods
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return component == kHourComponent?[self.hoursArray count]:(component == kMinComponent?[self.minsArray count]:[self.secsArray count]);
}

#pragma mark - Picker Delegate Methods
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return component == kHourComponent?[self.hoursArray objectAtIndex:row]:(component == kMinComponent?[self.minsArray objectAtIndex:row]:[self.secsArray objectAtIndex:row]);
}

@end









