//
//  MyLabel.h
//  IyuMusic
//
//  Created by iyuba on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
@class MyLabel;

@protocol MyLabelDelegate <NSObject>

@required
- (void)touchUpInside: (NSSet *)touches mylabel:(MyLabel *)mylabel ;
@end

@interface MyLabel : UILabel {
    id <MyLabelDelegate> delegate;
}

@property (nonatomic, assign) id <MyLabelDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;

@end
