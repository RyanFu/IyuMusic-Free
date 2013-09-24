//
//  MusicWord.h
//  IyuMusic
//
//  Created by iyuba on 12-8-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface MusicWord : NSObject
{
    NSInteger wordId;
    NSInteger userId;
    NSString *key;
    NSString *lang;
    NSString *audio;
    NSString *pron;
    NSString *def;
    NSString *date;
    NSInteger checks;
    NSInteger remember;
    NSInteger flag;
    NSInteger synchroFlg;
    NSMutableArray *engArray;
    NSMutableArray *chnArray;
    
}

@property NSInteger wordId;
@property NSInteger userId;
@property (nonatomic,retain) NSString *key;
@property (nonatomic,retain) NSString *lang;
@property (nonatomic,retain) NSString *audio;
@property (nonatomic,retain) NSString *pron;
@property (nonatomic,retain) NSString *def;
@property (nonatomic,retain) NSString *date;
@property NSInteger checks;
@property NSInteger remember;
@property NSInteger flag;
@property NSInteger synchroFlg;
@property (nonatomic,retain) NSMutableArray *engArray;
@property (nonatomic,retain) NSMutableArray *chnArray;

- (id) initWithMusicWord:(NSInteger) wordId key:(NSString *) _key audio:(NSString *) _audio pron:(NSString *) _pron def:(NSString *) _def date:(NSString *) _date  checks:(NSInteger) _checks remember:(NSInteger) _remember  userId:(NSInteger)_userId flag:(NSInteger) _flag;

+ (id) find:(NSString *) key userId:(NSInteger)userId;
- (BOOL) alterCollect;
- (BOOL) isExisit;
+ (NSMutableArray *) findWords:(NSInteger)userId;
+ (NSMutableArray *) findDelWords:(NSInteger)userId;
+ (void) deleteWord:(NSString *) key userId:(NSInteger) userId;
+ (void) addCheck:(NSInteger) wordId userId:(NSInteger)_userId;
- (void) addRemember;
+ (NSInteger) findLastId;
+ (MusicWord *) findById:(NSInteger) wordId userId:(NSInteger) userId;
+ (void) updateBykey:(NSString *) key audio:(NSString *) _audio pron:(NSString *) _pron def:(NSString *) _def userId:(NSInteger) _userId;
+ (void) updateFlgByKey:(NSString *) key userId:(NSInteger) _userId;
- (void) update;
+ (NSInteger) findCountByUserId:(NSInteger)userId;
+ (void) deleteByKey:(NSString *) key userId:(NSInteger) userId;
+ (void) deleteByUserId:(NSInteger) userId;
+ (void) deleteSynchro:(NSInteger) userId;
+ (void) clearSynchro;
- (void) alterSynchroCollect;
@end
