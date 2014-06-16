//
//  BrowsePhotosViewController.m
//  E1
//
//  Created by linchuang on 1/06/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "BrowsePhotosViewController.h"
#import "PhotoCell.h"
#import "BasicAccessor.h"
#import "Dropbox.h"
#import "BrowseAlbumViewController.h"
#import "LearningViewController.h"
#import "ExerciseViewController.h"

@interface BrowsePhotosViewController ()

@end

@implementation BrowsePhotosViewController

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
 
    UIStoryboard* sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BrowseAlbumViewController* albumViewController=[sb instantiateViewControllerWithIdentifier:@"browseAlbumSBID"];
    [[self navigationController] pushViewController:albumViewController animated:YES];
    
    
    
}
-(void)selectLeftAction:(id)sender
{
    [[self accessor] closeDatabase];
    [[DBFilesystem sharedFilesystem] removeObserver:self];
    [[self navigationController] popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self collectionView] setBackgroundColor:[UIColor whiteColor]];
    if ([self isArrangePackage]) {
        UIBarButtonItem* rightBarButton=[[UIBarButtonItem alloc ] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightButtonClicked:)];
        
        [[self navigationItem] setRightBarButtonItem:rightBarButton];
    }
   

    // Do any additional setup after loading the view.
    //CGRect rect= [[self view] frame];
    //UICollectionView* tmpView= [[UICollectionView alloc] initWithFrame:rect];
    //[self setCollectionView:tmpView];
    //[[self browsingView] setDataSource:self];
    //[[self browsingView] setDelegate:self];
    
    //setting up the directory of database and other files to be used
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSString* filePath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/app/E-Learner"];
    //NSString* databasePath= [filePath stringByAppendingPathComponent:[self packageName]];
    NSString* databasePath=[filePath stringByAppendingPathComponent:[self packageName]];
    
    //NSString* imagePath=[databasePath stringByAppendingPathComponent:@"realphotos"];
    //NSString* thumbnailPath=[databasePath stringByAppendingPathComponent:@"thumbnailphotos"];
    
    //[self setRealphotosPath:imagePath];
    //[self setThumbnailPhotoesPath:thumbnailPath];
    if(![fileManager fileExistsAtPath:databasePath])
    {
        [fileManager createDirectoryAtPath:databasePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //if(![fileManager fileExistsAtPath:[self realphotosPath]])
    //{
    //    [fileManager createDirectoryAtPath:[self realphotosPath] withIntermediateDirectories:YES attributes:nil error:nil];
    //}
    //if(![fileManager fileExistsAtPath:[self thumbnailPhotoesPath]])
    //{
    //    [fileManager createDirectoryAtPath:[self thumbnailPhotoesPath] withIntermediateDirectories:YES attributes:nil error:nil];
    //}
    // download the data of DBDefault.sqlite to localDatabaseFile
    
    [self setLocalDatabasePath:databasePath];
    [self setLocalDatabaseFile:[databasePath stringByAppendingPathComponent:@"DBDefault.sqlite"]];
    
    /*
     //create a thread to download the database file
     [self setEvent:dispatch_semaphore_create(0)];
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
     {
     
     NSFileManager* fileManager=[NSFileManager defaultManager];
     // download the data of DBDefault.sqlite to localDatabaseFile
     NSData* data=[[self dropBoxDelegate] readDatabaseFile:[self packageName]];
     //if (![fileManager fileExistsAtPath:[self localDatabaseFile]])
     //{  //overwrite the content of the file designated!
     [fileManager createFileAtPath:[self localDatabaseFile] contents:data attributes:nil];
     //when finishing downloading signal the event-----ok
     dispatch_semaphore_signal([self event]);
     [[self collectionView ]reloadData];
     
     }
     );
     //create a thread to download the database file
    
*/
    
    //add an observer to notifiy the current collectionView to reload data
    [self setCurrentPackagePathOfDropbox:[[DBPath root] childPath:[self packageName]]];
    
    [[DBFilesystem sharedFilesystem] addObserver:self forPathAndDescendants:[self currentPackagePathOfDropbox] block:^{
        [[self collectionView] reloadData];
    }];
    //add an observer to notifiy the current collectionView to reload data
    //
    AccessCharWithDatabase* accessor_tmp= [[AccessCharWithDatabase alloc] init];
    self.accessor=accessor_tmp;
    //
    
    /*
    //test database ok
    // download the data of DBDefault.sqlite to localDatabaseFile
    NSData* data=[[self dropBoxDelegate] readDatabaseFile:[self packageName]];
    [fileManager createFileAtPath:[self localDatabaseFile] contents:data attributes:nil];
    // download the data of DBDefault.sqlite to localDatabaseFile
    
    AccessCharWithDatabase* accessor_tmp= [[AccessCharWithDatabase alloc] init];
    self.accessor=accessor_tmp;
    [[self accessor] openDatabase:[self localDatabaseFile]];
    
    
    
    
    Content* t1= [[Content alloc] init];
    [t1 setPicThumbNailName:@"2014.10.11_thumbnail.png"];
    [t1 setPictureName:@"2014.10.11.png"];
    [t1 setPinyin:@"da"];
    [t1 setPointOfLearning:@"大"];
    [t1 setTone:4];
    [t1 setMakingSentence:@"大叔，大爷"];
    [t1 setMarkedChar:@"a"];
    Content* t2= [[Content alloc] init];
    [t2 setPicThumbNailName:@"2014.10.12_thumbnail.png"];
    [t2 setPictureName:@"2014.10.12.png"];
    [t2 setPinyin:@"小"];
    [t2 setPointOfLearning:@"小雪"];
    [t2 setTone:3];
    [t2 setMakingSentence:@"小孩，小人国"];
    [t2 setMarkedChar:@"a"];
    //write the records to local file
    NSArray* ar= [[NSArray alloc] initWithObjects:t1,t2, nil];
    [[self accessor] InsertRecordToDB:[[self accessor] db] record:ar type:0];
    //write the records to local file
    
    //read the contents of local file
    NSMutableArray* mar= [[NSMutableArray alloc] init];
    mar=[[self accessor] readRecords:[[self accessor] db] sql:@"select * from content" type:0];
    //read the contents of local file
    
    //close database
    [[self accessor] closeDatabase];
    //close database
    //update the file of dropbox
    NSData* dataForDropbox= [fileManager contentsAtPath:[self localDatabaseFile]];
    DBPath* path=[[self currentPackagePathOfDropbox] childPath:@"DBDefault.sqlite"];
    [[self dropBoxDelegate] writeFileWithData:path data:dataForDropbox ];
    //update the file of dropbox
    //test database ok
    */

    //you shall close the database when leaving the viewController
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(selectLeftAction:)];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    //you shall close the database when leaving the viewController
       
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
       // dispatch_semaphore_wait([self event], DISPATCH_TIME_FOREVER);
            NSFileManager* fileManager=[NSFileManager defaultManager];
        // download the data of DBDefault.sqlite to localDatabaseFile
        NSData* data=[[self dropBoxDelegate] readDatabaseFile:[self packageName]];
        //if (![fileManager fileExistsAtPath:[self localDatabaseFile]])
        //{  //overwrite the content of the file designated!
            [fileManager createFileAtPath:[self localDatabaseFile] contents:data attributes:nil];
        //}
    
    
        [[self accessor] openDatabase:[self localDatabaseFile]];

        [self setDatabaseRecords:[[self accessor] readRecords:[[self accessor] db] sql:@"select * from content" type:0]];
    
        NSInteger q= [[self databaseRecords] count];
        return q;
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    static NSString * CellIdentifier = @"photoCellStoryboardID";
    /*
     static NSString *CellIdentifierLandscape = @"MKPhotoCellLandscape";
     static NSString *CellIdentifierPortrait = @"MKPhotoCellPortrait";
     
     int orientation = [[self.photoOrientation objectAtIndex:indexPath.row] integerValue];
     
     MKPhotoCell *cell = (MKPhotoCell*) [collectionView dequeueReusableCellWithReuseIdentifier:
     orientation == PhotoOrientationLandscape ? CellIdentifierLandscape:CellIdentifierPortrait
     forIndexPath:indexPath];
    */
    PhotoCell* cell = [cv dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    DBPath* dropboxPackagePath = [[[DBPath root] childPath:[self packageName]] childPath:@"photos"];
    
    Content* record=(Content*)[[self databaseRecords] objectAtIndex:indexPath.row];
    
    DBPath* thumbnailImagePath= [dropboxPackagePath childPath:[record picThumbNailName]];
    NSData* data=[[self dropBoxDelegate] readFile:thumbnailImagePath];
    
    UIImage* img= [UIImage imageWithData:data];
    [[cell imageView] setImage:img];
    
    
    [[cell pointLabel] setText: [record pointOfLearning]];

    return  cell;
    
}
/*
#pragma UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(96, 100);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
*/
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isLearning])
    {
        UIStoryboard* sb= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LearningViewController* VC= [sb instantiateViewControllerWithIdentifier:@"LearningViewControllerID"];
    
        [[self collectionView] deselectItemAtIndexPath:indexPath animated:YES];
        Content* record=(Content*)[[self databaseRecords] objectAtIndex:indexPath.row];
    
        [VC setDropBoxDelegate:[self dropBoxDelegate]];
        [VC setCurrentPackageName:[self packageName]];
        [VC setCurrentRecord:record];
        [VC setDatabaseRecords:[self databaseRecords]];
        [VC setCurrentIndex:indexPath.row];
        [[self navigationController] pushViewController:VC animated:YES];
    }
    if (![self isLearning]) {
        UIStoryboard* sb= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ExerciseViewController* VC= [sb instantiateViewControllerWithIdentifier:@"exerciseViewControllerID"];
        
        [[self collectionView] deselectItemAtIndexPath:indexPath animated:YES];
        Content* record=(Content*)[[self databaseRecords] objectAtIndex:indexPath.row];
        
        [VC setDropBoxDelegate:[self dropBoxDelegate]];
        [VC setCurrentPackageName:[self packageName]];
        [VC setCurrentRecord:record];
        [VC setDatabaseRecords:[self databaseRecords]];
        [VC setCurrentIndex:indexPath.row];
        
        [[self navigationController] pushViewController:VC animated:YES];

    }
    
    
       
    
    
   

    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end

