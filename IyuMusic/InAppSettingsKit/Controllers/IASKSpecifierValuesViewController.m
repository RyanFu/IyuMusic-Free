//
//  IASKSpecifierValuesViewController.m
//  http://www.inappsettingskit.com
//
//  Copyright (c) 2009:
//  Luc Vandal, Edovia Inc., http://www.edovia.com
//  Ortwin Gentz, FutureTap GmbH, http://www.futuretap.com
//  All rights reserved.
// 
//  It is appreciated but not required that you give credit to Luc Vandal and Ortwin Gentz, 
//  as the original authors of this code. You can give credit in a blog post, a tweet or on 
//  a info page of your app. Also, the original authors appreciate letting them know if you use this code.
//
//  This code is licensed under the BSD license that is available at: http://www.opensource.org/licenses/bsd-license.php
//

#import "IASKSpecifierValuesViewController.h"
#import "IASKSpecifier.h"
#import "IASKSettingsReader.h"
#import "IASKSettingsStoreUserDefaults.h"

#define kCellValue      @"kCellValue"

@interface IASKSpecifierValuesViewController()
- (void)userDefaultsDidChange;
@end

@implementation IASKSpecifierValuesViewController

@synthesize tableView=_tableView;
@synthesize currentSpecifier=_currentSpecifier;
@synthesize checkedItem=_checkedItem;
@synthesize settingsReader = _settingsReader;
@synthesize settingsStore = _settingsStore;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [imgBtn setBackgroundImage:[UIImage imageWithContentsOfFile:
								[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"title栏按钮"] ofType:@"png"]] 
					  forState:UIControlStateNormal];
	[imgBtn setTitle:@"返回" forState:UIControlStateNormal];
	imgBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [imgBtn addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    imgBtn.frame = CGRectMake(0, 0, 50, 37);
    UIBarButtonItem * backbutton = [[UIBarButtonItem alloc] initWithCustomView:imgBtn];
    self.navigationItem.leftBarButtonItem = backbutton;
	self.navigationItem.hidesBackButton = YES;
	[backbutton release];

    
}

- (void)backButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) updateCheckedItem {
    NSInteger index;
	
	// Find the currently checked item
    if([self.settingsStore objectForKey:[_currentSpecifier key]]) {
      index = [[_currentSpecifier multipleValues] indexOfObject:[self.settingsStore objectForKey:[_currentSpecifier key]]];
    } else {
      index = [[_currentSpecifier multipleValues] indexOfObject:[_currentSpecifier defaultValue]];
    }
	[self setCheckedItem:[NSIndexPath indexPathForRow:index inSection:0]];
}

- (id<IASKSettingsStore>)settingsStore {
    if(_settingsStore == nil) {
        _settingsStore = [[IASKSettingsStoreUserDefaults alloc] init];
    }
    return _settingsStore;
}

- (void)viewWillAppear:(BOOL)animated {
    if (_currentSpecifier) {
        [self setTitle:[_currentSpecifier title]];
        [self updateCheckedItem];
    }
    
    if (_tableView) {
        [_tableView reloadData];

		// Make sure the currently checked item is visible
        [_tableView scrollToRowAtIndexPath:[self checkedItem] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[_tableView flashScrollIndicators];
	[super viewDidAppear:animated];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(userDefaultsDidChange)
												 name:NSUserDefaultsDidChangeNotification
											   object:[NSUserDefaults standardUserDefaults]];
}

- (void)viewDidDisappear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];
	[super viewDidDisappear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.tableView = nil;
}


- (void)dealloc {
    [_currentSpecifier release], _currentSpecifier = nil;
	[_checkedItem release], _checkedItem = nil;
	[_settingsReader release], _settingsReader = nil;
    [_settingsStore release], _settingsStore = nil;
	[_tableView release], _tableView = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark UITableView delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_currentSpecifier multipleValuesCount];
}

- (void)selectCell:(UITableViewCell *)cell {
	[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
	[[cell textLabel] setTextColor:[UIColor blueColor]];
}

- (void)deselectCell:(UITableViewCell *)cell {
	[cell setAccessoryType:UITableViewCellAccessoryNone];
	[[cell textLabel] setTextColor:[UIColor whiteColor]];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [_currentSpecifier footerText];
}

//- (NSString *)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
//    NSString *header = nil;
//    if ([[_currentSpecifier key] isEqualToString:@"mulValueFont"]) {
//        header = @"设置将在打开新文章时生效";
//    }
//    return header;
//}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:kCellValue];
    NSArray *titles         = [_currentSpecifier multipleTitles];
    NSArray *values         = [_currentSpecifier multipleValues];
	
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellValue] autorelease];
		cell.backgroundColor = [UIColor whiteColor];
    }
    [cell setBackgroundColor:[UIColor clearColor]];
	
	if ([indexPath isEqual:[self checkedItem]]) {
		[self selectCell:cell];
    } else {
        [self deselectCell:cell];
    }
	@try {
        if ([[_currentSpecifier key] isEqualToString:@"mulValueColor"]) {
            [[cell textLabel] setText:[self.settingsReader titleForStringId:[titles objectAtIndex:indexPath.row]]];
            NSInteger myColor = [[values objectAtIndex:indexPath.row] intValue];
            //    NSLog(@"color:%d",myColor);
            UIColor *swColor = [UIColor blackColor];
            switch (myColor) {
                case 1:
                    swColor = [UIColor redColor];
                    break;
                case 2:
                    swColor = [UIColor blueColor];
                    break;
                case 3:
                    swColor = [UIColor blackColor];
                    break;
                case 4:
                    swColor = [UIColor brownColor];
                    break;
                case 5:
                    swColor = [UIColor orangeColor];
                    break;
                case 6:
                    swColor = [UIColor purpleColor];
                    break;
                case 7:
                    swColor = [UIColor cyanColor];
                    break;
                case 8:
                    swColor = [UIColor grayColor];
                    break;
                case 9:
                    swColor = [UIColor greenColor];
                    break;
                default:
                    break;
            }
            [[cell textLabel] setTextColor:swColor];
            UIFont *Courier = [UIFont fontWithName:@"Courier" size:17];
            [[cell textLabel] setFont:Courier];
        }else {
            if ([[_currentSpecifier key] isEqualToString:@"mulValueFont"]) {
                [[cell textLabel] setText:[self.settingsReader titleForStringId:[titles objectAtIndex:indexPath.row]]];
                NSInteger fontSize = [[values objectAtIndex:indexPath.row] intValue];
                UIFont *Courier = [UIFont fontWithName:@"Courier" size:fontSize];
                [[cell textLabel] setFont:Courier];
            }
        }
	}
	@catch (NSException * e) {}
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if (indexPath == [self checkedItem]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    NSArray *values         = [_currentSpecifier multipleValues];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self deselectCell:[tableView cellForRowAtIndexPath:[self checkedItem]]];
    [self selectCell:[tableView cellForRowAtIndexPath:indexPath]];
    [self setCheckedItem:indexPath];
	
    [self.settingsStore setObject:[values objectAtIndex:indexPath.row] forKey:[_currentSpecifier key]];
	[self.settingsStore synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:kIASKAppSettingChanged
                                                        object:[_currentSpecifier key]
                                                      userInfo:[NSDictionary dictionaryWithObject:[values objectAtIndex:indexPath.row]
                                                                                           forKey:[_currentSpecifier key]]];
}

#pragma mark Notifications

- (void)userDefaultsDidChange {
	NSIndexPath *oldCheckedItem = self.checkedItem;
	if(_currentSpecifier) {
		[self updateCheckedItem];
	}
	
	// only reload the table if it had changed; prevents animation cancellation
	if (self.checkedItem != oldCheckedItem) {
		[_tableView reloadData];
	}
}

@end
