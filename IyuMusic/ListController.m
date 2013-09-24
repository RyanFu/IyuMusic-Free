//
//  AllController.m
//  IyuMusic
//
//  Created by iyuba on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ListController.h"
#import "database.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )



@implementation ListController


@synthesize musicsArray;
@synthesize musicsTableView;
//@synthesize nowSection;
//@synthesize lastId;
//@synthesize nowId;
//@synthesize addNum;
//@synthesize addNumTwo;
//@synthesize pageNum;
@synthesize all;
@synthesize man;
@synthesize woman;
@synthesize band;
@synthesize old;
@synthesize search;
//@synthesize bg;
@synthesize HUD;
@synthesize changeImage;
@synthesize chView;
@synthesize contentImg;

extern NSMutableArray *downLoadList;
extern ASIHTTPRequest *nowrequest;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
//    NSLog(@"1");
    isiPhone =![Constants isPad];
    if(isiPhone){
        self = [super initWithNibName:@"ListController" bundle:nibBundleOrNil];
    }else{
        self = [super initWithNibName:@"ListController-ipad" bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
    }
    return self;

}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

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
        self.musicsArray = [MusicView findAll];
    }
    else
    {
       // NSLog(@"%d",_myicid);   
    self.musicsArray  =[MusicView findByicid:_myicid];
    
}
    
    [musicsTableView reloadData];
   // NSLog(@"%@", musicsArray);
}

#pragma mark - My Action
-(void)doReturn
{
    HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
    HUD.dimBackground = YES;
    HUD.labelText = @"Connecting...";
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{  
        
        dispatch_async(dispatch_get_main_queue(), ^{  
            PlayViewController *play = [PlayViewController sharedPlayer];//新建新界面的controller实例
            if(play.music._iid > 0 )
            {
                play.newFile = NO;
            }else
            {
                play.newFile = YES;
                NSInteger iid = [[[NSUserDefaults standardUserDefaults] objectForKey:@"lastPlay"] integerValue];
                if (iid > 0) {
                    play.music = [MusicView find:iid];
                }else
                {
                    play.music = [MusicView find:1289];
                }
                play.musicsArray=musicsArray;
            }
            [play setHidesBottomBarWhenPushed:YES];//设置推到新界面时无bottomBar
            [self.navigationController pushViewController:play animated:NO]; 
            [HUD hide:YES];
        });  
    });

}
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
        [chView setFrame:CGRectMake(0, 48, 320, 40)];
        [contentImg setFrame:CGRectMake(9, 88, 302, self.view.frame.size.height-95)];
//        [changeImage setFrame:CGRectMake(changeImage.frame.origin.x, changeImage.frame.origin.y, changeImage.frame.size.width, changeImage.frame.size.height)];
//        [bg setFrame:CGRectMake(0, -68, 320, 480)];
        [musicsTableView setFrame:CGRectMake(10, 88, 300, self.view.frame.size.height-55-50)];
    }else {
        [search setFrame:CGRectMake(0, 20, 768, 44)];
        [musicsTableView setFrame:CGRectMake(22, 44+64, 724, 821)];
        [chView setFrame:CGRectMake(0, 62, 768, 46)];
        [contentImg setFrame:CGRectMake(20, 44+64, 728, 847)];
    }
    
    [search setHidden:NO];
}
#pragma mark - View lifecycle
-(void)viewDidAppear:(BOOL)animated
{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"alertShowed"]==NO) {
        downLoadList = [MusicView findDownloading];
        if ([downLoadList count]!=0) {
            UIActionSheet *downLoadSheet = [[UIActionSheet alloc] initWithTitle:@"检测到您之前有未下载完成的任务" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"继续下载",@"下次再说",@"拒绝", nil];
            [downLoadSheet showInView:self.view.window];
            
        }
    }
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"alertShowed"];

}
-(void)viewWillAppear:(BOOL)animated{
   // [self catchNetA];
    
       [self.musicsTableView reloadData];
    self.navigationController.navigationBarHidden=NO;
//    NSLog(@"view:%f",self.view.frame.size.height);
    [musicsTableView setUserInteractionEnabled:YES];
    if(isiPhone){
        [musicsTableView setFrame:CGRectMake(10, 38, 300, self.view.frame.size.height-55)];
        [chView setFrame:CGRectMake(0, -2, 320, 40)];
        [contentImg setFrame:CGRectMake(9, 38, 302,(IS_IPHONE_5? 410:410-88))];
        [search setFrame:CGRectMake(0,0, 320, 44)];
        }
    else {
        [musicsTableView setFrame:CGRectMake(22, 44, 724, self.view.frame.size.height-90)];
        [chView setFrame:CGRectMake(0, -2, 768, 46)];
        [contentImg setFrame:CGRectMake(20, 44, 728, 847)];
        [search setFrame:CGRectMake(0, 0, 768, 44)];
        }
    [search setBackgroundColor:[UIColor clearColor]];
    [search setHidden:YES];
    
}
- (void)viewDidLoad
{
    
    isExistNet =NO;
    isiPhone =![Constants isPad];
    
    musicsArray=[[NSMutableArray alloc]init];
    
    search =[[UISearchBar alloc]init];
    search.delegate =self;
    [self.view addSubview:search];
    UIButton *imgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [imgBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"search"] ofType:@"png"]] forState:UIControlStateNormal];
    [imgBtn addTarget:self action:@selector(doSearch) forControlEvents:UIControlEventTouchUpInside];
    imgBtn.frame = CGRectMake(0, 0, 35,40);
    UIBarButtonItem * editButton = [[UIBarButtonItem alloc] initWithCustomView:imgBtn];
	self.navigationItem.leftBarButtonItem = editButton;
    [editButton release];
    UIButton * imgBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [imgBtn2 setImage:[UIImage imageWithContentsOfFile:
								[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"returnPlay"] ofType:@"png"]] 
					  forState:UIControlStateNormal];
	[imgBtn2 setTitle:kNewTwo forState:UIControlStateNormal];
	imgBtn2.titleLabel.font=[UIFont systemFontOfSize:12];
    [imgBtn2 addTarget:self action:@selector(doReturn) forControlEvents:UIControlEventTouchUpInside];
    imgBtn2.frame = CGRectMake(0, 0, 35, 40);
    UIBarButtonItem * backbutton = [[UIBarButtonItem alloc] initWithCustomView:imgBtn2];
    self.navigationItem.rightBarButtonItem = backbutton;
	self.navigationItem.hidesBackButton = YES;
	[backbutton release];

    if (isiPhone) {
        search.backgroundImage =[UIImage imageNamed:@"titleMain.png"];
    } else {
        search.backgroundImage =[UIImage imageNamed:@"titleMain@2x.png"];
    }
    
    
    self.title=kNewThree;
    //static dispatch_once_t onceToken;
    //NSLog(@"%d",_myicid);
    if(_myicid==0) {
        NSArray *musics = [MusicView findAll];
        for (MusicView *music in musics) {
            [musicsArray addObject:music];
//            NSLog(@"music:%@", music._title);
        }
        [musics release];
    }
        
    else{
        musicsArray  =[MusicView findByicid:_myicid];
    }
    musicsTableView.delegate =self;
    musicsTableView.dataSource =self;
    
    [super viewDidLoad];
              
}


- (void)viewDidUnload
{
    self.musicsTableView=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)dealloc
{
    [self.musicsArray release];
    [self.musicsTableView release];
    [self.search release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark Table Data Source Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.musicsArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"flush");
    static NSString *FirstLevelCell = @"ListCell";
    MusicViewCell *cell = (MusicViewCell *)[tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
    if(!cell){
        if (isiPhone) {
            cell =(MusicViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"MusicViewCell" owner:self options:nil]objectAtIndex:0];
            
        }else {
            cell =(MusicViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"MusicViewCell-ipad" owner:self options:nil]objectAtIndex:0];
        }
        
    }
    
    NSUInteger row =[indexPath row];
   //MusicView *list =[musicsArray objectAtIndex:row];
    MusicView *music =[musicsArray objectAtIndex:row];
//    NSLog(@"%@", music);
    cell.myTitle.text= music._title;
    cell.mySinger.text = music._singer;
    
    //---------->设置内容换行
//    [cell.myTitle setLineBreakMode:UILineBreakModeClip];
//    [cell.mySinger setLineBreakMode:UILineBreakModeClip];
    //[cell.myTitle setTextColor:[UIColor colorWithRed:0 green:232.0/255 blue:1 alpha:1]];
    //[cell.mySinger setTextColor:(UIColor *)@"#00d8ff"];
    //---------->设置最大行数
    [cell.myTitle setNumberOfLines:1];
    [cell.mySinger setNumberOfLines:1];
    
    NSString *picName = [[NSString alloc] initWithFormat:@"image%@.jpg",music._pic];  
    cell.myImage.image=[UIImage imageNamed:picName];
    [picName release];
    if (isiPhone) {
        cell.downloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(255, 23, 33, 33)];
    } else {
        cell.downloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(620, 40, 63, 63)];
    }
    if ([MusicFav isCollected:music._iid]) {
        [cell.downloadBtn setHidden:YES];
        [cell.aftImage setHidden:NO];
    }else {
        [cell.aftImage setHidden:YES];
        [cell.downloadBtn setTag:music._iid];
        int i=0;
        for (; i<[downLoadList count]; i++) {
            int downloadid = [[downLoadList objectAtIndex:i]intValue];
            if (downloadid ==music._iid) {
                break;
            }
        }
        if (i<[downLoadList count]) {
        if (music._iid == nowrequest.tag){
        [cell.downloadBtn addTarget:self action:@selector(WaitingBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
            if (isiPhone) {
                cell.progress=[[DACircularProgressView alloc]initWithFrame:CGRectMake(253, 21, 37, 37)];
                [cell.downloadBtn setImage:[UIImage imageNamed:@"stopdl.png"] forState:UIControlStateNormal];
            } else {
                cell.progress=[[DACircularProgressView alloc]initWithFrame:CGRectMake(616, 36, 71, 71)];
                [cell.downloadBtn setImage:[UIImage imageNamed:@"stopdl@2x.png"] forState:UIControlStateNormal];
            }
        
        nowrequest.downloadProgressDelegate = cell.progress;
        [nowrequest updateDownloadProgress];
        [cell addSubview:cell.progress];

        }else{
            [cell.downloadBtn addTarget:self action:@selector(WaitingBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            if (isiPhone) {
                 [cell.downloadBtn setImage:[UIImage imageNamed:@"waiting.png"] forState:UIControlStateNormal];
            } else {
                 [cell.downloadBtn setImage:[UIImage imageNamed:@"waiting@2x.png"] forState:UIControlStateNormal];
            }
           
        }
        }else{
            if (isiPhone) {
                 [cell.downloadBtn setImage:[UIImage imageNamed:@"dl.png"] forState:UIControlStateNormal];
            } else {
                 [cell.downloadBtn setImage:[UIImage imageNamed:@"dl@2x.png"] forState:UIControlStateNormal];
            }
       
        [cell.downloadBtn addTarget:self action:@selector(QueueDownloadMusicBtn:) forControlEvents:UIControlEventTouchUpInside];
       }
    }
    [cell addSubview:cell.downloadBtn];
     //    cell.downloadBtn addTarget:self action: forControlEvents:
    cell.tag = music._iid;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
                     
}
#pragma mark Table View Delegate Methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (isiPhone?80.0f:160.0f);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
                [search setFrame:CGRectMake(0, 0, 320, 44)];
                [contentImg setFrame:CGRectMake(9, 38, 302, self.view.frame.size.height-45)];

            }else {
                [musicsTableView setFrame:CGRectMake(22, 44, 724, 821)];
                [chView setFrame:CGRectMake(0, -2, 768, 46)];
                [contentImg setFrame:CGRectMake(20, 44, 728, 847)];
                [search setFrame:CGRectMake(0, 0, 768, 44)];

            }
            
            
            [search setHidden:YES];
            
            NSMutableArray *allMusicArray = musicsArray;
            
            NSMutableArray *contentsArray = nil;
            
            contentsArray = [MusicView findSimilar:allMusicArray search:searchWords];
            
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
                
                searchController._contentsSrArray = contentsArray;
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
                [search setFrame:CGRectMake(0, 0, 768, 44)];

            }
            
            
            [search setHidden:YES];
            
            search.text = @"";
        }else{
            
            NSUInteger row = [indexPath row];
            
            MusicView *selected = [musicsArray objectAtIndex:row];
            
//            HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
            HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
            [[UIApplication sharedApplication].keyWindow addSubview:HUD];
            HUD.delegate = self;
            
            HUD.labelText = @"Connecting...";
            
            HUD.dimBackground = YES;
            [HUD show:YES];
            
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                
                dispatch_async(dispatch_get_main_queue(), ^{  
                MusicView *music = [MusicView find:selected._iid];
                PlayViewController *play = [PlayViewController sharedPlayer];//新建新界面的controller实例
                    if(play.music._iid == music._iid)
                    {
                        play.newFile = NO;
                    }else
                    {
//                        [play.musicsArray removeAllObjects];
//                        for (MusicView *music in musicsArray) {
//                            [play.musicsArray addObject:music];
//                            NSLog(@"music:%@", music._title);
//                        }

                        play.musicsArray=[musicsArray copy];
                        play.nowPlayRow =row;
                        play.newFile = YES;
                        play.music = music;
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
    [searchBar resignFirstResponder];
    NSString *searchWords =  [searchBar text];
//    NSLog(@"%@",searchWords);
    if (searchWords.length == 0) {
    }else
    {
        self.navigationController.navigationBarHidden = NO;
        if (isiPhone) {
            [musicsTableView setFrame:CGRectMake(10,38, 300, self.view.frame.size.height-55)];
//            [old setFrame:CGRectMake(256, 0, 64, 37)];
//            [man setFrame:CGRectMake(64, 0, 64, 37)];
//            [woman setFrame:CGRectMake(128,0, 64, 37)];
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

        }
        [search setHidden:YES];
        NSMutableArray *allMusicArray =[MusicView findAll];
        HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
        HUD.dimBackground = YES;
        HUD.labelText = @"Connecting...";
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{  
            dispatch_async(dispatch_get_main_queue(), ^{  
                NSMutableArray *contentsArray =nil;
                contentsArray = [MusicView findSimilar:allMusicArray search:searchWords];
                if ([contentsArray count]==0) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kColFour message:[NSString stringWithFormat:@"%@%@%@",kSearchThree,searchWords,kColThree] delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil, nil ];
                    [alert show];
                    [alert release];
                        } else {
                            searchBar.text = @"";
                            SearchViewController *searchController = [[SearchViewController alloc]init];
                            searchController.navigationItem.hidesBackButton=YES;
                            searchController._searchWords = searchWords;
                            searchController._contentsSrArray=contentsArray;
                            searchController.searchFlg = 0;
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
//        [old setFrame:CGRectMake(256, 0, 64, 37)];
//        [man setFrame:CGRectMake(64, 0, 64, 37)];
//        [woman setFrame:CGRectMake(128, 0, 64, 37)];
//        [all setFrame:CGRectMake(0, 0, 64, 37)];
//        [band setFrame:CGRectMake(192, 0, 64, 37)];
//        [bg setFrame:CGRectMake(0, -112, 320, 480)];

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


#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:// 继续下载 取出存在数组中
            kNetTest;
            [self QueueDownloadMusic];
            break;
        case 1://下次再说 数据库不动，不保存在数组中
            [downLoadList removeAllObjects];
            break;
        case 2://拒绝 数据库中删除
            [MusicView clearAllDownload];
            [downLoadList removeAllObjects];
            break;
        default:
            break;
    }
}

#pragma mark - Http connect
- (void)QueueDownloadMusic
{
    // NSLog(@"Queue 预备: %d",music._iid);
    NSOperationQueue *myQueue = [PlayViewController sharedQueue];
//    int downLoadNum = [[NSUserDefaults standardUserDefaults]integerForKey:@"downLoadNum"];
//    [myQueue setMaxConcurrentOperationCount:downLoadNum];
    [myQueue setMaxConcurrentOperationCount:1];

    for (int i=0; i<[downLoadList count]; i++) {
        MusicView *music = [MusicView find:[[downLoadList objectAtIndex:i]intValue]];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://static2.iyuba.com/go/musichigh/%@", music._audio]];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setDelegate:self];
        [request setTag:music._iid];
        [request setDidStartSelector:@selector(requestSoundStarted:)];
        [request setDidFinishSelector:@selector(requestSoundDone:)];
        [request setDidFailSelector:@selector(requestSoundWentWrong:)];
        [myQueue addOperation:request]; //queue is an NSOperationQueue
    }
    [self.musicsTableView reloadData];
    
}

//下载按钮按下之后
- (void)QueueDownloadMusicBtn:(UIButton *)sender
{
    // NSLog(@"Queue 预备: %d",music._iid);
    
    //数据库中加入下载
    [MusicView alterDownload:sender.tag];
    //数组中标记加入正在下载
    [downLoadList addObject:[NSNumber numberWithInt:sender.tag]];
    //修改button功能为等待
    [sender removeTarget:self action:@selector(QueueDownloadMusicBtn:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget:self action:@selector(WaitingBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    //修改button图片为等待
    if (isiPhone) {
        [sender setImage:[UIImage imageNamed:@"waiting.png"] forState:UIControlStateNormal];

    } else {
        [sender setImage:[UIImage imageNamed:@"waiting@2x.png"] forState:UIControlStateNormal];

    }
    
    //加入下载队列
    NSOperationQueue *myQueue = [PlayViewController sharedQueue];
    [myQueue setMaxConcurrentOperationCount:1];
     MusicView *music=[MusicView find:sender.tag];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://static2.iyuba.com/go/musichigh/%@",music._audio]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setTag:music._iid];
    [request setDidStartSelector:@selector(requestSoundStarted:)];
    [request setDidFinishSelector:@selector(requestSoundDone:)];
    [request setDidFailSelector:@selector(requestSoundWentWrong:)];
    [myQueue addOperation:request]; //queue is an NSOperationQueue
    
}
//取消下载
-(void)WaitingBtnPressed:(UIButton *)sender{
    //数据库中标记去掉
    [MusicView clearDownload:sender.tag];
    
    //数组中去掉
    for (int i =0; i<[downLoadList count]; i++) {
        if ([[downLoadList objectAtIndex:i]intValue]==sender.tag) {
            [downLoadList removeObjectAtIndex:i];
            break;
        }
    }
    //下载队列中去掉
    NSOperationQueue *myQueue = [PlayViewController sharedQueue];
    for (ASIHTTPRequest *request in [myQueue operations]) {
        if ([request isKindOfClass:[ASIHTTPRequest class]]&&request.tag==sender.tag) {
            [request clearDelegatesAndCancel];
            //            [request cancel];
        }
    }
    //修改按钮功能 图片
    [sender removeTarget:self action:@selector(WaitingBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget:self action:@selector(QueueDownloadMusicBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (isiPhone) {
        [sender setImage:[UIImage imageNamed:@"dl.png"] forState:UIControlStateNormal];

    } else {
        [sender setImage:[UIImage imageNamed:@"dl@2x.png"] forState:UIControlStateNormal];

    }
        //如果是正在下载的，去掉进度条
    if (nowrequest.tag ==sender.tag) {
        
    MusicView *music;
    NSInteger index;
    index = -1;
    for (int i= 0; i<[musicsArray count]; i++) {
        music = [musicsArray objectAtIndex:i];
        if (music._iid==sender.tag) {
            index = i;
            break;
        }
    }
    if (index != -1) {
            MusicViewCell *cell = (MusicViewCell *)[self.musicsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
            [cell.progress setHidden:YES];
            [cell.progress release];

        }
    }
}


- (void)requestSoundStarted:(ASIHTTPRequest *)request
{
    nowrequest = request;//把开始下载的赋值给全局变量
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    //创建audio份目录在Documents文件夹下，not to back up
	NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];
    MusicView *nowmusic=[MusicView find:request.tag];
   NSString  *userPath = [audioPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@", nowmusic._audio]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:userPath]) {
        [request cancel];
    }
    MusicView *music;
    NSInteger index;
    index = -1;
    for (int i= 0; i<[musicsArray count]; i++) {
        music = [musicsArray objectAtIndex:i];
        if (music._iid==request.tag) {
            index = i;
            break;
        }
    }
    if (index != -1) {
        MusicViewCell *cell = (MusicViewCell *)[self.musicsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        if (isiPhone) {
            [cell.downloadBtn setImage:[UIImage imageNamed:@"stopdl.png"] forState:UIControlStateNormal];
            cell.progress=[[DACircularProgressView alloc]initWithFrame:CGRectMake(253, 21, 37, 37)];
        } else {
            [cell.downloadBtn setImage:[UIImage imageNamed:@"stopdl@2x.png"] forState:UIControlStateNormal];
            cell.progress=[[DACircularProgressView alloc]initWithFrame:CGRectMake(616, 36, 71, 71)];
        }
        
        //    [cell.progress setTrackTintColor:[UIColor yellowColor]];
        request.downloadProgressDelegate = cell.progress;
        [request updateDownloadProgress];
        [cell insertSubview:cell.progress belowSubview:cell.downloadBtn];
        

    }
        
    //[MusicView alterDownload:request.tag];
    // NSLog(@"Queue 开始: %d",request.tag);
}


- (void)requestSoundDone:(ASIHTTPRequest *)request{
    kNetEnable;
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    //创建audio份目录在Documents文件夹下，not to back up
	NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];
	NSFileManager *fm = [NSFileManager defaultManager];
    MusicView *nowmusic=[MusicView find:request.tag];
   NSString *userPath = [audioPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", nowmusic._audio]];
    NSData *responseData = [request responseData];
    //    NSLog(@"requestFinished。大小：%d", [responseData length]);
	if ([fm createFileAtPath:userPath contents:responseData attributes:nil]) {
	}
//    if (request.tag == music._iid) {
//        localFileExist = YES;
//        downloaded = YES;
//        [downloadFlg setHidden:NO];
//        [collectButton setHidden:YES];
//        [downloadingFlg setHidden:YES];
//    }
    // MusicView *nowmusic=[MusicView find:request.tag];
    MusicView *music;
    NSInteger index;
    index = -1;
    for (int i= 0; i<[musicsArray count]; i++) {
        music = [musicsArray objectAtIndex:i];
        if (music._iid==request.tag) {
            index = i;
            break;
        }
    }

    if (index != -1) {
        MusicViewCell *cell = (MusicViewCell *)[self.musicsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        [cell.downloadBtn setHidden:YES];
        [cell.progress setHidden:YES];
        [cell.downloadBtn release];
        [cell.progress release];
        [cell.aftImage setHidden:NO];
                
    }
    //数据库中标记去掉
    [MusicView clearDownload:request.tag];
    
    //数组中去掉
    for (int i =0; i<[downLoadList count]; i++) {
        if ([[downLoadList objectAtIndex:i]intValue]==request.tag) {
            [downLoadList removeObjectAtIndex:i];
            break;
        }
    }
    [MusicFav alterCollect:request.tag  icid:nowmusic._icid];
    [fm release];
   
    //[MusicView clearDownload:request.tag];
}

- (void)requestSoundWentWrong:(ASIHTTPRequest *)request
{
    kNetTest;
    //数据库中标记去掉
    [MusicView clearDownload:request.tag];
    //数组中标记去掉
    for (int i =0; i<[downLoadList count]; i++) {
        if ([[downLoadList objectAtIndex:i]intValue]==request.tag) {
            [downLoadList removeObjectAtIndex:i];
            break;
        }
    }
    MusicView *nowmusic=[MusicView find:request.tag];
    UIAlertView *netAlert = [[UIAlertView alloc] initWithTitle:kPlayFive message:[NSString stringWithFormat:@"%@%@", nowmusic._audio,kPlayFive] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    if (request.tag == music._iid) {
//        [collectButton setHidden:NO];
//        [downloadingFlg setHidden:YES];
//    }
    MusicView *music;
    NSInteger index;
    index = -1;
    for (int i= 0; i<[musicsArray count]; i++) {
        music = [musicsArray objectAtIndex:i];
        if (music._iid==request.tag) {
            index = i;
            break;
        }
    }
    if (index != -1) {
        //去掉进度条
        MusicViewCell *cell = (MusicViewCell *)[self.musicsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        [cell.progress setHidden:YES];
        [cell.progress release];
        [netAlert show];
        [netAlert release];
        //修改按钮功能 图片
        [cell.downloadBtn removeTarget:self action:@selector(WaitingBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.downloadBtn addTarget:self action:@selector(QueueDownloadMusicBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (isiPhone) {
            [cell.downloadBtn setImage:[UIImage imageNamed:@"dl.png"] forState:UIControlStateNormal];
        } else {
            [cell.downloadBtn setImage:[UIImage imageNamed:@"dl@2x.png"] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - PlayerRequestDelegate
- (void)afterDownload {
    [musicsTableView reloadData];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods
/**
 *  MBProgressHUDDelegate需要实现的函数
 */
- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    [HUD release];
	HUD = nil;
}

@end
