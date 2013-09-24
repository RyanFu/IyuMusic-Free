//
//  SevenProgressBar.m
//  IyuMusic
//
//  Created by iyuba on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SevenProgressBar.h"

@implementation SevenProgressBar

- (id)initWithFrame:(CGRect)frame andbackImg:(UIImage *)img frontimg:(UIImage *)fimg
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        backImg =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        backImg.image=img;
        [self addSubview:backImg];
        frontImg =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        frontImg.image=fimg;
        [self addSubview:frontImg];
        
        
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)setProgress:(float)progress
{
    progress =progress<0?0:progress;
    progress =progress>1?1:progress;
    frontImg.frame=CGRectMake(0, 0, progress*(self.frame.size.width), self.frame.size.height);
    
}


@end
