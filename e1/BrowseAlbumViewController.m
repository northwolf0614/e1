//
//  BrowseAlbumViewController.m
//  E1
//
//  Created by linchuang on 7/06/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "BrowseAlbumViewController.h"
#import "PicInfo.h"
#import "AlbumThumbnialViewCell.h"
#import "BuildCardViewController.h"
//#import "UIImagePickerViewController.h"
#define  AlertViewShowingTime 2

@interface BrowseAlbumViewController ()
-(void)enumeratePhotos;

@end

@implementation BrowseAlbumViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)enumeratePhotos
{
    if (![self assetsLibrary])
    {
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
    //typedef void (^ALAssetsGroupEnumerationResultsBlock)(ALAsset *result, NSUInteger index, BOOL *stop);
    ALAssetsGroupEnumerationResultsBlock groupEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop)
    
    {
    	if (result != nil)
            
        {
            
        	//only get photos
        	if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto])
                
            {
                
                PicInfo* picinfo=[[PicInfo alloc] init];
                //use ALAssetRepresentatioin to get details
                ALAssetRepresentation *rep = [result defaultRepresentation];
                
                
                //get photos info
                [picinfo setThumbnailPic:[UIImage imageWithCGImage:result.thumbnail]];
                [picinfo setImgRef:[rep fullResolutionImage]];
                [picinfo setFileName:[rep filename]];
                
                
                [picinfo setPicture:[UIImage imageWithCGImage:[rep fullResolutionImage]]];

                
                [[self assetsGroups] addObject:picinfo];
                
                
                 
                
                
        	}
            
    	}
        
        else
            
        {
            [[self collectionView] reloadData];
            
    	}
    };
    
    //typedef void (^ALAssetsLibraryGroupsEnumerationResultsBlock)(ALAssetsGroup *group, BOOL *stop);
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock=^(ALAssetsGroup *group, BOOL *stop)
    
    {
               if (group!=nil)
               {
                  
                        ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
                        [group setAssetsFilter:onlyPhotosFilter];
                        if ([group numberOfAssets] > 0)
                        
                            [group enumerateAssetsUsingBlock:groupEnumerationBlock];
            
               }
                else
                    [[self collectionView] reloadData];
        
        
        
        
        
    };
    //typedef void (^ALAssetsLibraryAccessFailureBlock)(NSError *error);
    ALAssetsLibraryAccessFailureBlock failureBlock=^(NSError* error)
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
        
        
    };
    //NSUInteger groupTypes = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos;
    
    
    //get photos from camera roll and other group containing photos
    NSUInteger groupTypes = ALAssetsGroupSavedPhotos|ALAssetsGroupAlbum;
    [[self assetsLibrary] enumerateGroupsWithTypes:groupTypes usingBlock:listGroupBlock failureBlock:failureBlock];
    
}
-(void)rightButtonClicked:(id) sender
{
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有摄像头
    if(![UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        //sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        return;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;   // 设置委托
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = YES;
    [self setImagePickerController:imagePickerController];
    //需要以模态

    [self presentViewController:[self imagePickerController] animated:YES completion:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self collectionView] setBackgroundColor:[UIColor whiteColor]];
    
    UIBarButtonItem* rightBarButton=[[UIBarButtonItem alloc ] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(rightButtonClicked:)];
    
    [[self navigationItem] setRightBarButtonItem:rightBarButton];

    [self enumeratePhotos];
    
    
    

    // Do any additional setup after loading the view.
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
    return [[self assetsGroups] count];
    
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
   
    static NSString * CellIdentifier = @"albumViewCellID";//albumViewCellID//albumViewCellID
   
    AlbumThumbnialViewCell* cell = [cv dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    UIImage* img= [[[self assetsGroups] objectAtIndex:indexPath.row ] thumbnailPic];
    [[cell albumCellImageView] setImage:img];
    return  cell;
    
}
//buildViewControllerID
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard* sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BuildCardViewController* cardVC=[sb instantiateViewControllerWithIdentifier:@"buildViewControllerID"];
    [cardVC setPicInfo:[[self assetsGroups] objectAtIndex:indexPath.row]];
    //CGImageRef imgRef=[[[self assetsGroups] objectAtIndex:indexPath.row] imgRef ];
    
    //UIImage* img=[UIImage imageWithCGImage:imgRef];
    //[cardVC setImage:img];
   // [[cardVC imageView] setImage:img];
    
    [[self navigationController] pushViewController:cardVC animated:YES];

}




#pragma mark UIImagePickerController Method
//完成拍照
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //UIImage* thumbnailImg= info objectForKey:UIImagePickerController
    if (image == nil)
        image = [info objectForKey:UIImagePickerControllerOriginalImage];

    //[self performSelector:@selector(saveImage:) withObject:image];
    if (image!=nil) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    else
        NSLog(@"no image");
    
   
}

//用户取消拍照
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    if (error!=nil) {
        UIAlertView* alertView= [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存相片失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alertView show];
        [NSThread sleepForTimeInterval:AlertViewShowingTime];
        [alertView dismissWithClickedButtonIndex:0 animated:YES];

    }
    else
         [self enumeratePhotos];
    
}







@end
