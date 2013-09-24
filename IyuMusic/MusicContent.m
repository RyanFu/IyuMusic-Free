//
//  MusicContent.m
//  IyuMusic
//
//  Created by iyuba on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MusicContent.h"

@implementation MusicContent
@synthesize _iid;
@synthesize _content;
@synthesize _titleNum;
@synthesize _number;
@synthesize _pic;
@synthesize _singer;
@synthesize _title;


-(NSComparisonResult) compareNumber:(MusicContent *)p{
    if(self._titleNum>p._titleNum){
        return NSOrderedAscending;
    }else {
        if(self._titleNum==p._titleNum){
            if(self._number==p._number){
                return NSOrderedSame;
            }else {
                if(self._number>p._number){
                    return NSOrderedAscending;
                }else {
                    return NSOrderedDescending;
                }
            }
        }
    }
    return NSOrderedDescending;
}


-(id)initWithMusicId:(NSInteger)iid content:(NSString *)content title:(NSString *)title singer:(NSString*)singer pic:(NSString *)pic number:(NSInteger)number titleNum:(NSInteger)titleNum
{
    if(self==[super init]){
        _iid=iid;
        _content=content;
        _title=title;
        _singer=singer;
        _pic=pic;
        _number=number;
        _titleNum=titleNum;
    }
    return  self;
}


@end
