//
//  MyUser.h
//  IyuMusic
//
//  Created by iyuba on 12-8-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "favdatabase.h"
@interface MyUser : NSObject
{
    NSInteger _userId;
    NSString * _userName;
    NSString * _code;
    NSString * _mail;
    NSInteger _remember;
}

@property NSInteger  _userId;
@property NSInteger _remember;
@property (nonatomic, retain) NSString * _userName;
@property (nonatomic, retain) NSString * _code;
@property (nonatomic, retain) NSString * _mail;
- (BOOL) insert;
+ (NSString *) findCodeByName:(NSString *)userName;
+ (NSString *) findNameById:(NSInteger)userId;
+ (void) acceptRem:(NSString *)userName;
+ (void) cancelRem:(NSString *)userName;
+ (NSInteger) findIdByName:(NSString *)userName;
//+ (BOOL) isRem:(NSString *)userName;
@end
