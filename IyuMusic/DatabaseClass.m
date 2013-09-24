//
//  DatabaseClass.m
//  IyuMusic
//
//  Created by iyuba on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DatabaseClass.h"

@implementation DatabaseClass

#if 0
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
#endif

+ (NSMutableString *)convertString:(NSMutableString *)parentString {
    
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"%@", parentString];
    
    char *replace = "\\n";
    [str replaceOccurrencesOfString:[NSString stringWithUTF8String:replace] 
                                  withString:@" " 
                                     options:NSLiteralSearch 
                                       range:NSMakeRange(0, [str length])];
    char *replace2 ="\\r";
    [str replaceOccurrencesOfString:[NSString stringWithUTF8String:replace2] 
                                  withString:@" " 
                                     options:NSLiteralSearch 
                                       range:NSMakeRange(0, [str length])];
    char *replace3 ="\\";
    [str replaceOccurrencesOfString:[NSString stringWithUTF8String:replace3] 
                                  withString:@" " 
                                     options:NSLiteralSearch 
                                       range:NSMakeRange(0, [str length])];
    return  str;
    
}

+(void)querySQL:(NSMutableArray *)lyricArray timeResultIn:(NSMutableArray *)timeArray indexResultIn:(NSMutableArray *)indexArray musicResultIn:(MusicView *)music{
    
    [lyricArray retain];
    [timeArray retain];
    [indexArray retain];
    PLSqliteDatabase *dataBase =[database setup];
    id<PLResultSet>rs;
    NSString *findSql =[NSString stringWithFormat:@"select lrccontent FROM item WHERE iid = %d " ,music._iid];
//    NSLog(@"%@",findSql);
    rs =[dataBase executeQuery:findSql];
    int myIndex =0;
    float time = 0.0;
    [rs next];
    NSMutableString *substr2 = [rs objectForColumn:@"lrccontent"];
//    NSLog(@"%p", substr2);
//    substr2=convertString(substr2);
    substr2 = [self convertString:substr2];
    NSString *substr=[NSString stringWithFormat:@"%@",substr2];
    [substr2 release];
    //NSLog(@"%@",substr);
    for (int i=0; i<=4; i++) {
        NSRange sub = [substr rangeOfString:@"["];
        int sp = sub.location;
        substr = [substr substringWithRange:NSMakeRange(sp+1, [substr length]-sp-1)];    
    }
while (substr !=nil) {
    NSString *minute10=[substr substringWithRange:NSMakeRange(0, 1)];
    NSString *minute0=[substr substringWithRange:NSMakeRange(1, 1)];
    NSString *second10=[substr substringWithRange:NSMakeRange(3, 1)];
    NSString *second0=[substr substringWithRange:NSMakeRange(4, 1)];
    NSString *aftdot10= [substr substringWithRange:NSMakeRange(6, 1)];
    NSString *aftdot0=[substr substringWithRange:NSMakeRange(7, 1)];
    int minute = minute10.intValue*10+minute0.intValue;
    int second = second10.intValue*10+second0.intValue;
//    NSLog(@"%d,%d,%d",music._iid,minute,second);
    int aftdot = aftdot10.intValue*10+aftdot0.intValue;
    time = minute*60+second+(float)aftdot/100;
//    NSLog(@"%d,%f",music._iid,time);
    NSNumber *timeNum =[[NSNumber alloc]initWithFloat:time];
    NSNumber *indexNum =[[NSNumber alloc] initWithInt:++myIndex];
    substr =[substr substringWithRange:NSMakeRange(9, substr.length-9)];
    NSRange sub =[substr rangeOfString:@"["];
    int sp =sub.location;
//    NSLog(@"%d",sp);
    NSString *lyric=nil;
    if(sp>200000)
    {
        lyric =substr;
//        NSLog(@"lyric:%@",lyric);
        substr=nil;
    }else {
        lyric =[substr substringWithRange:NSMakeRange(0, sp)];
       // NSLog(@"%@",lyric);
        substr =[substr substringWithRange:NSMakeRange(sp+1, [substr length]-sp-1)];    
    }
    NSString *lyricStr =[[NSString alloc] initWithUTF8String:lyric.UTF8String] ;
    [timeArray addObject:timeNum];
    [indexArray addObject:indexNum];
    [lyricArray addObject:lyricStr];
//    NSLog(@"timeNum:%f   ,lyr:%@",time,lyric);
    [timeNum release],timeNum =nil;
    [indexNum release],indexNum =nil;
    [lyricStr release],lyricStr=nil;
    
    
}
[rs close];
[lyricArray release];
[timeArray release];
[indexArray release];

    
}
@end
