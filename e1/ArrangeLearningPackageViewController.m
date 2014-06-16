//
//  ArrangeLearningPackageViewController.m
//  E1
//
//  Created by linchuang on 27/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "ArrangeLearningPackageViewController.h"
#import "BrowsePhotosViewController.h"
#import "BrowsingPhotosViewController.h"
#define DataBasePath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data"]


@interface ArrangeLearningPackageViewController ()

@end

@implementation ArrangeLearningPackageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)rightButtonClicked:(id) sender
{
    [[self packageInfoView] show];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[[self packageInfoView] setHidden:YES];
    //UIView* temp= [[UIView alloc] initWithFrame:CGRectMake(300, 300, 300, 300)];
    //[self setTestAnimationView:temp];
    
    
    
    [[[self navigationController] navigationBar] setHidden:NO];
    UITableView* tmp= [[UITableView alloc] init];
    [self setTableView:tmp];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
    //UIImage* img=[UIImage imageNamed:@"addLearningPackage.png"];
   // UIBarButtonItem* rightBarButton=[[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClicked:)];
    //UIBarButtonItem* rightBarButton=[[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonSystemItemAdd target:self action:@selector(rightButtonClicked:)];
    if (_isArrangePackage) {
        UIBarButtonItem* rightBarButton=[[UIBarButtonItem alloc ] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightButtonClicked:)];
        
        [[self navigationItem] setRightBarButtonItem:rightBarButton];
    }
    
    
    //[[[self navigationItem] rightBarButtonItem] setTitle:@"增加学习包"];
        
    
    
    
    
    [[self view] addSubview:[self tableView]];
    // Do any additional setup after loading the view.
    //[[self view] addSubview:[self testAnimationView]];
    
    
    
    //test
    //[[self dropBoxDelegate] CreateOneRecordByPackageName:@"柳林风声" andBy:@"复习"];
    //test
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"学习包信息" message:@"请输入新学习包名称" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [self setPackageInfoView:alertView];
    [[self packageInfoView] setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    
    
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGRect rectNav=[[[self navigationController] navigationBar] frame];
    CGRect rect= [[self view] frame];
    
    [[self tableView] setFrame:CGRectMake(0, rectNav.size.height, rect.size.width, rect.size.height-rectNav.size.height)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UITableViewDataSource,UITabBarDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self dropBoxDelegate] numberOFRecordsOfLearningPackage];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self view] frame].size.height/10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* learningPackageCell=@"learningPackageCell";
    UITableViewCell *cell = [[self tableView] dequeueReusableCellWithIdentifier:learningPackageCell];
    if (!cell)
    {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:learningPackageCell];
    }
    //NSArray *text=[[self dropBoxDelegate] resultsOfQuery:nil];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:23];
    
    [[cell textLabel] setText: [[self dropBoxDelegate] oneResultOfTable:indexPath.row]];
    //[[cell textLabel] setText: [[text objectAtIndex:indexPath.row] objectForKey:@"packageName"]];
    //[[cell detailTextLabel] setText:[[text objectAtIndex:indexPath.row] objectForKey:@"PackageDescription"]];
    
    //NSString* resPath=[[NSBundle mainBundle] pathForResource:@"packageNameIcon" ofType:@"png" inDirectory:@"res"];
    [[cell imageView ] setImage:[UIImage imageNamed:@"packageNameIcon.png"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UIStoryboard* sb= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BrowsePhotosViewController* browsePhotosViewController= [sb instantiateViewControllerWithIdentifier:@"browsingPhotosBoard"];//browsingPhotosBoard
    
    [[self tableView] deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    [browsePhotosViewController setPackageName:[[cell textLabel] text]];
    [self setCurrentlyWorkingPackageName:[[cell textLabel] text]];
    [browsePhotosViewController setIsShowingThumbnaiPictures:YES];
    
    [browsePhotosViewController setDropBoxDelegate:[self dropBoxDelegate]];
    [browsePhotosViewController setIsArrangePackage:[self isArrangePackage]];
    [browsePhotosViewController setIsLearning:[self isLearning]];
    
    
    [[self navigationController] pushViewController:browsePhotosViewController animated:YES];

}
//划动cell是否出现按钮
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//自定义划动时按钮内容
- (NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
    
}
//定制删除或者增加的具体动过
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [[self dropBoxDelegate] DeleteOneRecordByPackageName:[[self dropBoxDelegate] oneResultOfTable:indexPath.row]];
        [[self tableView] reloadData];
 
    }
}


#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* packageNameInfo=nil;
    NSString* packagePasswordInfo=nil;
    if (buttonIndex==1)
    {
        packageNameInfo=[[[self packageInfoView] textFieldAtIndex:0] text];
        packagePasswordInfo=[[[self packageInfoView] textFieldAtIndex:1] text];
    }
    [[self dropBoxDelegate] CreateOneRecordByPackageName:packageNameInfo andBy:packagePasswordInfo];
    [[self tableView] reloadData];
    
}







@end
