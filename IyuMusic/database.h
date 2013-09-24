//
//  database.h
//  IyuMusic
//
//  Created by iyuba on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PlausibleDatabase/PlausibleDatabase.h>
#include <sys/xattr.h>


@interface database : NSObject{
    
}

+(PLSqliteDatabase*) setup;

+(void) close;

//+(BOOL) addSkipBackupAttributeToItemAtUrl:(NSURL *)URL;

@end
