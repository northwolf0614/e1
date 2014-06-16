//
//  ViewController.m
//  E1
//
//  Created by linchuang on 21/02/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "ViewController.h"
//#import "coordinatingController.h"
#import "CanvasViewController.h"
#import "CharacterModel.h"
#import "AccessCharWithDatabase.h"

#import "Mark.h"
#import "Dot.h"
#import "Vertex.h"
#import "Stroke.h"
#import "Scribble.h"
//#import "Dropbox.h"
#import "ScribbleThumbnaiViewProxy.h"
#import "AboutViewController.h"


#define tabBarHeight_inViewcontroller 49







@interface ViewController ()
{
    @private
    
        AccessCharWithDatabase* _accessor;
        CharacterModel* _charModel;
    
    
}
@property (nonatomic,strong) CharacterModel* charModel;
@property (nonatomic, strong) AccessCharWithDatabase* accessor;
-(void)test:(CharacterModel*) model word:(NSString*) soundWord;

//-(void) initViewControllerLayout;
@end


@implementation ViewController

@synthesize accessor=_accessor;
@synthesize charModel=_charModel;

//__strong static coordinatingController* coordinator=nil;

-(void)test:(CharacterModel*) model word:(NSString*) soundWord
{
  
   [model fetchAndPlayURLMP3:soundWord];
   
   
    DBError* error=nil;
    DBPath *newPath = [[DBPath root] childPath:[soundWord stringByAppendingString:@".mp3"]];
    DBFile *file = [[DBFilesystem sharedFilesystem] createFile:newPath error:nil];
   
    [file writeData:[model wordData] error:&error];
    if (error!=nil) {
        NSLog(@"writing file error: %@", [error localizedDescription]);
    }
    
    
    //NSString* path= [[NSBundle mainBundle] pathForResource:@"ring" ofType:@"mp3" inDirectory:@"res"];
    //NSURL* musicURL= [NSURL fileURLWithPath:path];
    
    //NSData* data= [NSData dataWithContentsOfFile:path];
    //[model play:data];
    //[model playURL:musicURL];
    
    
    
    //moviePlayer
    NSString* path_movieTest= [[NSBundle mainBundle] pathForResource:@"IMG_0074" ofType:@"MOV" inDirectory:@"res"];
    //NSString* path =[ NSString stringWithFormat:@"%@/Documents/video.3gp",NSHomeDirectory()];//本地路径
    MPMoviePlayerController *moviePlayer = [ [ MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:path_movieTest]];
    [self setMoviePlayer:moviePlayer];
    
    [[self moviePlayer] setScalingMode:MPMovieScalingModeAspectFit];
    
    [[self moviePlayer] setControlStyle:MPMovieControlStyleNone];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerLoadStateDidChangeNotification:) name:MPMoviePlayerLoadStateDidChangeNotification  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doneButtonClick:)
                                                 name:MPMoviePlayerWillExitFullscreenNotification
                                               object:nil];
    


    
    
    
    
    //moviePlayer

    
    
}
-(void)moviePlayerLoadStateDidChangeNotification:(NSNotification*) notification
{
 
    if ([[self moviePlayer] loadState]!=MPMovieLoadStateUnknown)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
        
        //[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:NO];
        //[[self view] setBounds:CGRectMake(0, 0, 1024, 768)];
        //[[self view] setCenter:CGPointMake(768/2, 1024/2)];
        
        //[[self view] setTransform:CGAffineTransformMakeRotation(M_PI/2)];
        
       // [[[self moviePlayer] view] setFrame:CGRectMake(0, 0, 1024, 768)];
        
        
        [[self view] addSubview:[[self moviePlayer] view]];
        //if ([[self moviePlayer] playbackState]!=MPMusicPlaybackStatePlaying)
        //{
         //   [[self moviePlayer] play];

        //}
        


    }
    
    
}










-(void)moviePlayBackDidFinish:(NSNotification*) notification
{
    [[self moviePlayer] stop];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    

    

}
-(void)doneButtonClick:(NSNotification*) notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerWillExitFullscreenNotification object:nil];
    [[[self moviePlayer] view] removeFromSuperview];
    

    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //test
    //_charModel= [[CharacterModel alloc] init];
    //[self test:[self charModel] word:@"谷歌真好用就是播放不了"];
    //test
    //dropbox link
    [[DBAccountManager sharedManager] linkFromController:self];
    DBAccount *account = [[DBAccountManager sharedManager] linkedAccount];
    
    if (account) {
        DBFilesystem *filesystem = [[DBFilesystem alloc] initWithAccount:account];
        [DBFilesystem setSharedFilesystem:filesystem];
    }
    
    //build database
     DBDatastore* tmpStore=[DBDatastore openDefaultStoreForAccount:account error:nil];
    [self setDataStore:tmpStore];
    //build a default table
    DBTable *tmpTable = [[self dataStore] getTable:@"packageTable"];
    [self setPackageTable:tmpTable];
    //dropbox link
    
    
    /*changes informing
    // ???????
    __weak typeof(self) weakSelf = self;
    [[self dataStore] addObserver:self block:^() {
        DBDatastoreStatus* status=(DBDatastoreStatus*)[[weakSelf dataStore] status];
     
        if ( [status incoming]) {
            //NSDictionary *changes = [[weakSelf dataStore] sync:nil];
     
        }
    }];
    
    //????????????
    */
    //buttons
    UIImage* img=nil;
    UIButton* buttton=nil;
    
    
    buttton= [[UIButton alloc] init];
    [self setLearning:buttton];
    [[self learning] setTitle:@"学习" forState:(UIControlStateNormal)];
    img=[UIImage imageNamed:@"learning.png" ];
    [[self learning] setBackgroundImage:img forState:(UIControlStateNormal)];
    [[self learning] setTag:0];
    [[self learning] addTarget:self action:@selector(buttonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    
    img=[UIImage imageNamed:@"uploadpackage.png" ];
    buttton= [[UIButton alloc] init];
    [self setUploadingOFLearningPackage:buttton];
    [[self uploadingOFLearningPackage] setTitle:@"生成 上传学习包" forState:(UIControlStateNormal)];
    [[self uploadingOFLearningPackage] setBackgroundImage:img forState:(UIControlStateNormal)];
    [[self uploadingOFLearningPackage] setTag:1];
    [[self uploadingOFLearningPackage] addTarget:self action:@selector(buttonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    
    img=[UIImage imageNamed:@"downloadpackage.png" ];
    buttton= [[UIButton alloc] init];
    [self setDownloadingOfLearningPackage:buttton];
    [[self downloadingOfLearningPackage] setTitle:@"下载学习包" forState:(UIControlStateNormal)];
    [[self downloadingOfLearningPackage] setBackgroundImage:img forState:(UIControlStateNormal)];
    [[self downloadingOfLearningPackage] setTag:2];
    [[self downloadingOfLearningPackage] addTarget:self action:@selector(buttonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    
    img=[UIImage imageNamed:@"arrangement.png" ];
    buttton= [[UIButton alloc] init];
    [self setArrangement:buttton];
    [[self arrangement] setTitle:@"整理习包" forState:(UIControlStateNormal)];
    [[self arrangement] setBackgroundImage:img forState:(UIControlStateNormal)];
    [[self arrangement] setTag:3];
    [[self arrangement] addTarget:self action:@selector(buttonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    
    img=[UIImage imageNamed:@"setting.png" ];
    buttton= [[UIButton alloc] init];
    [self setSetting:buttton];
    [[self setting] setTitle:@"设置" forState:(UIControlStateNormal)];
    [[self setting] setBackgroundImage:[UIImage imageNamed:@"setting.png" ] forState:(UIControlStateNormal)];
    [[self setting] setTag:4];
    [[self setting] addTarget:self action:@selector(buttonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    
    img=[UIImage imageNamed:@"pointOFTest.png" ];
    buttton= [[UIButton alloc] init];
    [self setPointOfTest:buttton];
    [[self pointOfTest] setTitle:@"重点测试" forState:(UIControlStateNormal)];
    [[self pointOfTest] setBackgroundImage:img forState:(UIControlStateNormal)];
    [[self pointOfTest] setTag:5];
    [[self pointOfTest] addTarget:self action:@selector(buttonPressed:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    //button
    //imgView
    UIImageView* tmp= [[UIImageView alloc] init];
    [self setImgView:tmp];
    [[self imgView] setImage:[UIImage imageNamed:@"logo.png"]];
    
    //imgView
    
    [[self view] addSubview:[self learning]];
    [[self view] addSubview:[self uploadingOFLearningPackage]];
    [[self view] addSubview:[self downloadingOfLearningPackage]];
    [[self view] addSubview:[self setting]];
    [[self view] addSubview:[self pointOfTest]];
    [[self view] addSubview:[self arrangement]];
    [[self view] addSubview:[self imgView]];
    

    

    
    
    

    
        
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (IBAction)exerciseWriting:(id)sender
{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [sb instantiateViewControllerWithIdentifier:@"canvasboard"];
    [[self navigationController ] pushViewController:viewController animated:NO];

}



- (IBAction)dropboxLink:(id)sender
{
    DBPath *existingPath = [[DBPath root] childPath:@"hello.txt"];
    DBFile *file = [[DBFilesystem sharedFilesystem] openFile:existingPath error:nil];
    NSString *contents = [file readString:nil];
    NSLog(@"%@", contents);



}
 
-(void)doMore
{
    UIStoryboard* sb= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AboutViewController* aboutVC=[sb instantiateViewControllerWithIdentifier:@"aboutBoard"];
    [[self navigationController] pushViewController:aboutVC animated:YES];
    
    
}
-(void)doHistory
{
    return;
}

-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    switch (item.tag) {
        case 0:
            [self doMore];
            break;
        case 1:
            [self doHistory];
            break;
            
        default:
            break;
    }
    
    
    
}
 */
-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat buttonWidth;
    CGFloat buttonHeight;
    CGFloat alignmentInitial_x;
    CGFloat alignmentInitial_y;
    CGFloat verticalGap;
    CGFloat horizontalGap;
    CGFloat logoWidth;
    CGFloat logoHeight;
    CGFloat logo_x;
    CGFloat logo_y;
    //we shall use bound of the view
    CGRect boundRect= [[self view] bounds];
    buttonHeight=boundRect.size.height/6;
    buttonWidth= boundRect.size.width/6;
    logoWidth=boundRect.size.width/4;
    logoHeight=boundRect.size.height/4;
    logo_x=boundRect.size.width/2-logoWidth/2;
    logo_y=boundRect.size.height/40;
    alignmentInitial_x=boundRect.size.width/12;
    alignmentInitial_y=boundRect.size.height/3;
    
    verticalGap=boundRect.size.height/4;
    horizontalGap=7*alignmentInitial_x;
    
    [[[self moviePlayer] view] setFrame:boundRect];
    
    [[self learning] setFrame:CGRectMake(alignmentInitial_x, alignmentInitial_y, buttonWidth, buttonHeight)];
    [[self downloadingOfLearningPackage] setFrame:CGRectMake(alignmentInitial_x, alignmentInitial_y+verticalGap, buttonWidth, buttonHeight)];
    [[self uploadingOFLearningPackage] setFrame:CGRectMake(alignmentInitial_x, alignmentInitial_y+verticalGap*2, buttonWidth, buttonHeight)];
    [[self setting] setFrame:CGRectMake(alignmentInitial_x+horizontalGap, alignmentInitial_y, buttonWidth, buttonHeight)];
    [[self pointOfTest] setFrame:CGRectMake(alignmentInitial_x+horizontalGap, alignmentInitial_y+verticalGap, buttonWidth, buttonHeight)];
    [[self arrangement] setFrame:CGRectMake(alignmentInitial_x+horizontalGap, alignmentInitial_y+verticalGap*2, buttonWidth, buttonHeight)];
    [[self imgView] setFrame:CGRectMake(logo_x, logo_y, logoWidth, logoHeight)];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [[[self navigationController] navigationBar] setHidden:YES];
    [super viewWillAppear:animated];
}

-(void)buttonPressed:(id) sender
{
    UIStoryboard* sb= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIButton* bt=sender;
    switch (bt.tag) {
        case 0:
        {
            ArrangeLearningPackageViewController* arrangeViewController= [sb instantiateViewControllerWithIdentifier:@"ArrangeLearningBoard"];
            [arrangeViewController setDropBoxDelegate:self];
            [arrangeViewController setIsArrangePackage:NO];
            [arrangeViewController setIsLearning:YES];
            [[self navigationController] pushViewController:arrangeViewController animated:YES];
            
        }
            
            break;
        case 1:
        {
           
        }
            
            break;
        case 2:
            
            break;
        case 3:
        {
            
            ArrangeLearningPackageViewController* arrangeViewController= [sb instantiateViewControllerWithIdentifier:@"ArrangeLearningBoard"];
            [arrangeViewController setDropBoxDelegate:self];
            [arrangeViewController setIsArrangePackage:YES];
            [[self navigationController] pushViewController:arrangeViewController animated:YES];
            
            
            
            
            
            
            
        }
            
            break;
        case 4:
            [[self moviePlayer] play];
            
            break;
        case 5://test
        {
            ArrangeLearningPackageViewController* arrangeViewController= [sb instantiateViewControllerWithIdentifier:@"ArrangeLearningBoard"];
            [arrangeViewController setDropBoxDelegate:self];
            [arrangeViewController setIsArrangePackage:NO];
            [arrangeViewController setIsLearning:NO];
            [[self navigationController] pushViewController:arrangeViewController animated:YES];
        }
            
            break;
        default:
            break;
    }
}


//rotation
-(BOOL)shouldAutorotate
{
    return YES;
}
-(NSUInteger) supportedInterfaceOrientations
{
    //return UIInterfaceOrientationMaskAll;
    
    return (UIInterfaceOrientationMaskLandscape|UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationPortraitUpsideDown);
}
//called when the rotation is finished
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    /*
    //processing of tabBar
    CGFloat height=0;
    //we shall use bound of the view
    CGRect boundRect= [[self view] bounds];
    //CGRect frameRect= [[self view] frame];
    height=tabBarHeight_inViewcontroller;
    CGFloat coordinattion_x=0;
    CGFloat coordinattion_y=boundRect.size.height-height;
    CGFloat width=boundRect.size.width;
    [[self tabBar] setFrame:CGRectMake(coordinattion_x, coordinattion_y, width, height)];

    NSLog(@"coordinattion_y=%f",coordinattion_y);
    NSLog(@"coordinattion_x=%f",coordinattion_x);
    NSLog(@"width=%f",width);
    NSLog(@"bound.x=%f",boundRect.origin.x);
    NSLog(@"bound.y=%f",boundRect.origin.y);
    NSLog(@"bound.width=%f",boundRect.size.width);
    NSLog(@"bound.height=%f",boundRect.size.height);
  //processing of tabBar
    */
}

//called while rotating
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"rotation is happening!");

}
//rotation

#pragma AccessingWithDropBox
-(NSInteger) numberOFRecordsOfLearningPackage
{
    DBError* error;
    NSArray *results = [[self packageTable] query:nil error:&error];
    if (error)
    {
        NSLog(@"counting  record error %@", [error localizedDescription]);
        return -1;
        
    }

    
    return [results count];
    



}
-(NSArray*)resultsOfQuery:(NSDictionary*) request
{
    DBError* error;
    NSArray* tmp=[[self packageTable] query:request error:&error];
    if (error)
    {
        NSLog(@"Searching record error %@", [error localizedDescription]);
        return nil;
        
    }
    return tmp;
}
-(NSString*)oneResultOfTable:(NSInteger) rowNumber
{
    NSArray* ar=[self resultsOfQuery:nil];
    DBRecord* record=[ar objectAtIndex:rowNumber];
    return record[@"packageName"];
}

-(BOOL) CreateOneRecordByPackageName:(NSString*)apackageName andBy:(NSString*) theDiscription
{
    DBError* error=nil;
    DBRecord* record=nil;
    NSString* str=nil;
    
    NSArray* array= [[self packageTable] query:nil error:& error];
    for(NSInteger acount=0;acount<[array count];acount++)
    {
        record=[array objectAtIndex: acount];
        str=record[@"packageName"];
        
        if ([apackageName isEqualToString:str])
        {
            return NO;
        }
    
    }
    [[self packageTable] insert:@{@"packageName": apackageName, @"PackageDescription": theDiscription}];
    [[self dataStore] sync:&error];
    
    if (error)
    {
        

        NSLog(@"creating record error %@", [error localizedDescription]);
        return NO;
    }
    //else
      //  return YES;
    
    
    //create  directiory named packageName and the default database file
    //NSString* fileName=[apackageName stringByAppendingString:@"DBDefault.sqlite"];
    
    DBPath *newPath = [[DBPath root] childPath:apackageName];
    DBPath *realPath=[newPath childPath:@"DBDefault.sqlite"];
    //new a directory “photos” at dropbox
    DBPath* photoDir=[newPath childPath:@"photos"];
    [[DBFilesystem sharedFilesystem] createFolder:photoDir error:&error];
    if (error) {
        NSLog(@"creating folder error: %@", [error localizedDescription]);
    }
    //new a directory “photos” at dropbox
    
    DBFile *dropBoxFile = [[DBFilesystem sharedFilesystem] createFile:realPath error:nil];
    
    //create  directiory named packageName and the default database file
    
    //read the default database contents
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSString* path= [[NSBundle mainBundle] pathForResource:@"DBDefault" ofType:@"sqlite" inDirectory:@"res"];
    
    NSData* fileData=[fileManager contentsAtPath:path];
    //read the default database contents
    
    // write the default contents to the DBDefault.sqlite on the dropbox
    [dropBoxFile writeData:fileData error:&error];
    if (error)
    {
        NSLog(@"syncronizing record error %@", [error localizedDescription]);
        return NO;
    }
    return YES;
    
    
    
    
    
    
    
    
    
    
    
    
}

-(BOOL) DeleteOneRecordByPackageName:(NSString*)packageName
{
    DBError* error;
    NSArray *results = [[self packageTable] query:@{ @"packageName": packageName } error:&error];
    
    //temp
    for(DBRecord* record in results)
        [record deleteRecord];
    //return YES;
    //temp
    
   /*
    if ([results count]>1||[results count]==0||error)
    {
        NSLog(@"Deleting record error!");
        return NO;
    }
    else
    {
        DBRecord *recordExpected = [results objectAtIndex:0];
        [recordExpected deleteRecord];
        [[self dataStore] sync:&error];
        if (error)
        {
            NSLog(@"syncronizing record error %@", [error localizedDescription]);
            return NO;
        }
     
    }
    */
    DBPath *newPath = [[DBPath root] childPath:packageName];
    //DBPath *realPath=[newPath childPath:@"DBDefault.sqlite"];
    
    [[DBFilesystem sharedFilesystem] deletePath:newPath error:nil];

   
    if (error)
    {
        NSLog(@"Deleting record error %@", [error localizedDescription]);
        return NO;
    }

    
   
    
    return YES;

}
//read database(*.sqlite)
-(NSData*) readDatabaseFile: (NSString*) packageName
{
    DBError* error=nil;
    DBPath *newPath = [[DBPath root] childPath:packageName];
    DBPath *realPath=[newPath childPath:@"DBDefault.sqlite"];
    
    DBFile* dropBoxFile=[[DBFilesystem sharedFilesystem] openFile:realPath error:&error];
    
    if (error)
    {
        NSLog(@"Open file error %@", [error localizedDescription]);
        [dropBoxFile close];
        return nil;
    }
    NSData* data=[dropBoxFile readData:&error];
    if (error)
    {
        NSLog(@"Read file error %@", [error localizedDescription]);
        [dropBoxFile close];
        return nil;
    }
    [dropBoxFile close];
    return  data;
    
    
}

-(NSData*) readFile: (DBPath*) filePath
{
    DBError* error=nil;
    //DBPath* newPath= [[DBPath root] childPath:filePath];
    DBFile* dropBoxFile=[[DBFilesystem sharedFilesystem] openFile:filePath error:&error];
    
    if (error)
    {
        NSLog(@"Open file error %@", [error localizedDescription]);
        [dropBoxFile close];
        return nil;
    }
    NSData* data=[dropBoxFile readData:&error];
    if (error)
    {
        NSLog(@"Read file error %@", [error localizedDescription]);
        [dropBoxFile close];
        return nil;
    }
    [dropBoxFile close];
    return  data;

    
}

-(BOOL)writeFileWithData:(DBPath*) filePath data:(NSData*) dataContent
{
    DBError* error=nil;

    
    DBFile* dropBoxFile=[[DBFilesystem sharedFilesystem] openFile:filePath error:&error];
    
    if (error)
    {
        NSLog(@"Open file error %@", [error localizedDescription]);
        [dropBoxFile close];
        return NO;
    }
    [dropBoxFile writeData:dataContent error:&error];
    if (error)
    {
        NSLog(@"Write file error %@", [error localizedDescription]);
        [dropBoxFile close];
        return NO;
    }
    [dropBoxFile close];
    return  YES;
    
}

















@end
