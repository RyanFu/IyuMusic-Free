//
//  MusicFav.m
//  IyuMusic
//
//  Created by iyuba on 12-7-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MusicFav.h"

@implementation MusicFav

@synthesize _iid;
@synthesize _icid;
@synthesize _collect;
@synthesize _date;


-(id)initWithMusicid:(NSInteger)iid icid:(NSInteger )icid collect:(NSString *)collect date:(NSString *)date
{
    if(self =[super init]){
        _iid =iid;
        _icid =icid;
        _collect=collect;
        _date =date;
    }
    return self;
}


+(NSArray *)findCollect
{
    PLSqliteDatabase *dataBase = [favdatabase setup];    
    id<PLResultSet> rs;
    rs =[dataBase executeQuery:@"SELECT * FROM fav WHERE collect =1 order by date desc"];
    NSMutableArray *musicFavs =[[NSMutableArray alloc]init];
    while ([rs next]) {
        int iid =[rs intForColumn:@"iid"];
        int icid =[rs intForColumn:@"icid"];
        NSString *collect =[rs objectForColumn:@"collect"];
        NSString *date =[rs objectForColumn:@"date"];
        MusicFav *musicFav =[[MusicFav alloc] initWithMusicid:iid icid :icid collect:collect date:date];
        [musicFavs addObject:musicFav];
        [musicFav release];
    }
    [rs close];
    return musicFavs;
}


+(NSArray *)findCollectbyicid:(NSInteger )icid
{ PLSqliteDatabase *dataBase = [favdatabase setup];
    
    id<PLResultSet> rs;
    NSString *findSql =[NSString stringWithFormat:@"SELECT * FROM fav WHERE collect =1 and icid=%d order by date desc",icid];
    rs =[dataBase executeQuery:findSql];
    NSMutableArray *musicFavs =[[NSMutableArray alloc]init];
    while ([rs next]) {
        int iid =[rs intForColumn:@"iid"];
        int icid =[rs intForColumn:@"icid"];
        NSString *collect =[rs objectForColumn:@"collect"];
        NSString *date =[rs objectForColumn:@"date"];
        MusicFav *musicFav =[[MusicFav alloc] initWithMusicid:iid icid :icid collect:collect date:date];
        [musicFavs addObject:musicFav];
        [musicFav release];
    }
    [rs close];
    return musicFavs;    
    
}

+(id) find:(NSInteger)iid
{
    PLSqliteDatabase *databBase =[favdatabase setup];
    id<PLResultSet>rs;
    NSString *findSql= [NSString stringWithFormat:@"select * FROM fav WHERE iid =%d",iid];
    rs=[databBase executeQuery:findSql];
    MusicFav *musicFav =nil;
    if([rs next]){
        NSInteger icid=[rs intForColumn:@"icid"];
        NSString *collect =[rs objectForColumn:@"collect"];
        NSString *date=[rs objectForColumn:@"date"];
        musicFav =[[MusicFav alloc] initWithMusicid:iid icid:icid collect:collect date:date];
    }
    [rs close];
    return musicFav;
}


+(void) alterCollect:(NSInteger)iid icid:(NSInteger)icid
{
    PLSqliteDatabase *dataBase =[favdatabase setup];
    NSString *date;
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd/HH:mm:ss"];
    date =[formatter stringFromDate:[NSDate date]];
    if ([self find:iid]) {
//        NSLog(@"%@",[self find:iid]);
        NSString *findSql =[NSString stringWithFormat:@"update fav set icid = %d , collect = 1 , date=\"%@\" WHERE iid = %d ;",icid,date,iid];
        if ([dataBase executeUpdate:findSql]) {
    
        } else {
                    UIAlertView *errAlert=[[UIAlertView alloc]initWithTitle:@"Error!" message:@"Update failture!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [errAlert show];
        }
        
    }else {
        NSString *findSql=[NSString stringWithFormat:@"insert into fav (iid,icid,collect,date) values(%d,%d,1,\"%@\");",iid,icid,date];
        if([dataBase executeUpdate:findSql]){
            
        }else {
            UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Update failture!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errAlert show];
            [errAlert release];
        }
    }
    [formatter release],formatter =nil;
}


+ (void) deleteCollect:(NSInteger)iid
{
    PLSqliteDatabase *dataBase =[favdatabase setup];
    NSString *findSql =[NSString stringWithFormat:@"update fav set collect = 0 WHERE iid = %d ;",iid];
//    NSLog(@"sql:%@",findSql);
    if ([dataBase executeUpdate:findSql]) {
//        NSLog(@"diaole");
            } else {
                UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Update failture!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [errAlert show];
                [errAlert release];
                    }
}

+ (BOOL) isCollected:(NSInteger) iid{
    PLSqliteDatabase *dataBase = [favdatabase setup];
    
	id<PLResultSet> rs;
	NSString *findSql = [NSString stringWithFormat:@"select * FROM fav WHERE iid = %d and collect = 1 ", iid];
	rs = [dataBase executeQuery:findSql];
	BOOL flg = NO;
	if([rs next]) {
        flg = YES;
	}
	else {
        //		UIAlertView *errAlert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Can not find!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		[errAlert show];
	}
	
	[rs close];
    //	[voaDetail release];
	return flg;
}

@end
