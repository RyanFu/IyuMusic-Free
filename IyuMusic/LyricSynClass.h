//
//  LyricSynClass.h
//  IyuMusic
//
//  Created by iyuba on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "TextScrollView.h"
#import "RegexKitLite.h"
#import "MyTextView.h"
//#import "MyLabel.h"
#import "Constants.h"

@interface LyricSynClass : NSObject{
//    id <MyLabelDelegate>delegate;
}
//@property (nonatomic,retain) id<MyLabelDelegate>delegate;

+(void)lyricSyn:(NSMutableArray *)lyricLabelArray
index:(NSMutableArray *)indexArray
time :(NSMutableArray *)timeArray
localPlayer:(AVPlayer *)mp3Player
         scroll:(TextScrollView *)textScroll;

+(void)preLyricSyn:(NSMutableArray *)timeArray
       localPlayer:(AVPlayer *)mp3Player;
+(void)aftLyricSyn:(NSMutableArray *)timeArray
       localPlayer:(AVPlayer *)mp3Player;


+(int)lyricView :(NSMutableArray *)lyricLabelArray 
index:(NSMutableArray *)indexArray
lyric:(NSMutableArray *)lyricArray
scroll:(TextScrollView *)textScroll
           Lines:(int *)Lines;


@end
