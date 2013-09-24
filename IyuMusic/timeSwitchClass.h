//
//  timeSwitchClass.h
//  IyuMusic
//
//  Created by iyuba on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ONE_MINUTE 60

@interface timeSwitchClass : NSObject{
}
-(NSMutableString *)timeToSwitch:(double)preTime;
+(NSString *) timeToSwitchAdvance:(double)preTime;



@end
