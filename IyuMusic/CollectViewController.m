//
//  CollectViewController.m
//  IyuMusic
//
//  Created by iyuba on 12-8-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CollectViewController.h"
#import "database.h"

@implementation CollectViewController

@synthesize musicsArray;
@synthesize favArray;
@synthesize musicsTableView;
@synthesize search;
@synthesize HUD;
@synthesize all;
@synthesize man;
@synthesize woman;
@synthesize old;
@synthesize band;
@synthesize _myicid;
@synthesize changeImage;
@synthesize chView;
@synthesize contentImg;
//@synthesize bg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
#pragma mark - My action
//- (BOOL)isPad {
//	BOOL isPad = NO;
//#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
//	isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
//#endif
//	return isPad;
//}
-(IBAction)buttonPressed:(UIButton *)sender{
    _myicid=sender.tag;
    
    [UIView beginAnimations:@"Switch" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:.5];
    switch (_myicid) {
        case 0:
            [changeImage setCenter:CGPointMake(all.center.x - 1, all.center.y + 3.5)];
            break;
        case 186:
            [changeImage setCenter:CGPointMake(man.center.x - 1, man.center.y + 3.5)];
            break;
            
        case 187:
            [changeImage setCenter:CGPointMake(woman.center.x - 1, woman.center.y + 3.5)];
            break;
            
        case 185:
            [changeImage setCenter:CGPointMake(band.center.x, band.center.y  + 3.5)];
            break;
            
        case 188:
            [changeImage setCenter:CGPointMake(old.center.x , old.center.y  + 3.5)];
            break;
            
            
        default:
            break;
    }
    
    [UIView commitAnimations];

    if(_myicid==0)
    {
        NSArray *favViews = [MusicFav findCollect];
        
        [favArray removeAllObjects];
        
        for (id fav in favViews) {
            
            [favArray addObject:fav];
            
        }
        
    }
    
    else
    {
        NSArray *favViews = [MusicFav findCollectbyicid:_myicid];
        
        [favArray removeAllObjects];
        
        for (id fav in favViews) {
            
            [favArray addObject:fav];
            
        }
    }
    
    [musicsTableView reloadData];
}
//-(UIButton*)getSearchBarCancelButton{
//    
//    UIButton* btn=nil;
//    
//    for(UIView* v in search.subviews) {
//        
//        if ([v isKindOfClass:UIButton.class]) {
//            
//            btn=(UIButton*)v;
//            
//            break;
//            
//        }
//        
//    }
//    
//    return btn;
//    
//}

- (void)doSearch
{
    self.navigationController.navigationBarHidden = YES;
    
    if (isiPhone) {
        [search setFrame:CGRectMake(0, 0, 320, 50)];
//        [old setFrame:CGRectMake(256, 50, 64, 37)];
//        [man setFrame:CGRectMake(64, 50, 64, 37)];
//        [woman setFrame:CGRectMake(128, 50, 64, 37)];
//        [all setFrame:CGRectMake(0, 50, 64, 37)];
//        [band setFrame:CGRectMake(192, 50, 64, 37)];
//        [bg setFrame:CGRectMake(0, -68, 320, 480)];
        [chView setFrame:CGRectMake(0, 48, 320, 40)];
        [contentImg setFrame:CGRectMake(9, 88, 302, self.view.frame.size.height-95)];

        [musicsTableView setFrame:CGRectMake(10, 88, 300, self.view.frame.size.height-55-50)];
    }else {
        [musicsTableView setFrame:CGRectMake(22, 64+44, 724, 821)];
        [chView setFrame:CGRectMake(0, 64-2, 768, 46)];
        [contentImg setFrame:CGRectMake(20, 44+64, 728, 847)];
        [search setFrame:CGRectMake(0, 20, 768, 44)];
    }
    
    
    [search setHidden:NO];
//    
//    UIButton* btn=[self getSearchBarCancelButton];
//    
//    if (btn!=nil) {
//        
//        [btn setMultipleTouchEnabled:YES];
//        
//    } 
}

#pragma mark - View lifecycle
- (void) viewWillAppear:(BOOL)animated {
    
//    search.showsCancelButton = YES;
    
    [search setPlaceholder:kColOne];
    
    self.navigationController.navigationBarHidden = NO;
    
    [musicsTableView setUserInteractionEnabled:YES];
    
    if (isiPhone) {
        [musicsTableView setFrame:CGRectMake(10, 38, 300, self.view.frame.size.height-55)];
//        [old setFrame:CGRectMake(256, 0, 64, 37)];
//        [man setFrame:CGRectMake(64, 0, 64, 37)];
//        [woman setFrame:CGRectMake(128, 0, 64, 37)];
//        [all setFrame:CGRectMake(0, 0, 64, 37)];
//        [band setFrame:CGRectMake(192, 0, 64, 37)];
        [chView setFrame:CGRectMake(0, -2, 320, 40)];
        [contentImg setFrame:CGRectMake(9, 38, 302, self.view.frame.size.height-45)];

        [search setFrame:CGRectMake(0,0, 320, 44)];
    }else {
        [musicsTableView setFrame:CGRectMake(22, 44, 724, 821)];
        [chView setFrame:CGRectMake(0, -2, 768, 46)];
        [contentImg setFrame:CGRectMake(20, 44, 728, 847)];
        [search setFrame:CGRectMake(0, 0, 768, 44)];
    }
    
    
    
	[search setHidden:YES];
    
	[super viewWillAppear:animated];
    
	NSArray *favViews = [MusicFav findCollect];
    
	[favArray removeAllObjects];
    
	for (id fav in favViews) {
        
		[favArray addObject:fav];
        
	}
    
	[self.musicsTableView reloadData];
    
	[favViews release], favViews = nil;
}

- (void)viewDidLoad
{
    isiPhone = ![Constants isPad];
    
    search = [[UISearchBar alloc] init];
    
    search.delegate = self;
    if (isiPhone) {
        search.backgroundImage = [UIImage imageNamed:@"titleMain.png"];

    } else {
        search.backgroundImage = [UIImage imageNamed:@"titleMain@2x.png"];

    }
    
    search.backgroundColor = [UIColor clearColor];
    
    [search setTintColor:[UIColor colorWithRed:0 green:0 blue:1.0 alpha:1]];
    
    [self.view addSubview:search];
//    
//    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(doSearch)];
//    
//	self.navigationItem.leftBarButtonItem = searchButton;
    
    UIButton *imgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [imgBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"search"] ofType:@"png"]] forState:UIControlStateNormal];
    [imgBtn addTarget:self action:@selector(doSearch) forControlEvents:UIControlEventTouchUpInside];
    imgBtn.frame = CGRectMake(0, 0, 35, 40);
    UIBarButtonItem * searchButton = [[UIBarButtonItem alloc] initWithCustomView:imgBtn];
	self.navigationItem.leftBarButtonItem = searchButton;
    [searchButton release];
    

    self.navigationController.navigationBarHidden = NO;
    
    self.title = kColTwo;
    self.musicsArray=[[NSMutableArray alloc]init];
    if(_myicid==0)
    {
        self.favArray =[MusicFav findCollect];
        
    }
    
    else
    {
        self.favArray =[MusicFav findCollectbyicid:_myicid];
      
    }  //NSLog(@"%@",favArray);
    musicsTableView.delegate =self;
    musicsTableView.dataSource =self;    
    
    musicsTableView.delegate = self;
    
	musicsTableView.dataSource = self;
	
//	UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:kSearchTwo style:UIBarButtonItemStylePlain target:self action:@selector(doEdit)];
//    
//	self.navigationItem.rightBarButtonItem = editButton;
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

    
    
    
    //	NSLog(@"storeArray: %@",favArray);
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    self.musicsTableView = nil;
    
    [super viewDidUnload];
    
}

- (void)dealloc
{
    [self.musicsArray release];
    [self.favArray release];
    [self.search release];
    [self.HUD release];
    [self.musicsTableView release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) doEdit{
	
	[musicsTableView setEditing:!musicsTableView.editing animated:YES];
    
	if(musicsTableView.editing) {
        
//		self.navigationItem.rightBarButtonItem.title = kSearchOne;
    UIBarButtonItem *temp = self.navigationItem.rightBarButtonItem;
    UIButton *button = (UIButton *)[temp customView];
        [button setTitle:kSearchOne forState:UIControlStateNormal];
    }
	else {
        
//		self.navigationItem.rightBarButtonItem.title = kSearchTwo;
    UIBarButtonItem *temp = self.navigationItem.rightBarButtonItem;
    UIButton *button = (UIButton *)[temp customView];
    [button setTitle:kSearchTwo forState:UIControlStateNormal];
    }
}


#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView //明确cell数目
 numberOfRowsInSection:(NSInteger)section {
    return [self.favArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *FirstLevelCell= @"CollectCell";
    
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
    NSUInteger row = [indexPath row];
    
    MusicFav *fav = [favArray objectAtIndex:row];
    
    MusicView *music = [MusicView find:fav._iid];
    
    cell.myTitle.text = music._title;
    cell.mySinger.text =music._singer;
    
    //cell.myDate.text = voa._creatTime;
    
    //cell.collectDate.text = fav._date;
    
    //--------->设置内容换行
    [cell.myTitle setLineBreakMode:UILineBreakModeClip];
    
    //--------->设置最大行数
    [cell.myTitle setNumberOfLines:3];
    NSString *picName = [[NSString alloc] initWithFormat:@"image%@.jpg",music._pic];  
    cell.myImage.image=[UIImage imageNamed:picName];
    [picName release];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (isiPhone?80.0f:160.0f);
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{	
    MusicFav *fav = [favArray objectAtIndex:indexPath.row];
    
    NSFileManager *deleteFile = [NSFileManager defaultManager];
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];
    MusicView *nowmusic= [MusicView find:fav._iid];
    
    NSString *userPath = [audioPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", nowmusic._audio]];
    
    //    NSLog(@"yunsi:%@",userPath);
    
    NSError *error = nil;
    
	if ([deleteFile removeItemAtPath:userPath error:&error]) {
        //		NSLog(@"delete succeed");
	}
	
	[MusicFav deleteCollect:[fav _iid]];
    
	[favArray removeObjectAtIndex:indexPath.row];
    
	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (search.isFirstResponder) {
        
        [search resignFirstResponder];
        
        NSString *searchWords =  [self.search text];
        
        if (searchWords.length == 0) {
        }else
        {
            self.navigationController.navigationBarHidden = NO;
            
            if (isiPhone) {
                [musicsTableView setFrame:CGRectMake(10, 38, 300, self.view.frame.size.height-55)];
//                [old setFrame:CGRectMake(256, 65, 64, 37)];
//                [man setFrame:CGRectMake(64, 65, 64, 37)];
//                [woman setFrame:CGRectMake(128, 65, 64, 37)];
//                [all setFrame:CGRectMake(0, 65, 64, 37)];
//                [band setFrame:CGRectMake(192, 65, 64, 37)];
                [chView setFrame:CGRectMake(0, -2, 320, 40)];
                [contentImg setFrame:CGRectMake(9, 38, 302, self.view.frame.size.height-45)];

                
                [search setFrame:CGRectMake(0, 0, 320, 44)];
            }else {
                [musicsTableView setFrame:CGRectMake(22, 44, 724, 821)];
                [chView setFrame:CGRectMake(0, -2, 768, 46)];
                [contentImg setFrame:CGRectMake(20, 44, 728, 847)];
                [search setFrame:CGRectMake(0, 0, 768, 44)];//                [search setFrame:CGRectMake(0, 0, 768, 44)];
            }
            
            
            [search setHidden:YES];
            
            NSMutableArray *allMusicArray = favArray;
            
            NSMutableArray *contentsArray = nil;
            
            contentsArray = [MusicView findFavSimilar:allMusicArray search:searchWords];
            
            //            NSLog(@"count:%d", [contentsArray count]);
            
            if ([contentsArray count] == 0) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kColFour message:[NSString stringWithFormat:@"%@%@%@",kSearchThree,searchWords,kColThree] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil ];
                
                [alert show];
                
                [alert release];
                
            }else
            {
                self.search.text = @"";
                
                SearchViewController *searchController = [SearchViewController alloc];
                
                searchController._searchWords = searchWords;
                
                searchController._contentsArray = contentsArray;
                
                [self.navigationController pushViewController:searchController animated:YES];
            }
        }
    }else{
        if (!search.isHidden) {
            
            self.navigationController.navigationBarHidden = NO;
            
            if (isiPhone) {
                [musicsTableView setFrame:CGRectMake(10, 38, 300, self.view.frame.size.height-55)];
//                [old setFrame:CGRectMake(256, 0, 64, 37)];
//                [man setFrame:CGRectMake(64, 0, 64, 37)];
//                [woman setFrame:CGRectMake(128, 0, 64, 37)];
//                [all setFrame:CGRectMake(0, 0, 64, 37)];
//                [band setFrame:CGRectMake(192, 0, 64, 37)];
//                [bg setFrame:CGRectMake(0, -112, 320, 480)];
                [chView setFrame:CGRectMake(0, -2, 320, 40)];
                [contentImg setFrame:CGRectMake(9, 38, 302, self.view.frame.size.height-45)];

                [search setFrame:CGRectMake(0, 0, 320, 44)];           
            }else {
                [musicsTableView setFrame:CGRectMake(22, 44, 724, 821)];
                [chView setFrame:CGRectMake(0, -2, 768, 46)];
                [contentImg setFrame:CGRectMake(20, 44, 728, 847)];
                [search setFrame:CGRectMake(0, 0, 768, 44)];//                [bg setFrame:CGRectMake(0, -112, 768, 1024)];
            }
            
            
            [search setHidden:YES];
            
            search.text = @"";
        }else{
            
            NSUInteger row = [indexPath row];
            
            MusicFav *fav = [favArray objectAtIndex:row];
            
            HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
            
            HUD.dimBackground = YES;
            
            HUD.labelText = @"Connecting...";
            
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{  
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [musicsArray removeAllObjects];
                    for(int nowrow =0;nowrow<[favArray count];nowrow++)
                    {
                        MusicFav *fav2 =[favArray objectAtIndex:nowrow];
                        MusicView *music=[MusicView find:fav2._iid];
                        [musicsArray addObject:music];
                    }
                    MusicView *music = [MusicView find:fav._iid];
//                    NSLog(@"selected:%d",fav._iid);
                    PlayViewController *play = [PlayViewController sharedPlayer];//新建新界面的controller实例
                    if(play.music ._iid == music._iid)
                    {
                        play.newFile = NO;
                    }else
                    {
                        play.newFile = YES;
                        play.music = music;
                        play.nowPlayRow=row;
                        play.musicsArray=[musicsArray copy];
                    }
                    [play setHidesBottomBarWhenPushed:YES];//设置推到新界面时无bottomBar
                    [self.navigationController pushViewController:play animated:NO];
                    [HUD hide:YES];
                });  
            }); 
            
        }
    }
}

#pragma mark -
#pragma mark UISearchBar Delegate Methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [search resignFirstResponder];
    NSString *searchWords =  [self.search text];
    if (searchWords.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kColFour message:kColFive delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil, nil ];
        [alert show];
        [alert release];
    }else
    {
        self.navigationController.navigationBarHidden = NO;
        
        if (isiPhone) {
            [musicsTableView setFrame:CGRectMake(10,38, 300, self.view.frame.size.height-55)];
//            [old setFrame:CGRectMake(256, 0, 64, 37)];
//            [man setFrame:CGRectMake(64, 0, 64, 37)];
//            [woman setFrame:CGRectMake(128, 0, 64, 37)];
//            [all setFrame:CGRectMake(0,0, 64, 37)];
//            [band setFrame:CGRectMake(192, 0, 64, 37)];
//            [bg setFrame:CGRectMake(0, -68, 320, 480)];
            [chView setFrame:CGRectMake(0, -2, 320, 40)];
            [contentImg setFrame:CGRectMake(9, 38, 302, self.view.frame.size.height-45)];

            [search setFrame:CGRectMake(0, 0, 320, 44)];
        }else {
            [musicsTableView setFrame:CGRectMake(22, 44, 724, 821)];
            [chView setFrame:CGRectMake(0, -2, 768, 46)];
            [contentImg setFrame:CGRectMake(20, 44, 728, 847)];
            [search setFrame:CGRectMake(0, 0, 768, 44)];
//            [bg setFrame:CGRectMake(0, -68, 768, 1024)];
           
        }
        [search setHidden:YES];
        NSMutableArray *allMusicArray = favArray;
        
        HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
        HUD.dimBackground = YES;
        HUD.labelText = @"Connecting...";
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{  
            
            dispatch_async(dispatch_get_main_queue(), ^{  
                NSMutableArray *contentsArray = nil;
                contentsArray = [MusicView findFavSimilar:allMusicArray search:searchWords];
                //                NSLog(@"count:%d", [contentsArray count]);
                
                if ([contentsArray count] == 0) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kColFour message:[NSString stringWithFormat:@"%@%@%@",kSearchThree,searchWords,kColThree] delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil, nil ];
                    [alert show];
                    [alert release];
                }else
                {
                    self.search.text = @"";
                    SearchViewController *searchController = [[SearchViewController alloc]init];
                    searchController.navigationItem.hidesBackButton=YES;
                    searchController._searchWords = searchWords;
                    searchController._contentsArray = contentsArray;
                    searchController.searchFlg = 11;
                    [self.navigationController pushViewController:searchController animated:YES];
                }
                [HUD hide:YES];
            });  
        }); 
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    self.navigationController.navigationBarHidden = NO;
    
    if (isiPhone) {
        [musicsTableView setFrame:CGRectMake(10, 38, 300, self.view.frame.size.height-55)];
//        [old setFrame:CGRectMake(256, 0, 64, 37)];
//        [man setFrame:CGRectMake(64, 0, 64, 37)];
//        [woman setFrame:CGRectMake(128, 0, 64, 37)];
//        [all setFrame:CGRectMake(0, 0, 64, 37)];
//        [band setFrame:CGRectMake(192,0, 64, 37)];
//        [bg setFrame:CGRectMake(0, -112, 320, 480)];
        [chView setFrame:CGRectMake(0, -2, 320, 40)];
        [contentImg setFrame:CGRectMake(9, 38, 302, self.view.frame.size.height-45)];

        [search setFrame:CGRectMake(0, 0, 320, 44)];
    }else {
        [musicsTableView setFrame:CGRectMake(22, 44, 724, 821)];
        [chView setFrame:CGRectMake(0, -2, 768, 46)];
        [contentImg setFrame:CGRectMake(20, 44, 728, 847)];
        [search setFrame:CGRectMake(0, 0, 768, 44)];
//        [bg setFrame:CGRectMake(0, -112, 768, 1024)];
    }
    [search setHidden:YES];
    search.text = @"";
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!search.isHidden) {
        self.navigationController.navigationBarHidden = NO;
        
        if (isiPhone) {
            [musicsTableView setFrame:CGRectMake(10, 38, 300, self.view.frame.size.height-55)];
//            [old setFrame:CGRectMake(256, 0, 64, 37)];
//            [man setFrame:CGRectMake(64, 0, 64, 37)];
//            [woman setFrame:CGRectMake(128, 0, 64, 37)];
//            [all setFrame:CGRectMake(0, 0, 64, 37)];
//            [band setFrame:CGRectMake(192, 0, 64, 37)];
//            [bg setFrame:CGRectMake(0, -112, 320, 480)];
            [chView setFrame:CGRectMake(0, -2, 320, 40)];
            [contentImg setFrame:CGRectMake(9, 38, 302, self.view.frame.size.height-45)];

            [search setFrame:CGRectMake(0, 0, 320, 44)];      
        }else {
            [musicsTableView setFrame:CGRectMake(22, 44, 724, 821)];
            [chView setFrame:CGRectMake(0, -2, 768, 46)];
            [contentImg setFrame:CGRectMake(20, 44, 728, 847)];
            [search setFrame:CGRectMake(0, 0, 768, 44)];
                   }
        [search setHidden:YES];
        search.text = @"";
    }
}
@end
