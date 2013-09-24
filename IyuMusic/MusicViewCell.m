//
//  MusicViewCell.m
//  IyuMusic
//
//  Created by iyuba on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MusicViewCell.h"

@implementation MusicViewCell
@synthesize myImage;
@synthesize myTitle;
@synthesize mySinger;
@synthesize downloadBtn;
@synthesize progress;
@synthesize aftImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)dealloc{
    [myImage release];
    myImage=nil;
    [myTitle release];
    myTitle=nil;
    [mySinger release];
    mySinger=nil;
    [aftImage release];
    aftImage =nil;
    [super dealloc];
}

@end
