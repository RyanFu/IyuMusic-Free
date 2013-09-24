//
//  MusicContent.h
//  IyuMusic
//
//  Created by iyuba on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicContent : NSObject
{
    NSInteger _iid;
    NSString *_content;
    NSString *_title;
    NSString *_singer;
    NSString *_pic;
    NSInteger _number;
    NSInteger _titleNum;
    
}

@property NSInteger _iid;
@property (nonatomic,retain)NSString *_content;
@property (nonatomic,retain)NSString *_title;
@property (nonatomic,retain) NSString *_pic;
@property (nonatomic,retain)NSString *_singer;
@property NSInteger _number;
@property NSInteger _titleNum;

-(id) initWithMusicId:(NSInteger) iid content:(NSString *)content title:(NSString *) title singer:(NSString*)singer pic:(NSString *) pic number:(NSInteger) number titleNum:(NSInteger)titleNum;
                                                                                                
-(NSComparisonResult) compareNumber :( MusicContent *)p;


@end
