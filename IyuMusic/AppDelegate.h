//
//  AppDelegate.h
//  IyuMusic
//
//  Created by iyuba on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flurry.h"
#import "MusicView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIScrollViewDelegate>
{
    UIView *myView;
    UIWindow *windowOne;
    UITabBarController *rootControllerOne;
    UIWindow *windowTwo;
    UITabBarController *rootControllerTwo;
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    NSUInteger numOfPages;
    
    BOOL pageControlUsed;
}

@property (retain,nonatomic)  UIWindow *windowOne;
@property (retain,nonatomic) IBOutlet UIWindow *windowTwo;
@property (retain,nonatomic) IBOutlet UITabBarController *rootControllerOne;
@property (retain,nonatomic) IBOutlet UITabBarController *rootControllerTwo;

void uncaughtExceptionHandler(NSException *exception);

@end
