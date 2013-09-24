//
//  SevenProgressBar.h
//  IyuMusic
//
//  Created by iyuba on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SevenProgressBar : UIView{
    UIImageView *backImg;
    UIImageView *frontImg;
}

-(void)setProgress:(float)progress;
-(id)initWithFrame:(CGRect)frame andbackImg:(UIImage *)img frontimg:(UIImage*)fimg;


@end
