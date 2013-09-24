//
//  MyNavigationBar.m
//  IyuMusic
//
//  Created by iyuba on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyNavigationBar.h"

@implementation MyNavigationBar

- (void)drawRect:(CGRect)rect {
    if ([Constants isPad]) {
        UIImage *image = [UIImage imageNamed:@"title@2x.png"];
        [image drawInRect:CGRectMake(0, 0, self.frame.size.width, 44)];

        } 
    else {
        UIImage *image = [UIImage imageNamed:@"title.png"];
        [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];

                    }
       [self setTintColor:[UIColor blueColor]];
}

@end
