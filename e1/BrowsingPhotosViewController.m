//
//  BrowsingPhotosViewController.m
//  E1
//
//  Created by linchuang on 27/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "BrowsingPhotosViewController.h"
#import "BasicAccessor.h"
@interface BrowsingPhotosViewController ()

@end

@implementation BrowsingPhotosViewController

//typedef void (^ALAssetsLibraryGroupsEnumerationResultsBlock)(ALAssetsGroup *group, BOOL *stop);















- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //CGRect rect= [[self view] frame];
    //UICollectionView* tmpView= [[UICollectionView alloc] initWithFrame:rect];
    //[self setCollectionView:tmpView];
    [[self browsingView] setDataSource:self];
    [[self browsingView] setDelegate:self];
    
    //setting up the directory of database and other files to be used
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSString* filePath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/app/E-Learner"];
    NSString* databasePath= [filePath stringByAppendingPathComponent:[self packageName]];
    
    NSString* imagePath=[databasePath stringByAppendingPathComponent:@"realphotos"];
    NSString* thumbnailPath=[databasePath stringByAppendingPathComponent:@"thumbnailphotos"];

    [self setRealphotosPath:imagePath];
    [self setThumbnailPhotoesPath:thumbnailPath];
    if(![fileManager fileExistsAtPath:databasePath])
    {
        [fileManager createDirectoryAtPath:databasePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if(![fileManager fileExistsAtPath:[self realphotosPath]])
    {
        [fileManager createDirectoryAtPath:[self realphotosPath] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if(![fileManager fileExistsAtPath:[self thumbnailPhotoesPath]])
    {
        [fileManager createDirectoryAtPath:[self thumbnailPhotoesPath] withIntermediateDirectories:YES attributes:nil error:nil];
    }


    
    
    // download the data of DBDefault.sqlite to localDatabaseFile
    NSData* data=[[self dropBoxDelegate] readDatabaseFile:[self packageName]];
    
    [self setLocalDatabaseFile:[databasePath stringByAppendingPathComponent:@"DBDefault.sqlite"]];
    //[self setLocalDatabaseFile:[realPath stringByAppendingPathComponent:@"DBDefault"]];
    
    
    [fileManager createFileAtPath:[self localDatabaseFile] contents:data attributes:nil];
    // download the data of DBDefault.sqlite to localDatabaseFile
    
    
    //test database ok
    AccessCharWithDatabase* accessor_tmp= [[AccessCharWithDatabase alloc] init];
    self.accessor=accessor_tmp;
    [[self accessor] openDatabase:[self localDatabaseFile]];

    Content* t1= [[Content alloc] init];
    [t1 setPicThumbNailName:@"daafaf;adaa"];
    [t1 setPictureName:@"pipa;fja;sfiioi"];
    [t1 setPinyin:@"pafjda;sinyin"];
    [t1 setPointOfLearning:@"xua;fj;aexi"];
    [t1 setTone:4];
    [t1 setMakingSentence:@"a;fjl;ajf;;asf;as"];
    [t1 setMarkedChar:@"b"];
    Content* t2= [[Content alloc] init];
    [t2 setPicThumbNailName:@"daaa"];
    [t2 setPictureName:@"pipafiioi"];
    [t2 setPinyin:@"pafjdyin"];
    [t2 setPointOfLearning:@"xexi"];
    [t2 setTone:2];
    [t2 setMakingSentence:@"asf;as"];
    [t2 setMarkedChar:@"a"];
    NSArray* ar= [[NSArray alloc] initWithObjects:t1,t2, nil];
    [[self accessor] InsertRecordToDB:[[self accessor] db] record:ar type:0];
    NSMutableArray* mar= [[NSMutableArray alloc] init];
    mar=[[self accessor] readRecords:[[self accessor] db] sql:@"select * from content" type:0];
    //see the content of mar
    
    //test database ok
    
    
    
    
    
    

    


    
    
    /*
    if (![self assetsLibrary]) {
        ALAssetsLibrary* aLib = [[ALAssetsLibrary alloc] init];
        [self setAssetsLibrary:aLib];
    }
    
    if (![self assetsGroups])
    {
        NSMutableArray* aArray = [[NSMutableArray alloc] init];
        [self setAssetsGroups:aArray];
    }
    else
    {
        [[self assetsGroups] removeAllObjects];
    }
    
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock=^(ALAssetsGroup *group, BOOL *stop)
    
    {
        
        ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
        [group setAssetsFilter:onlyPhotosFilter];
        if ([group numberOfAssets] > 0)
        {
            [[self assetsGroups] addObject:group];
        }
        else
        {
            [[self browsingView] performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        }
        
        
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock=^(NSError* error)
    {
        NSString* errorMessage=nil;
        switch ([error code]) {
            case ALAssetsLibraryAccessUserDeniedError:
                
            case ALAssetsLibraryAccessGloballyDeniedError:
                
                errorMessage = @"拒绝访问";
                break;
                
            default:
                errorMessage=@"未知原因";
                break;
        }
        UIAlertView* alertView= [[UIAlertView alloc] initWithTitle:@"提示" message:errorMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertView show];
        
        
    };
    
    NSUInteger groupTypes = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos;
    [[self assetsLibrary] enumerateGroupsWithTypes:groupTypes usingBlock:listGroupBlock failureBlock:failureBlock];
     */
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /*
   // if (![self assetsGroups])
    {
        __block ALAssetsGroup *cameraRollGroup = nil;
        NSUInteger groupTypes = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos;
        [[self assetsLibrary] enumerateGroupsWithTypes:groupTypes usingBlock:^(ALAssetsGroup *group, BOOL *stop)
        {
            // Set to Camera Roll
            if ([[group valueForProperty:@"ALAssetsGroupPropertyType"] intValue] == ALAssetsGroupSavedPhotos)
            {
                cameraRollGroup = group;
                *stop = YES;
                return;
            }
        } failureBlock:^(NSError *error)
        {
            NSString* errorMessage=nil;
            switch ([error code])
            {
                case ALAssetsLibraryAccessUserDeniedError:
                    
                case ALAssetsLibraryAccessGloballyDeniedError:
                    
                    errorMessage = @"拒绝访问";
                    break;
                    
                default:
                    errorMessage=@"未知原因";
                    break;
            }
            UIAlertView* alertView= [[UIAlertView alloc] initWithTitle:@"提示" message:errorMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alertView show];
            
        }];
        
        [self setAssetsGroup:cameraRollGroup];
    
    self.title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    NSLog(@"TITLE %@", self.title); // outputs NULL
    
    
    if (![self assets])
    {
        NSMutableArray* tmpAssets = [[NSMutableArray alloc] init];
        [self setAssets:tmpAssets];
        
    }
    else
    {
        [[self assets] removeAllObjects];
    }
    
    ALAssetsGroupEnumerationResultsBlock assetsEnumerationBock = ^(ALAsset *result, NSUInteger index, BOOL *stop)
    {
        
        if (result)
        {
            [[self assets] addObject:result];
        }
        else
        {
            [[self browsingView] reloadData];
        }
        
    };
    
    ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
    [[self assetsGroup] setAssetsFilter:onlyPhotosFilter];
    [[self assetsGroup] enumerateAssetsUsingBlock:assetsEnumerationBock];
    }
     */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return [[[self accessor] readRecords:[[self accessor] db] sql:@"select * from content" type:0] count];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    static NSString * CellIdentifier = @"E-LearnerCell";
    
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // make the cell's title the actual NSIndexPath value

    //[[cell label] setText:[NSString stringWithFormat:@"{%ld,%ld}", (long)indexPath.row, (long)indexPath.section]];
    
    // load the image for this cell
    //NSString *imageToLoad = [NSString stringWithFormat:@"%d.JPG", indexPath.row];
   // cell.image.image = [UIImage imageNamed:imageToLoad];
    
    return cell;
}

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

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}




























@end
