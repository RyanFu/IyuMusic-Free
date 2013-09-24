//
//  SearchViewController.m
//  IyuMusic
//
//  Created by iyuba on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@implementation SearchViewController
@synthesize _contentsArray;
@synthesize _contentsSrArray;
@synthesize _searchWords;
@synthesize musicsTableView;
@synthesize searchFlg;
@synthesize addNum;
@synthesize HUD;
@synthesize contentBg;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    isiPhone =![Constants isPad];
    if(isiPhone){
        self = [super initWithNibName:@"SearchViewController" bundle:nibBundleOrNil];
    }else{
        self = [super initWithNibName:@"SearchViewController-iPad" bundle:nibBundleOrNil];
        NSLog(@"nowload:%@",nibNameOrNil);
    }
    if (self) {
        // Custom initialization
     NSLog(@"nowload:%@",nibNameOrNil);
        
    }
    return self;

}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (void)backButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) doEdit{
	
	[musicsTableView setEditing:!musicsTableView.editing animated:YES];
	if(musicsTableView.editing)
    {
        UIBarButtonItem *temp = self.navigationItem.rightBarButtonItem;
        UIButton *button = (UIButton *)[temp customView];
        [button setTitle:kSearchOne forState:UIControlStateNormal];
    }
	else
    {
//		self.navigationItem.rightBarButtonItem.title = kSearchTwo;
        UIBarButtonItem *temp = self.navigationItem.rightBarButtonItem;
        UIButton *button = (UIButton *)[temp customView];
        [button setTitle:kSearchTwo forState:UIControlStateNormal];
    }
}

//- (BOOL)isPad {
//	BOOL isPad = NO;
//#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
//	isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
//#endif
//	return isPad;
//}


#pragma mark - View lifecycle

- (void) viewWillAppear:(BOOL)animated {
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBarHidden = NO;
    }

- (void)viewDidLoad
{
    
   

    isiPhone = ![Constants isPad];
    if (isiPhone) {
        if (IS_IPHONE_5) {
            [self.view setFrame:CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height+88)];
        }
        [musicsTableView setFrame:CGRectMake(10, 0, 300, self.view.frame.size.height-13)];
        [contentBg setFrame:CGRectMake(9,0, 302, self.view.frame.size.height-3)];
    }else {
        [musicsTableView setFrame:CGRectMake(22, 0, 724, 865)];
    }
    self.navigationController.navigationBarHidden = NO;
//    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:kSearchTwo style:UIBarButtonItemStylePlain target:self action:@selector(doEdit)];
    if (searchFlg<10) {

    } 
    else {
        UIButton * imgBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [imgBtn2 setBackgroundImage:[UIImage imageWithContentsOfFile:
                                     [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"titleBtn"] ofType:@"png"]] 
                           forState:UIControlStateNormal];
        [imgBtn2 setTitle:kSearchTwo forState:UIControlStateNormal];
        imgBtn2.titleLabel.font=[UIFont systemFontOfSize:13];
        [imgBtn2 addTarget:self action:@selector(doEdit) forControlEvents:UIControlEventTouchUpInside];
        imgBtn2.frame = CGRectMake(0, 0, 70, 34);
        UIBarButtonItem * editbutton = [[UIBarButtonItem alloc] initWithCustomView:imgBtn2];
        self.navigationItem.rightBarButtonItem = editbutton;
        //    self.navigationItem.rightBarButtonItem = (UIBarButtonItem *)imgBtn2;
        
        [editbutton release];
//        self.navigationItem.rightBarButtonItem = editButton;
    }
    self.navigationItem.hidesBackButton = YES;
    UIButton * imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imgBtn setImage:[UIImage imageWithContentsOfFile:
								[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"return"] ofType:@"png"]] 
					  forState:UIControlStateNormal];
    [imgBtn addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    imgBtn.frame = CGRectMake(0, 0, 50, 37);
    UIBarButtonItem * backbutton = [[UIBarButtonItem alloc] initWithCustomView:imgBtn];
    self.navigationItem.leftBarButtonItem = backbutton;
	[backbutton release];
    self.title = [NSString stringWithFormat:@"%@\"%@\"%@", kSearchThree,_searchWords,kSearchFour];
//    if (searchFlg<10) {
////        [self catchResult:_searchWords page:1];
//    }
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.musicsTableView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    //    [myRequest clearDelegatesAndCancel];
    //    [myRequest release];
    [_contentsArray release];
    [_contentsSrArray release];
    [musicsTableView release];
    [_searchWords release];
    [HUD release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView //明确cell数目
 numberOfRowsInSection:(NSInteger)section {
    return self.searchFlg > 10 ?[self._contentsArray count]:[_contentsSrArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSUInteger row = [indexPath row];
//        NSLog(@"row:%d",row);
    static NSString *FirstLevelCell= @"SearchResultCell";
    MusicViewCell *cell = (MusicViewCell*)[tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
    if (!cell) {
        if (isiPhone) {
            cell = (MusicViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"MusicViewCell" 
                                                                owner:self 
                                                              options:nil] objectAtIndex:0];
        }else {
            cell = (MusicViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"MusicViewCell-ipad" 
                                                                owner:self 
                                                              options:nil] objectAtIndex:0];
        }
        
    }
    MusicContent *content = nil;
    if (self.searchFlg>10) {
        content = [_contentsArray objectAtIndex:row];
    }else{
        content = [_contentsSrArray objectAtIndex:row];
            }
//    [cell.myTitle setTextColor:[UIColor whiteColor]];
//    [cell.mySinger setTextColor:[UIColor whiteColor]];
    cell.myTitle.text = content._title;
    cell.mySinger.text= content._singer;
   // [cell.myDate setTextColor:[UIColor redColor]];
   // cell.myDate.text = [NSString stringWithFormat:@"%@%d%@;%@%d%@",kSearchSix, content._titleNum, kSearchEight, kSearchSeven,content._number,kSearchEight];
    //[cell.collectDate setTextColor:[UIColor purpleColor]];
    //cell.collectDate.text = content._creattime;
    //--------->设置内容换行
    [cell.myTitle setLineBreakMode:UILineBreakModeClip];
    //--------->设置最大行数
    [cell.myTitle setNumberOfLines:3];
   // NSURL *url = [NSURL URLWithString: content._pic];
    NSString *picname= [[NSString alloc] initWithFormat:@"image%@.jpg",content._pic];
    [cell.myImage setImage:[UIImage imageNamed:picname]];
    [picname release];
    //        }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;  
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return isiPhone?80.0f:160.0f;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{	
    if (self.searchFlg>10) {
        [_contentsArray removeObjectAtIndex:indexPath.row];
    }else{
        [_contentsSrArray removeObjectAtIndex:indexPath.row];
    }
	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    MusicContent *content = nil;
    NSMutableArray *musicsArray=[[NSMutableArray alloc]init];
    if (self.searchFlg>10) {
        content = [_contentsArray objectAtIndex:row];
        for (int i=0; i<[_contentsArray count]; i++) {
            MusicView *addmusic=nil;
            addmusic = [MusicView find:content._iid];
            [musicsArray addObject:addmusic];
            [addmusic release];
        }
    }else{
        content = [_contentsSrArray objectAtIndex:row];
        for (int i=0; i<[_contentsSrArray count]; i++) {
            MusicView *addmusic=nil;
            addmusic = [MusicView find:content._iid];
            [musicsArray addObject:addmusic];
            [addmusic release];
        }
    }
    MusicView *music = [MusicView find:content._iid];
       HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
    HUD.delegate = self;
    HUD.dimBackground = YES;
    HUD.labelText = @"Connecting...";    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{  
        
        dispatch_async(dispatch_get_main_queue(), ^{  
                       // NSLog(@"选中：%d- %d",row,music._iid);
            dispatch_async(dispatch_get_main_queue(), ^{  
                PlayViewController *play = [PlayViewController sharedPlayer];//新建新界面的controller实例
                if(play.music._iid == music._iid)
                {
                    play.newFile = NO;
                }else
                {
                    play.musicsArray=[musicsArray copy];
                    play.nowPlayRow=row;
                    play.newFile = YES;
                    play.music = music;
                }
                [play setHidesBottomBarWhenPushed:YES];//设置推到新界面时无bottomBar
                [self.navigationController pushViewController:play animated:NO];
                [HUD hide:YES];
            });  
        });  
    });  
    [musicsArray release];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
}


@end
