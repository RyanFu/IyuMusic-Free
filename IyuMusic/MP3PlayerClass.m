//
//  MP3PlayerClass.m
//  IyuMusic
//
//  Created by iyuba on 12-7-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MP3PlayerClass.h"

@implementation MP3PlayerClass

+(void)timeSliderChanged:(UISlider *)slider timeSlider:(UISlider *)timeSlider localPlayer:(AVPlayer *)mp3Player button:(UIButton *)playButton{
    [slider retain];
    [timeSlider retain];
    [mp3Player retain];
    [playButton retain];
    
    if (slider.maximumValue<=slider.value) {
        [playButton.layer removeAllAnimations];
        [mp3Player seekToTime:CMTimeMakeWithSeconds(slider.maximumValue - 1, NSEC_PER_SEC)];
//        [playButton setImage:[UIImage imageNamed:@"pause_button.png"] forState:UIControlStateNormal];
            } else {
                [mp3Player seekToTime:CMTimeMakeWithSeconds(timeSlider.value, NSEC_PER_SEC)];
                    }
    [slider release];
    [timeSlider release];
    [mp3Player release];
    [playButton release];
}

+(void)playButton:(UIButton *)button localPlayer:(AVPlayer *)mp3Player{
    [button retain];
    [mp3Player retain];
    if( mp3Player.rate !=0.f){
        [mp3Player pause];
    }else {
        [mp3Player play];
    }
    
    [button release];
    [mp3Player release];
    
}
@end
