//
//  favdatabase.m
//  IyuMusic
//
//  Created by iyuba on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "favdatabase.h"
#import <PlausibleDatabase/PlausibleDatabase.h>
static PLSqliteDatabase *dbPointer;

@implementation favdatabase


+ (PLSqliteDatabase *) setup{
	
	if (dbPointer) {
		return dbPointer;
	}
	
	
    //	NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
	NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];
	NSString *realPath = [audioPath stringByAppendingPathComponent:@"favmusicdata.sqlite"];
	
	NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"favmusicdata" ofType:@"sqlite"];
	
    //	NSLog(@"sourcePath:%@",sourcePath);
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if (![fileManager fileExistsAtPath:realPath]) {
		NSError *error;
		if (![fileManager copyItemAtPath:sourcePath toPath:realPath error:&error]) {
            //			NSLog(@"%@",[error localizedDescription]);
		}
	}
	
    //	NSLog(@"复制sqlite到路径：%@成功。",realPath);
	
    //	把dbpointer地址修改为可修改的realPath。
	dbPointer = [[PLSqliteDatabase alloc] initWithPath:realPath];
	
	if ([dbPointer open]) {
        //		NSLog(@"open fav succeed!");
	};
	
	return dbPointer;
}

+ (void) close{
	if (dbPointer) {
		[dbPointer close];
		dbPointer = NULL;
	}
}


@end
