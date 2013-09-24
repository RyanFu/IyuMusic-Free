//
//  favdatabase.h
//  IyuMusic
//
//  Created by iyuba on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PlausibleDatabase/PlausibleDatabase.h>

@interface favdatabase : NSObject

+(PLSqliteDatabase *) setup;

+(void) close;
@end
