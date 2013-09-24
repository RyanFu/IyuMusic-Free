//
//  MusicView.h
//  IyuMusic
//
//  Created by iyuba on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RegexKitLite.h"
#include "MusicContent.h"
#include "MusicFav.h"

@interface MusicView : NSObject
{
    
    NSInteger _iid;
    NSString *_title;
    NSInteger _icid;
    NSString *_singer;
    NSString *_audio;
    NSString *_pic;
    NSString *_intro;
}


@property NSInteger _iid;
@property (nonatomic, retain) NSString *_title;
@property (nonatomic, retain) NSString *_intro;
@property  NSInteger _icid;
@property (nonatomic, retain) NSString *_singer;
@property (nonatomic, retain) NSString *_audio;
@property (nonatomic, retain) NSString *_pic;
@property (nonatomic, retain) UIProgressView *_myProgressView;
//@property (nonatomic, retain) NSString *_title_jp;

//- (BOOL) insert;

//全赋值初始化VOAView对象
- (id) initWithMusicId:(NSInteger ) iid title:(NSString *) title intro:(NSString *)intro singer:(NSString *)singer icid:(NSInteger) icid audio:(NSString *) audio  pic:(NSString *) pic ;
//查找并返回全部对象
+ (NSMutableArray *) findAll;

+ (NSMutableArray *) findMusicBetween:(NSInteger)max mix:(NSInteger)mix;
//+ (NSMutableArray *) findNew:(NSInteger)offset;
+ (id) find:(NSInteger ) iid;

+ (NSMutableArray *) findByicid:(NSInteger) icid;

+ (BOOL) isSimilar:(NSInteger) iid search:(NSString *) search;

//+ (NSString *) getContent:(NSInteger) iid search:(NSString *) search;

+ (NSMutableArray *) findSimilar:(NSArray *)musicsArray search:(NSString *) search;

+ (NSMutableArray *) findFavSimilar:(NSArray *) favsArray search:(NSString *) search;
//+ (NSMutableArray *) findSimilar:(NSArray *) voasArray search:(NSString *) search progressBar:progressView;

//+ (int) numberOfMatch:(NSString *) sentence search:(NSString *)search;

//+ (NSInteger) findLastId;

//+ (void) alterRead:(NSInteger)iid;

//+ (void) alterDownload:(NSInteger)iid;

//+ (void) deleteByiid:(NSInteger)iid;

+ (NSMutableArray *) findDownloading;
+ (void) clearAllDownload;
+ (void) clearDownload:(NSInteger)iid;

+ (BOOL) isDownloading:(NSInteger)iid;
+ (void) alterDownload:(NSInteger)voaid;
//+ (NSMutableArray *) findAfterByicid:(NSInteger)iid;

//+ (BOOL) isExist:(NSInteger) iid;


@end
