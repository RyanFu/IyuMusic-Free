//
//  InforViewController.m
//  IyuMusic
//
//  Created by iyuba on 12-8-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InforViewController.h"

@implementation InforViewController
@synthesize webView;

#pragma mark * Setup

- (void)_loadInfoContent
{
    //    NSString *  	infoFilePath;
    NSURLRequest *  request;
    
    //    infoFilePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"html"];
    //    assert(infoFilePath != nil);
    //    
    //    request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:infoFilePath]];
    //    assert(request != nil);
    
    request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://app.iyuba.com/ios/"]];
    assert(request != nil);
    
    [self.webView loadRequest:request];
}

#pragma mark - My Action
- (void)doSeg:(id)sender
{
        [_webView reload];
}
- (void)backButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark * View controller boilerplate
//
//- (BOOL)isPad {
//	BOOL isPad = NO;
//#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
//	isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
//#endif
//	return isPad;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    kNetTest;
    isiPhone = ![Constants isPad];
    if (!isiPhone) {
        [self.view setFrame:CGRectMake(0, 0, 768, 980)];
        [self.webView setFrame:CGRectMake(0, 0, 768, 980)];
    }
    assert(self.webView != nil);
    
//    NSLog(@"%f",self.view.frame.size.width);
    
//    [webView setContentStretch:self.view.frame];
    
    [self.view addSubview:webView];
    
    [self _loadInfoContent];
    
    UIButton * imgBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [imgBtn2 setBackgroundImage:[UIImage imageWithContentsOfFile:
								[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"titleBtn"] ofType:@"png"]]
					  forState:UIControlStateNormal];
	[imgBtn2 setTitle:@"重载" forState:UIControlStateNormal];
	imgBtn2.titleLabel.font=[UIFont systemFontOfSize:13];
    [imgBtn2 addTarget:self action:@selector(doSeg:) forControlEvents:UIControlEventTouchUpInside];
    imgBtn2.frame = CGRectMake(0, 0, 50, 37);
    UIBarButtonItem * reloadbutton= [[UIBarButtonItem alloc] initWithCustomView:imgBtn2];
    self.navigationItem.rightBarButtonItem = reloadbutton;
	self.navigationItem.hidesBackButton = YES;
	[reloadbutton release];
    
    
    UIButton * imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imgBtn setImage:[UIImage imageWithContentsOfFile:
								[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"return"] ofType:@"png"]] 
					  forState:UIControlStateNormal];
    [imgBtn addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    imgBtn.frame = CGRectMake(0, 0, 50, 37);
    UIBarButtonItem * backbutton = [[UIBarButtonItem alloc] initWithCustomView:imgBtn];
    self.navigationItem.leftBarButtonItem = backbutton;
	self.navigationItem.hidesBackButton = YES;
	[backbutton release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.webView = nil;
}

- (void)dealloc
{
    [self->_webView release];
    [super dealloc];
}

@end

