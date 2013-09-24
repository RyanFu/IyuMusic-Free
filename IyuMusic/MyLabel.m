//
//  MyLabel.m
//  IyuMusic
//
//  Created by iyuba on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyLabel.h"

@implementation MyLabel

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame])
    {
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [delegate touchUpInside :touches mylabel:self ];
}

- (void)dealloc {
    [super dealloc];
}

@end
