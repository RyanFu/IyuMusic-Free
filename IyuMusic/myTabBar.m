//
//  myTabBar.m
//  IyuMusic
//
//  Created by iyuba on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "myTabBar.h"


@implementation myTabBar

- (void)drawRect:(CGRect)rect {
    if ([Constants isPad]) {
        UIImage *image = [UIImage imageNamed:@"tabBarBg-iPad.png"];
        [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }else {
        UIImage *image = [UIImage imageNamed:@"tabBarBg.png"];
        [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];

    }
}

@end
