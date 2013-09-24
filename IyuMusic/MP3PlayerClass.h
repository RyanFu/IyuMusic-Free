//
//  MP3PlayerClass.h
//  IyuMusic
//
//  Created by iyuba on 12-7-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@interface MP3PlayerClass : NSObject


+(void) timeSliderChanged:(UISlider *)slider timeSlider:(UISlider *)timeSlider localPlayer:(AVPlayer *)localPlayer button:(UIButton *)playButton;
+(void) playButton:(UIButton *)button localPlayer:(AVPlayer *)localPlayer;
@end
