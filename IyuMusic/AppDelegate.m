//
//  AppDelegate.m
//  IyuMusic
//
//  Created by iyuba on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON ) 

@implementation AppDelegate

@synthesize windowOne;
@synthesize windowTwo;
@synthesize rootControllerOne;
@synthesize rootControllerTwo;

extern NSMutableArray *downLoadList;
//- (void)scrollViewDidScroll:(UIScrollView *)scrollViews {
//	
//	int page = floor((scrollViews.contentOffset.x - 320 / 4) / 320) + 1;
//	if (pageControlUsed)
//    {
//        // do nothing - the scroll was initiated from the page control, not the user dragging
//        return;
//    }
//    pageControl.currentPage = page;
//	
//	if (page > 5) {
//		//NSLog(@"dsdasdad");
//		[myView removeFromSuperview];
//	}
//}
// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollViews
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollViews
{
    pageControlUsed = NO;
}


-(IBAction)changePage:(id)sender
{
    int page = pageControl.currentPage;
    CGRect frame = scrollView.frame;
    frame.origin.x=frame.size.width *page;
    frame.origin.y=0;
    [scrollView scrollRectToVisible:frame animated:YES];
    pageControlUsed=YES;
}


void uncaughtExceptionHandler(NSException *exception){
    [Flurry logError:@"Uncaught" message:@"Crash" exception:exception];
}
 


- (void)dealloc
{
   
    if ([Constants isPad]) {
        [rootControllerTwo release];
        [windowTwo release];
        } else {
                [rootControllerOne release];
                 [windowOne release];
            }

    [pageControl release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
      NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [Flurry startSession:@"3ZKXVB45MCM5P8ZTN6V2"];
    kNetTest;
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"alertShowed"];
    if ([Constants isPad]) {
        UIImageView *img =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg@2x.png"]];
        img.frame=self.windowTwo.frame;
        self.rootControllerTwo.wantsFullScreenLayout=YES;
        [self.windowTwo addSubview:img];
        [img release],img=nil;
        [self.windowTwo addSubview:rootControllerTwo.view];
//        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-ipad.png"]];
//        img.frame = CGRectMake(0, 0, 768, 1024);
//        [self.windowTwo insertSubview:img atIndex:0];
//        [img release];
        //针对2.0版本之前没有在程序里设置版本号 修改2.3版本数据库中出现歌词错误信息
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"appVersionC"] == nil)
        {
            [[NSUserDefaults standardUserDefaults]setFloat:2.4f forKey:@"appVersionC"];
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            //创建audio份目录在Documents文件夹下，not to back up
            NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];
            if ([fileManager fileExistsAtPath:audioPath] == YES)
            {
                NSString *realPath = [audioPath stringByAppendingPathComponent:@"mydatabase.sqlite"];
                if ([fileManager fileExistsAtPath:realPath]) {
                
                    NSFileManager *deleteFile = [NSFileManager defaultManager];
                    //    NSLog(@"yunsi:%@",userPath)
                    NSError *error = nil;
                    
                    if ([deleteFile removeItemAtPath:realPath error:&error]) {
                        //		NSLog(@"delete succeed");
                    }
                }
            }
        }//针对2.0－2.2版本程序里设置版本号 修改2.3版本数据库中出现歌词错误信息
        else if ([[NSUserDefaults standardUserDefaults]floatForKey:@"appVersionC"]!= 2.4f){
            [[NSUserDefaults standardUserDefaults]setFloat:2.4f forKey:@"appVersionC"];
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            //创建audio份目录在Documents文件夹下，not to back up
            NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];
            if ([fileManager fileExistsAtPath:audioPath] == YES)
            {
                NSString *realPath = [audioPath stringByAppendingPathComponent:@"mydatabase.sqlite"];
                if ([fileManager fileExistsAtPath:realPath]) {
                    
                    NSFileManager *deleteFile = [NSFileManager defaultManager];
                    //    NSLog(@"yunsi:%@",userPath)
                    NSError *error = nil;
                    
                    if ([deleteFile removeItemAtPath:realPath error:&error]) {
                        //		NSLog(@"delete succeed");
                    }
                }
            }

        }
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"firstLaunch"] == nil) {
            //        NSLog(@"first");
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"firstLaunch"];
            //            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"synContext"];
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"keepScreenLight"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"mulValueColor"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"playMode"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:20] forKey:@"mulValueFont"];
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"hightlightLoc"];
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"shakeCtrlPlay"];
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:kBePro];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"haveScore"];

//            numOfPages = 4;
//            
//            scrollView = [[UIScrollView alloc] initWithFrame:self.windowTwo.bounds];
//            scrollView.pagingEnabled=YES;
//            scrollView.showsVerticalScrollIndicator=NO;
//            scrollView.showsHorizontalScrollIndicator=NO;
//            scrollView.scrollEnabled=YES;
//            scrollView.clipsToBounds=YES;
//            scrollView.delegate=self;
//            
//            
//            pageControl= [[UIPageControl alloc] initWithFrame:CGRectMake(110, 450, 100, 40)];
//            pageControl.numberOfPages =4;
//            [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
//            
//            for (NSUInteger i = 1; i <= numOfPages; i++)
//            {
//                NSString *imageName = [NSString stringWithFormat:@"help%d.png", i];
//                UIView * pageView = [[UIView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width * (i-1), 0, scrollView.frame.size.width, scrollView.frame.size.height)];
//                UIImage *image = [UIImage imageNamed:imageName];
//                UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//                // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
//                imageView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height);
//                pageView.tag = i;	// tag our images for later use when we place them in serial fashion
//                [pageView addSubview:imageView];
//                [scrollView addSubview:pageView];
//                [imageView release];
//                [pageView release];
//            }
//            [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width * numOfPages, scrollView.frame.size.height)];
//            
//            myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.windowTwo.frame.size.width, self.windowTwo.frame.size.height)];
//            [myView setBackgroundColor:[UIColor blackColor]];
//            [myView addSubview:scrollView];
//            [myView addSubview:pageControl];
//            [self.windowTwo addSubview:myView];
          }
        //每5次弹一次打分提醒
        int lunchTime = [[NSUserDefaults standardUserDefaults] integerForKey:@"firstLaunch"];
        if (lunchTime < 5) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:lunchTime+1] forKey:@"firstLaunch"];
            //                NSLog(@"lunchTime:%i", lunchTime+1);
        } else {
            if (![[NSUserDefaults standardUserDefaults] boolForKey:@"haveScore"]) {
                [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"firstLaunch"];
                UIAlertView *scoreAlert = [[UIAlertView alloc] initWithTitle:nil message:kAppOne delegate:self cancelButtonTitle:kAppThree otherButtonTitles:kAppTwo,nil];
                [scoreAlert setTag:1];
                [scoreAlert show];
            }
        }

        
        [self.windowTwo makeKeyAndVisible];//最后两句基本都一样
        
    } else {
        
       // NSLog(@"iphone");
        self.windowOne = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.windowOne.rootViewController = self.rootControllerOne;
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
        img.frame = IS_IPHONE_5 ? self.windowOne.bounds : CGRectMake(self.windowOne.bounds.origin.x, self.windowOne.bounds.origin.y - 30, self.windowOne.bounds.size.width, self.windowOne.bounds.size.height + 30);
//            img.frame = CGRectMake(0, 0, 320, 480);
//        img.frame = self.windowOne.frame;
//       self.rootControllerOne.wantsFullScreenLayout = YES;
//        [self.windowOne addSubview:img];
        [self.windowOne insertSubview:img atIndex:0];
        [img release];
//        [self.windowOne addSubview:rootControllerOne.view];
        //针对2.0版本之前没有在程序里设置版本号 修改2.3版本数据库中出现歌词错误信息
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"appVersionC"] == nil)
        {
            [[NSUserDefaults standardUserDefaults]setFloat:2.4f forKey:@"appVersionC"];
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            //创建audio份目录在Documents文件夹下，not to back up
            NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];
            if ([fileManager fileExistsAtPath:audioPath] == YES)
            {
                NSString *realPath = [audioPath stringByAppendingPathComponent:@"mydatabase.sqlite"];
                if ([fileManager fileExistsAtPath:realPath]) {
                    
                    NSFileManager *deleteFile = [NSFileManager defaultManager];
                    //    NSLog(@"yunsi:%@",userPath)
                    NSError *error = nil;
                    
                    if ([deleteFile removeItemAtPath:realPath error:&error]) {
                        //		NSLog(@"delete succeed");
                    }
                }
            }
        }//针对2.0－2.2版本程序里设置版本号 修改2.3版本数据库中出现歌词错误信息
        else if ([[NSUserDefaults standardUserDefaults]floatForKey:@"appVersionC"]!= 2.4f){
            [[NSUserDefaults standardUserDefaults]setFloat:2.4f forKey:@"appVersionC"];
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            //创建audio份目录在Documents文件夹下，not to back up
            NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];
            if ([fileManager fileExistsAtPath:audioPath] == YES)
            {
                NSString *realPath = [audioPath stringByAppendingPathComponent:@"mydatabase.sqlite"];
                if ([fileManager fileExistsAtPath:realPath]) {
                    
                    NSFileManager *deleteFile = [NSFileManager defaultManager];
                    //    NSLog(@"yunsi:%@",userPath)
                    NSError *error = nil;
                    
                    if ([deleteFile removeItemAtPath:realPath error:&error]) {
                        //		NSLog(@"delete succeed");
                    }
                }
            }
            
        }
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"firstLaunch"] == nil) {
            //        NSLog(@"first");
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"firstLaunch"];
//            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"synContext"];
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"keepScreenLight"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"mulValueColor"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"playMode"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:20] forKey:@"mulValueFont"];
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"hightlightLoc"];
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"shakeCtrlPlay"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"haveScore"];
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:kBePro];


       }
        //每5次弹一次打分提醒
        int lunchTime = [[NSUserDefaults standardUserDefaults] integerForKey:@"firstLaunch"];
        if (lunchTime < 5) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:lunchTime+1] forKey:@"firstLaunch"];
            //                NSLog(@"lunchTime:%i", lunchTime+1);
        } else {
            if (![[NSUserDefaults standardUserDefaults] boolForKey:@"haveScore"]) {
                [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"firstLaunch"];
                UIAlertView *scoreAlert = [[UIAlertView alloc] initWithTitle:nil message:kAppOne delegate:self cancelButtonTitle:kAppThree otherButtonTitles:kAppTwo,nil];
                [scoreAlert setTag:1];
                [scoreAlert show];
            }
        }
        
        [self.windowOne makeKeyAndVisible];
//            NSLog(@"1:%f",self.windowOne.frame.size.height);
//            NSLog(@"2:%f",self.windowTwo.frame.size.height);
        
    }
    
       

    //self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
       //self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil] autorelease];
    //} else {
        //self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil] autorelease];
    //}
    //self.window.rootViewController = self.viewController;
    //[self.window makeKeyAndVisible];
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    kNetTest;
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollViews {
//	
//	int page = floor((scrollViews.contentOffset.x - 320 / 4) / 320) + 1;
//	if (pageControlUsed)
//    {
//        // do nothing - the scroll was initiated from the page control, not the user dragging
//        return;
//    }
//    pageControl.currentPage = page;
//	
//	if (page > 5) {
//		//NSLog(@"dsdasdad");
//		[myView removeFromSuperview];
//	}
//}

#pragma mark - AlertDelegate
- (void)modalView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//点击确定下载为0，取消为1
        //        if (alertView.tag == 1) {
        //        }
        //        else if (alertView.tag == 2){
        //        }
        //        else if (alertView.tag == 3)
        //        {
        //            LogController *myLog = [[LogController alloc]init];
        //            [self.navigationController pushViewController:myLog animated:YES];
        //            [myLog release], myLog = nil;
        //        }
    } else if (buttonIndex == 1) {
        if (alertView.tag == 1){
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"haveScore"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=555917167"]];
        }
    }
    [alertView release];
}

@end
