//
//  LyricSynClass.m
//  IyuMusic
//
//  Created by iyuba on 12-7-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LyricSynClass.h"
#import "JMWhenTapped.h"

@implementation LyricSynClass
//@synthesize delegate;

+(void)lyricSyn:(NSMutableArray *)lyricLabelArray index:(NSMutableArray *)indexArray time:(NSMutableArray *)timeArray localPlayer:(AVPlayer *)mp3Player scroll:(TextScrollView *)textScroll
{
    [lyricLabelArray retain];
    [indexArray retain];
    [timeArray retain];
    [mp3Player retain];
    [textScroll retain];
    CMTime playerProgress=[mp3Player currentTime];
    double progress =CMTimeGetSeconds(playerProgress);
    NSInteger myColor =[[NSUserDefaults standardUserDefaults] integerForKey:@"mulValueColor"];
    UIColor *swColor =[UIColor  colorWithRed:25.0/255 green:107.0/255 blue:250.0/255 alpha:1];
    switch (myColor) {
        case 1:
            swColor=[UIColor  colorWithRed:25.0/255 green:107.0/255 blue:250.0/255 alpha:1];
            break;
        case 2:
            swColor =[UIColor colorWithRed:245.0/255 green:84.0/255 blue:106.0/255 alpha:1];
            break;
        case 3:
            swColor =[UIColor blueColor];
            break;
        case 4:
            swColor = [UIColor brownColor];
            break;
        case 5:
            swColor = [UIColor orangeColor];
            break;
        case 6:
            swColor = [UIColor purpleColor];
            break;
        case 7:
            swColor = [UIColor cyanColor];
            break;
        case 8:
            swColor = [UIColor grayColor];
            break;
        case 9:
            swColor = [UIColor colorWithRed:0.421f green:0.753f blue:0.173f alpha:1.0];
            break;
        default:
            break;
    }
    for(int i =0 ;i<[indexArray count]-1; i++){
        UITextView *lyricLabel =[lyricLabelArray objectAtIndex:i];
        [lyricLabel retain];
        if(((float)progress >=[[timeArray objectAtIndex:i] floatValue]) && ((float)progress < [[timeArray objectAtIndex:i+1]floatValue])){
//            lyricLabel.highlighted =YES;
//            lyricLabel.highlightedTextColor=swColor;
            [lyricLabel setTextColor:swColor];


            if([[NSUserDefaults standardUserDefaults]objectForKey:@"hightlightLoc"]==nil){
                if([Constants isPad]){
                    UITextView *preLabel = nil;
                    if (i>1) {
                        preLabel = [lyricLabelArray objectAtIndex:i-2];
                    }else {
                        preLabel = [lyricLabelArray objectAtIndex:0];
                    }
                    CGPoint offSet =  CGPointMake(0, preLabel.frame.origin.y);
                    [textScroll setContentOffset:offSet animated:YES];
                }else {
                    UITextView *preLabel = nil;
                    if (i>0) {
                        preLabel = [lyricLabelArray objectAtIndex:i-1];
                    }else {
                        preLabel = [lyricLabelArray objectAtIndex:0];
                    }
                    CGPoint offSet =  CGPointMake(0, preLabel.frame.origin.y);
                    [textScroll setContentOffset:offSet animated:YES];
                }
            }else {
                BOOL highlightLoc = [[NSUserDefaults standardUserDefaults] boolForKey:@"hightlightLoc"];
                if (highlightLoc) {
                    if ([Constants isPad]) {
                        UITextView *preLabel = nil;
                        if (i>1) {
                            preLabel = [lyricLabelArray objectAtIndex:i-2];
                        }else {
                            preLabel = [lyricLabelArray objectAtIndex:0];
                        }
                        CGPoint offSet =  CGPointMake(0, preLabel.frame.origin.y);
                        [textScroll setContentOffset:offSet animated:YES];
                    }else {
                        UITextView *preLabel = nil;
                        if (i>0) {
                            preLabel = [lyricLabelArray objectAtIndex:i-1 ];
                        }else {
                            preLabel = [lyricLabelArray objectAtIndex:0];
                        }
                        CGPoint offSet =  CGPointMake(0, preLabel.frame.origin.y);
                        [textScroll setContentOffset:offSet animated:YES];
                    }
                }else {
                    CGPoint offSet =  CGPointMake(0, lyricLabel.frame.origin.y);
                    [textScroll setContentOffset:offSet animated:YES];
                }
            }
        }else {
            [lyricLabel setTextColor: [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.7]];
        }
        [lyricLabel release];
        
    }
    UITextView *lyricLabel = [lyricLabelArray objectAtIndex:[indexArray count] - 1];
	[lyricLabel retain];
	
	if ((float)progress >= [[timeArray objectAtIndex:[indexArray count] - 1] floatValue]){
        
//		lyricLabel.highlighted = YES;
//		lyricLabel.highlightedTextColor = swColor;
        [lyricLabel setTextColor:swColor];
		CGPoint offSet =  CGPointMake(0, lyricLabel.frame.origin.y);
		[textScroll setContentOffset:offSet];
	}//end if
	else {
//		lyricLabel.highlighted = NO;
        [lyricLabel setTextColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.7]];
    }//end else
	
	[lyricLabel release];
    //  释放引用		
	[lyricLabelArray release];
   	[indexArray release];
	[timeArray release];
	[mp3Player release];
	[textScroll release];
}



+(int) lyricView:(NSMutableArray *)lyricLabelArray
           index:(NSMutableArray *)indexArray
           lyric:(NSMutableArray *)lyricArray
          scroll:(TextScrollView *)textScroll
// myLabelDelegate:(id<MyLabelDelegate>)myLabelDelegate
           Lines:(int *)Lines{
[lyricLabelArray retain];
[indexArray retain];
[lyricArray retain];
[textScroll retain];
    
    
int offSetY =0;
//double lineHight =0.f;
int fontSize =15;
if([Constants isPad]){
    fontSize =20;
}
int mulValueFont =[[NSUserDefaults standardUserDefaults] integerForKey:@"mulValueFont"];
if(mulValueFont >0){
    fontSize =mulValueFont;
}
UIFont *Courier =[UIFont systemFontOfSize:fontSize];
//UIFont *CourierTwo =[UIFont systemFontOfSize:fontSize-2];
BOOL isPad =[Constants isPad];
if(isPad){
    Courier =[UIFont systemFontOfSize:fontSize];
//    CourierTwo =[UIFont systemFontOfSize:fontSize-2];
}
for(int i =0;i <=[indexArray count]-1;i++)
{
    
     CGSize enSize = [[lyricArray objectAtIndex:i] sizeWithFont:Courier constrainedToSize:CGSizeMake(textScroll.frame.size.width-25, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    
    
//    lineHight =[@"小"sizeWithFont:Courier].height;
//    *Lines=[[lyricArray objectAtIndex:i]sizeWithFont:Courier constrainedToSize:CGSizeMake(textScroll.frame.size.width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeCharacterWrap].height/lineHight;
//    
//    MyTextView *lyricLabel =[[MyTextView alloc] initWithFrame:CGRectMake(0, offSetY, textScroll.frame.size.width, *Lines*lineHight)];
//    lyricLabel.delegate =myLabelDelegate;
    MyTextView *lyricLabel = [[MyTextView alloc] initWithFrame:
                              CGRectMake(0, offSetY, textScroll.frame.size.width, enSize.height)];
   [lyricLabel setContentSize:CGSizeMake(textScroll.frame.size.width, enSize.height)];
    
    NSString *labelText = [[NSString alloc] initWithFormat:@"%@", [lyricArray objectAtIndex:i]];
    lyricLabel.text = labelText;
    [lyricLabel whenTapped:^{
        //            NSLog(@"11");
        //            [mp3Player seekToTime:CMTimeMakeWithSeconds([[timeArray objectAtIndex:i] unsignedIntValue], NSEC_PER_SEC)];
        [[PlayViewController sharedPlayer] aniToPlay:lyricLabel] ;
        //            PlayViewController *player = [PlayViewController sharedPlayer];
        //            player.selectWord = [lyricLabel.text substringWithRange:lyricLabel.selectedRange];
        //            [player.selectWord retain];
        //            NSLog(@"ca:%@", [lyricLabel.text substringWithRange:lyricLabel.selectedRange]);
    }];
    [lyricLabel whenDoubleTapped:^{ //避免双击时仍触发上面的单击事件
        //            NSLog(@"22");
    }];
    
    [labelText release];
//    lyricLabel.text=[[NSString alloc] initWithFormat:@"%@",[lyricArray objectAtIndex:i]];
    lyricLabel.tag =200+i;
    [lyricLabel setFont:Courier];
    [lyricLabel setTextColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.7]];
    lyricLabel.backgroundColor=[UIColor clearColor];
//    [lyricLabel setLineBreakMode:UILineBreakModeWordWrap];
//    [lyricLabel setNumberOfLines:*Lines];
    [lyricLabel setEditable:NO];
    [lyricLabel setScrollEnabled:NO];
    [lyricLabel setContentOffset:CGPointMake(0, 10)];
    
    [textScroll addSubview:lyricLabel];
    [lyricLabelArray addObject:lyricLabel];
    [lyricLabel release];
    offSetY += enSize.height;
//    if (isPad) {
//        offSetY +=*Lines*lineHight+30;
//
//    } else {
//        offSetY +=*Lines*lineHight+5;
//
//    }
    }
[lyricLabelArray release];
[lyricArray release];
[indexArray release];
[textScroll release];
return offSetY;

}


+(void)preLyricSyn:(NSMutableArray *)timeArray localPlayer:(AVPlayer *)mp3Player
{
CMTime playerProgress =[mp3Player currentTime];
double progress =CMTimeGetSeconds(playerProgress);
int i=0;
for(;i<[timeArray count];i++){
    if((float)progress<[[timeArray objectAtIndex:i] floatValue]){
        if((i-2)>=0){
            [mp3Player seekToTime:CMTimeMakeWithSeconds([[timeArray objectAtIndex:i-2]floatValue], NSEC_PER_SEC)];
        }
        return ;
    }
}
[mp3Player seekToTime:CMTimeMakeWithSeconds([[timeArray objectAtIndex:[timeArray count]-2]floatValue],NSEC_PER_SEC )];

}

+(void)aftLyricSyn:(NSMutableArray *)timeArray localPlayer:(AVPlayer *)mp3Player{
CMTime playerProgress =[mp3Player currentTime];
double progress =CMTimeGetSeconds(playerProgress);
int  i=0;
for(; i<[timeArray count];i++){
    if((float)progress<[[timeArray objectAtIndex:i]floatValue]){
        [mp3Player seekToTime:CMTimeMakeWithSeconds([[timeArray objectAtIndex:i]floatValue], NSEC_PER_SEC)];
        break;
    }
}
}
@end
