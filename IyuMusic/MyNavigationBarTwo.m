//
//  MyNavigationBarTwo.m
//  IyuMusic
//
//  Created by iyuba on 12-12-21.
//
//

#import "MyNavigationBarTwo.h"

@implementation MyNavigationBarTwo

- (void)drawRect:(CGRect)rect {
    if ([Constants isPad]) {
        UIImage *image = [UIImage imageNamed:@"titleMain@2x.png"];
        [image drawInRect:CGRectMake(0, 0, self.frame.size.width, 44)];
        
    }
    else {
        UIImage *image = [UIImage imageNamed:@"titleMain.png"];
        [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
    }
    [self setTintColor:[UIColor blueColor]];
}

@end
