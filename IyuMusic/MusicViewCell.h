//
//  MusicViewCell.h
//  IyuMusic
//
//  Created by iyuba on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DACircularProgress/DACircularProgressView.h"

@interface MusicViewCell : UITableViewCell
{
    UIImageView *myImage;
    UIImageView *aftImage;
    UILabel *myTitle;
    UILabel *mySinger;
    UIButton *downloadBtn;
    DACircularProgressView *progress;
    
    
}
@property (nonatomic,retain) IBOutlet UIImageView *myImage;
@property (nonatomic,retain) IBOutlet UILabel *myTitle;
@property (nonatomic,retain) IBOutlet UILabel *mySinger;
@property (nonatomic,retain) IBOutlet UIImageView *aftImage;
@property (nonatomic,retain) UIButton *downloadBtn;
@property (nonatomic,retain) DACircularProgressView *progress;

@end
