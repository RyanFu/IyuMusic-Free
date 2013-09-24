//
//  MyPageControl.h
//  IyuMusic
//
//  Created by iyuba on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MyPageControl : UIPageControl {
	UIImage *imagePageStateNormal;
	UIImage *imagePageStateHightlighted;
}

- (id) initWithFrame:(CGRect)frame;

@property (nonatomic, retain) UIImage *imagePageStateNormal;
@property (nonatomic, retain) UIImage *imagePageStateHightlighted;

@end
