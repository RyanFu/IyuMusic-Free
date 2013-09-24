//
//  MusicView.m
//  IyuMusic
//
//  Created by iyuba on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MusicView.h"
#import "database.h"

@implementation MusicView

@synthesize _iid;
@synthesize _icid;
@synthesize _title;
@synthesize _intro;
@synthesize _pic;
@synthesize _singer;
@synthesize _audio;
@synthesize _myProgressView;


- (id) initWithMusicId:(NSInteger)iid title:(NSString *)title intro:(NSString *)intro singer:(NSString *)singer  icid:(NSInteger)icid audio:(NSString *)audio pic:(NSString *)pic{
    if (self =[super init]){
        _iid=iid;
        _icid=icid ;
        _singer=[singer retain];
        _title=[title retain];
        _intro=[intro retain];
        _pic=[pic retain];
        _audio=[audio retain];
    }
    return self;
    
}

/*
-(BOOL) insert
{
    PLSqliteDatabase *dataBase =[database setup];
    NSString *findSql=[NSString stringWithFormat:@"insert into item(iid,title,icid,audio,pic)values(%d,%@,%d,%@,%@);",self._iid,self._title,self._icid,self._audio,self._pic];
    if ([dataBase executeUpdate:findSql]) {
        return YES;
            } else {
                
                    }
    return  NO;
                       
}
*/
NSMutableString *convertString(NSMutableString * parentString){

    char *replace = "\\n";
    [parentString replaceOccurrencesOfString:[NSString stringWithUTF8String:replace] 
                           withString:@" " 
                              options:NSLiteralSearch 
                                range:NSMakeRange(0, [parentString length])];
    char *replace2 ="\\r";
    [parentString replaceOccurrencesOfString:[NSString stringWithUTF8String:replace2] 
                                  withString:@" " 
                                     options:NSLiteralSearch 
                                       range:NSMakeRange(0, [parentString length])];
    char *replace3 ="\\";
    [parentString replaceOccurrencesOfString:[NSString stringWithUTF8String:replace3] 
                                  withString:@" " 
                                     options:NSLiteralSearch 
                                       range:NSMakeRange(0, [parentString length])];
    return  parentString;
    

}

+ (NSArray *) findAll{
	PLSqliteDatabase *dataBase = [database setup];
	
	id<PLResultSet> rs;
	rs = [dataBase executeQuery:@"SELECT * FROM item ORDER BY iid desc "];
    
//    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	//定义一个数组存放所有信息
	NSMutableArray *musicViews = [[NSMutableArray alloc] init];
	
	//把rs中的数据库信息遍历到MusicViews数组
	while ([rs next]) {
        NSInteger iid = [rs intForColumn:@"iid"];
        NSString *titleAndsinger = [rs objectForColumn:@"title"];
        NSMutableString *intro = [NSMutableString stringWithString:[rs objectForColumn:@"introduce"]];
        NSInteger icid = [rs intForColumn:@"icid"];
        NSString *audio = [rs objectForColumn:@"audio"];
        NSString *pic = [rs objectForColumn:@"pic"];
        //        NSString *title_cn = [rs objectForColumn:@"title_cn"];
        //        NSString *title_jp = [rs objectForColumn:@"title_jp"];
        //		NSString *collect = [rs objectForColumn:@"collect"];
        NSRange substr = [titleAndsinger rangeOfString:@"_"];
        int sp = substr.location;
               NSString *singer =[[NSString alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(0, sp)]];
        NSString *next=[[NSString  alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(sp+1, 1) ]];
        NSString *title=nil;
        if ([next isEqualToString:@"_"]) {
            //NSLog(@"1");
            title = [[NSString alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(sp+2, [titleAndsinger length]-sp-2)]]  ;      }else {
                //NSLog(@"2");
                title = [[NSString alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(sp+1, [titleAndsinger length]-sp-1)]];
            }
        intro= convertString(intro);
        MusicView *musicView = [[MusicView alloc] initWithMusicId:iid title:title intro:intro singer:singer icid:icid audio:audio pic:pic ];
        [title release];
		[musicViews addObject:musicView];
		[next release];
        [singer release];
		[musicView release];  
	}
	//关闭数据库
	[rs close];
    //	[dataBase close];//
    
//    [pool drain];
	return musicViews;
}

+ (NSArray *) findAfterByicid:(NSInteger)iid
{
	PLSqliteDatabase *dataBase = [database setup];
	
	id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select * from item where iid <%d ORDER BY iid desc ",iid];
	rs = [dataBase executeQuery:findSql];
    //    NSLog(@"sql:%@",findSql);
    
    
	//定义一个数组存放所有信息
	NSMutableArray *musicViews = [[NSMutableArray alloc] init];
	
	//把rs中的数据库信息遍历到voaViews数组
	while ([rs next]) {
        NSInteger iid = [rs intForColumn:@"iid"];
        NSString *titleAndsinger = [rs objectForColumn:@"title"];
        NSMutableString *intro = [NSMutableString stringWithString:[rs objectForColumn:@"introduce"]];
        NSInteger icid = [rs intForColumn:@"icid"];
        NSString *audio = [rs objectForColumn:@"audio"];
        NSString *pic = [rs objectForColumn:@"pic"];
        //        NSString *title_cn = [rs objectForColumn:@"title_cn"];
        //        NSString *title_jp = [rs objectForColumn:@"title_jp"];
        //		NSString *collect = [rs objectForColumn:@"collect"];
        NSRange substr = [titleAndsinger rangeOfString:@"_"];
        int sp = substr.location;
        // NSString * disTitle = [[NSString alloc] initWithFormat:@"第%@集",[picTitle substringWithRange:NSMakeRange([picTitle length]-4, 2)]];       
                NSString *singer =[[NSString alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(0, sp)]];
        NSString *next=[[NSString  alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(sp+1, 1) ]];
        NSString *title=nil;
        if ([next isEqualToString:@"_"]) {
            //NSLog(@"1");
            title = [[NSString alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(sp+2, [titleAndsinger length]-sp-2)]]  ;      }else {
                //NSLog(@"2");
                title = [[NSString alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(sp+1, [titleAndsinger length]-sp-1)]];
            }
        intro = convertString(intro);
        MusicView *musicView = [[MusicView alloc] initWithMusicId:iid title:title intro:intro singer:singer icid:icid audio:audio pic:pic ];
		[musicViews addObject:musicView];
		[next release];
        [title release];
        [singer release];
		[musicView release];   
	}
	//关闭数据库
	[rs close];
    //	[dataBase close];//
	return musicViews;
}

+ (NSArray *) findMusicBetween:(NSInteger)max mix:(NSInteger)mix
{
	PLSqliteDatabase *dataBase = [database setup];
    //	NSLog(@"%d %d",max,mix);
	id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select * from item where iid>%d and iid <=%d ORDER BY iid desc ",mix,max];
	rs = [dataBase executeQuery:findSql];
    //    NSLog(@"sql:%@",findSql);
    
    
	//定义一个数组存放所有信息
	NSMutableArray *musicViews = [[NSMutableArray alloc] init];
	
	//把rs中的数据库信息遍历到voaViews数组
	while ([rs next]) {
        NSInteger iid = [rs intForColumn:@"iid"];
        NSString *titleAndsinger = [rs objectForColumn:@"title"];
        NSInteger icid = [rs intForColumn:@"icid"];
        NSMutableString *intro = [NSMutableString stringWithString:[rs objectForColumn:@"introduce"]];        NSString *audio = [rs objectForColumn:@"audio"];
        NSString *pic = [rs objectForColumn:@"pic"];
        //        NSString *title_cn = [rs objectForColumn:@"title_cn"];
        //        NSString *title_jp = [rs objectForColumn:@"title_jp"];
        //		NSString *collect = [rs objectForColumn:@"collect"];
        NSRange substr = [titleAndsinger rangeOfString:@"_"];
        int sp = substr.location;
        NSString *singer =[[NSString alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(0, sp)]];
        NSString *next=[[NSString  alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(sp+1, 1) ]];
        NSString *title=nil;
        if ([next isEqualToString:@"_"]) {
            //NSLog(@"1");
            title = [[NSString alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(sp+2, [titleAndsinger length]-sp-2)]]  ;      }else {
                //NSLog(@"2");
                title = [[NSString alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(sp+1, [titleAndsinger length]-sp-1)]];
            }       
        intro =convertString(intro);
        MusicView *musicView = [[MusicView alloc] initWithMusicId:iid title:title intro:intro singer:singer icid:icid audio:audio pic:pic ];
		[musicViews addObject:musicView];
		[next release];
        [title release];
        [singer release];
		[musicView release];  
	}
	//关闭数据库
	[rs close];
    //	[dataBase close];//
	return musicViews;
}


+(id) find:(NSInteger )iid{
    PLSqliteDatabase *dataBase =[database setup];
    id<PLResultSet>rs;
    NSString *findSql = [NSString stringWithFormat:@"select * from item where iid= %d",iid];
    rs =[dataBase executeQuery:findSql];
    MusicView *musicView =nil;
    if([rs next]){
        NSInteger iid = [rs intForColumn:@"iid"];
        NSString *titleAndsinger = [rs objectForColumn:@"title"];
        NSInteger icid = [rs intForColumn:@"icid"];
        NSMutableString *intro = [NSMutableString stringWithString:[rs objectForColumn:@"introduce"]]; 
        NSString *audio = [rs objectForColumn:@"audio"];
        NSString *pic = [rs objectForColumn:@"pic"];
        //        NSString *title_cn = [rs objectForColumn:@"title_cn"];
        //        NSString *title_jp = [rs objectForColumn:@"title_jp"];
        //		NSString *collect = [rs objectForColumn:@"collect"];
        NSRange substr = [titleAndsinger rangeOfString:@"_"];
        int sp = substr.location;
        NSString *singer =[[NSString alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(0, sp)]];
        NSString *next=[[NSString  alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(sp+1, 1) ]];
        NSString *title=nil;
        if ([next isEqualToString:@"_"]) {
            //NSLog(@"1");
           title = [[NSString alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(sp+2, [titleAndsinger length]-sp-2)]]  ;      }else {
               //NSLog(@"2");
          title = [[NSString alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(sp+1, [titleAndsinger length]-sp-1)]];
            }
        // NSString * disTitle = [[NSString alloc] initWithFormat:@"第%@集",[picTitle substringWithRange:NSMakeRange([picTitle length]-4, 2)]];       
        intro=convertString(intro);
        
        musicView = [[MusicView alloc] initWithMusicId:iid title:title intro:intro singer:singer icid:icid audio:audio pic:pic ];
        [title release];
        [singer release];
        [next release];
        
    }else{
        
    }
    [rs close];
    return musicView;
    
}

+ (NSArray *)  findByicid:(NSInteger)icid{
    PLSqliteDatabase *dataBase =[database setup];
    id<PLResultSet>rs;
    NSString *findSql = [NSString stringWithFormat:@"select * from item where icid =%d order by iid desc",icid];
    rs=[dataBase executeQuery:findSql];
    NSMutableArray *musicViews =[[NSMutableArray alloc]init];
    while ([rs next]) {
        NSInteger iid = [rs intForColumn:@"iid"];
        NSString *titleAndsinger = [rs objectForColumn:@"title"];
        NSMutableString *intro = [NSMutableString stringWithString:[rs objectForColumn:@"introduce"]];     NSInteger icid = [rs intForColumn:@"icid"];
        NSString *audio = [rs objectForColumn:@"audio"];
        NSString *pic = [rs objectForColumn:@"pic"];
        //        NSString *title_cn = [rs objectForColumn:@"title_cn"];
        //        NSString *title_jp = [rs objectForColumn:@"title_jp"];
        //		NSString *collect = [rs objectForColumn:@"collect"];
        NSRange substr = [titleAndsinger rangeOfString:@"_"];
        int sp = substr.location;
        NSString *singer =[[NSString alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(0, sp)]];
        NSString *next=[[NSString  alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(sp+1, 1) ]];
        NSString *title=nil;
        if ([next isEqualToString:@"_"]) {
            //NSLog(@"1");
            title = [[NSString alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(sp+2, [titleAndsinger length]-sp-2)]]  ;      }else {
                //NSLog(@"2");
                title = [[NSString alloc] initWithFormat:@"%@",[titleAndsinger substringWithRange:NSMakeRange(sp+1, [titleAndsinger length]-sp-1)]];
            }
        intro =convertString(intro);
        MusicView *musicView = [[MusicView alloc] initWithMusicId:iid title:title intro:intro singer:singer icid:icid audio:audio pic:pic ];
		[musicViews addObject:musicView];
		[title release];
        [singer release];
        [next release];
		[musicView release];  
    }
    [rs close];
    return musicViews;
}
+ (BOOL) isSimilar:(NSInteger) iid search:(NSString *) search
{
    PLSqliteDatabase *dataBase = [database setup];
	id<PLResultSet> rs;
    NSString *nowSearch = [[NSString alloc] initWithFormat:@"\"%%%@%%\"", search];
     //   NSLog(@"%@", nowSearch);
	NSString *findSql = [NSString stringWithFormat:@"select * FROM item WHERE iid = %d and lrccontent like %@ ", iid, nowSearch];
    [nowSearch release];
      //  NSLog(@"%@", findSql);
	rs = [dataBase executeQuery:findSql];
	if ([rs next]) {
        //        NSString *sentence = [rs objectForColumn:@"sentence"];
        //        NSLog(@"%@", sentence);
        [rs close];
        return YES;
	}	
	
	return NO;	
}

+ (BOOL) isTitleSimilar:(NSInteger) iid search:(NSString *) search
{
    PLSqliteDatabase *dataBase = [database setup];
	id<PLResultSet> rs;
    NSString *nowSearch = [[NSString alloc] initWithFormat:@"\"%%%@%%\"", search];
    //    NSLog(@"%@", nowSearch);
	NSString *findSql = [NSString stringWithFormat:@"select iid FROM item WHERE title like %@;",  nowSearch];
    [nowSearch release];
    //    NSLog(@"%@", findSql);
	rs = [dataBase executeQuery:findSql];
	if ([rs next]) {
        //        NSString *sentence = [rs objectForColumn:@"sentence"];
        //        NSLog(@"%@", sentence);
        [rs close];
        return YES;
	}	
	
	return NO;	
}

+ (NSString *) getTitleContent:(NSInteger) iid search:(NSString *) search
{
    PLSqliteDatabase *dataBase = [database setup];
	id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select title FROM item WHERE iid = %d;", iid];
	rs = [dataBase executeQuery:findSql];
    NSString *sentence = @"";
	if ([rs next]) {
        sentence = [rs objectForColumn:@"title"];
        //        content = [content stringByAppendingString: sentence];
	}
    
	[rs close];
	return sentence;
}

+ (NSString *) getContent:(NSInteger) iid search:(NSString *) search
{
    PLSqliteDatabase *dataBase = [database setup];
	id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select lrccontent FROM item WHERE iid = %d ", iid];
	rs = [dataBase executeQuery:findSql];
    NSString *content = @"";
	while ([rs next]) {
        NSString *sentence = [rs objectForColumn:@"lrccontent"];
        content = [content stringByAppendingString: sentence];
	}
    
	[rs close];
	return content;
}

+ (int) numberOfMatch:(NSString *) sentence search:(NSString *)search
{
    NSMutableString *source = [NSMutableString stringWithString:sentence]; 
    NSRange substr = [source rangeOfString:search options:NSCaseInsensitiveSearch];   
    int number = 0;
    while (substr.location != NSNotFound) { 
        //        NSLog(@"有！");
        [source replaceCharactersInRange:substr withString:@""]; 
        substr = [source rangeOfString:search options:NSCaseInsensitiveSearch]; 
        number++;
    } //字符串查找,可以判断字符串中是否有 
    //       NSLog(@"%d", number);
    return number;
}
+ (NSArray *) findSimilar:(NSArray *) musicsArray search:(NSString *) search 
{
    
    NSMutableArray *musicContents = [[NSMutableArray alloc] init];
    //    voaContents = nil;
    MusicView *music =[MusicView alloc];
    NSInteger number = 0;
    NSInteger titleNum = 0;
    for ( music in musicsArray) {
            //    NSLog(@"%d", music._iid);
        //		[voasArray addObject:voa];
        if ([self isSimilar:music._iid search:search]) {
            NSString *content = [self getContent:music._iid search:search];
            NSString *titleCon = [self getTitleContent:music._iid search:search];
           // NSLog(@"%@", content);
            number = [self numberOfMatch:content search:search];
            titleNum = [self numberOfMatch:titleCon search:search];
            MusicContent *musicContent = [[MusicContent alloc] initWithMusicId:music._iid content:content title:[music _title] singer:[music _singer]  pic:[music _pic] number:number titleNum:titleNum];
            [musicContents addObject:musicContent];
            [musicContent release], musicContent = nil;
        }
    }
    [music release];
   // NSLog(@"%@",musicContents);
    [musicContents sortUsingSelector:@selector(compareNumber:)];//对数组进行排序 
    return musicContents;
    //    return [self QuickSort:voaContents left:0 right:([voaContents count]-1)];
    //    NSTimer *myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(setProgress:) userInfo: repeats:<#(BOOL)#>]
    //    
}
+ (NSMutableArray *) findFavSimilar:(NSArray *) favsArray search:(NSString *) search
{
    NSMutableArray *musicContents =[[NSMutableArray alloc] init];
    MusicView *music =nil;
    NSInteger titleNum =0;
    NSInteger number =0;
    for (MusicFav*fav in favsArray) {
        music= [MusicView find:fav._iid];
        if([self isSimilar:music._iid search:search]){
            NSString *content =[self getContent:music._iid search:search];
            NSString *titleCon=[self getTitleContent:music._iid search:search];
            number = [self numberOfMatch:titleCon search:search]; 
            titleNum =[self numberOfMatch:titleCon search:search];
            MusicContent *musicContent =[[MusicContent alloc] initWithMusicId:music._iid content:content title:[music _title] singer:[music _singer] pic:[music _pic] number:number titleNum:titleNum];
            [musicContents addObject:musicContent];
            [musicContent release],musicContent=nil;
        }
    }
    [music release];
    [musicContents sortUsingSelector:@selector(compareNumber:)];//对数组进行排序 
    return musicContents;

}

+ (void) clearDownload:(NSInteger)iid
{
    PLSqliteDatabase *dataBase = [database setup];
    if ([self find:iid]) {
        NSString *findSql = [NSString stringWithFormat:@"update item set Downloading = 0 WHERE iid = %d ;",iid];
        if([dataBase executeUpdate:findSql]) {
            //            NSLog(@"--success!");
        }
    }
}

+ (void) clearAllDownload
{
    PLSqliteDatabase *dataBase = [database setup];
    NSString *findSql = @"update item set Downloading = 0 WHERE Downloading = 1;";
    if([dataBase executeUpdate:findSql]) {
        //            NSLog(@"--success!");
    }
}

+ (BOOL) isDownloading:(NSInteger)iid
{
    PLSqliteDatabase *dataBase = [database setup];
    id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select Downloading FROM item WHERE iid = %d", iid];
    rs = [dataBase executeQuery:findSql];
    BOOL downLoad = NO;
    if([rs next]) {
        NSString *Downloading = [rs objectForColumn:@"Downloading"];
        downLoad = [Downloading isEqualToString:@"1"];
    }
    
    [rs close];
    return downLoad;
}

+ (NSMutableArray *) findDownloading
{
    NSMutableArray *downLoadArray = [[NSMutableArray alloc]init];
    PLSqliteDatabase *dataBase = [database setup];
    id<PLResultSet> rs;
    NSString *findSql = [NSString stringWithFormat:@"select * FROM item WHERE Downloading = 1"];
    rs = [dataBase executeQuery:findSql];
    if([rs next]) {
        NSNumber *iid = [rs objectForColumn:@"iid"];
        [downLoadArray addObject:iid];
    }
   
    [rs close];
    return downLoadArray;
}

+ (void) alterDownload:(NSInteger)voaid
{
    PLSqliteDatabase *dataBase = [database setup];
    if ([self find:voaid]) {
        NSString *findSql = [NSString stringWithFormat:@"update item set Downloading = 1 WHERE iid = %d ;",voaid];
        if([dataBase executeUpdate:findSql]) {
            //            NSLog(@"--success!");
        }
    }
}

/*
 +(NSInteger) findLastId
{
    PLSqliteDatabase *dataBase =[database setup];
    id<PLResultSet>rs;
    NSString *findSql= [NSString stringWithFormat:@"select max(iid)last from item"];
    rs =[dataBase executeQuery:findSql];
    NSString *last = @"0";
    if([rs next]){
        last =[rs objectForColumn:@"last"];
    }else {
        
    }
    [rs close];
    return last.integerValue;
    
}
*/
/*
+ (void) alterRead:(NSInteger)iid
{
    PLSqliteDatabase *dataBase = [ database setup];
    if([self find:iid]){
        NSString  *findSql = [NSString stringWithFormat:@"update item set IsRead =1 WHERE iid = %d;",iid];
 if ([dataBase executeUpdate:findSql]){
 
    }else{
 }
}    
}
*/

@end
