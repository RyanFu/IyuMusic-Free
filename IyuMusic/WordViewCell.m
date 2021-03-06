//
//  WordViewCell.m
//  VOA
//
//  Created by song zhao on 12-3-9.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "WordViewCell.h"

@implementation WordViewCell
@synthesize audioButton;
@synthesize keyLabel;
@synthesize pronLabel;
@synthesize defLabel;
@synthesize defButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setMyDelegate:(id <MyLabelDelegate>) myLabelDelegate
{
    self.defLabel.delegate = myLabelDelegate;
}

- (void)dealloc {
	[audioButton release];
	audioButton = nil;
    [defButton release];
    defButton = nil;
    [keyLabel release];
    keyLabel = nil;
    [pronLabel release];
    pronLabel = nil;
    [defLabel release];
    defLabel = nil;
    [super dealloc];
}

@end
