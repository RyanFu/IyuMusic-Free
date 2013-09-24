//
//  MusicImageCell.h
//  IyuMusic
//
//  Created by iyuba on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicImageCell : UITableViewCell
{
    UIImageView *myImage;
}

@property (nonatomic,retain) IBOutlet UIImageView *myImage;
@end
