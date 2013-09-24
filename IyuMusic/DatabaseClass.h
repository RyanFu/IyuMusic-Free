//
//  DatabaseClass.h
//  IyuMusic
//
//  Created by iyuba on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "database.h"
#import "MusicView.h"

@interface DatabaseClass : NSObject{
}

+(void)querySQL:(NSMutableArray *)lyricArray
timeResultIn:(NSMutableArray *) timeArray
indexResultIn:(NSMutableArray *) indexArray
  musicResultIn:(MusicView *)music;
@end
