//
//  MusicFav.h
//  IyuMusic
//
//  Created by iyuba on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "favdatabase.h"
#import "MusicView.h"

@interface MusicFav : NSObject
{
    NSInteger _iid;
    NSInteger _icid;
    NSString *_collect;
    NSString *_date;
}

@property NSInteger _iid;
@property NSInteger _icid;
@property (nonatomic, retain)NSString *_collect;
@property (nonatomic, retain)NSString *_date;
-(id) initWithMusicid:(NSInteger ) iid icid:(NSInteger )icid collect:(NSString *)collect date:(NSString *)date;

+(void) alterCollect:(NSInteger )iid icid:(NSInteger)icid;
+(void) deleteCollect:(NSInteger )iid;
+ (BOOL) isCollected:(NSInteger) iid;

+(id) find:(NSInteger )iid;

+(NSMutableArray *) findCollect;
+(NSMutableArray *) findCollectbyicid:(NSInteger )icid;

@end
