//
//  BrowsePhotosViewController.h
//  E1
//
//  Created by linchuang on 1/06/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ArrangeLearningPackageViewController.h"
#import "AccessCharWithDatabase.h"
#import "Dropbox.h"


@interface BrowsePhotosViewController : UICollectionViewController<UIAlertViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView* collectionView;

@property(nonatomic,strong)ALAssetsLibrary* assetsLibrary;
@property(nonatomic,strong)ALAssetsGroup* assetsGroup;

@property(nonatomic,strong)NSMutableArray* assetsGroups;
@property(nonatomic,strong)NSMutableArray* assets;

@property(nonatomic,strong)NSMutableArray* databaseRecords;
//@property (weak, nonatomic) IBOutlet UICollectionView *browsingView;

//@property (weak, nonatomic) IBOutlet UICollectionView *browsingView;
@property(strong,nonatomic) NSString* packageName;
@property(nonatomic,weak) id<AccessingWithDropBox> dropBoxDelegate;
@property(strong,nonatomic) NSString* localDatabaseFile;
@property(strong,nonatomic) NSString* localDatabasePath;
@property(strong,nonatomic) AccessCharWithDatabase* accessor;
@property(strong,nonatomic) NSString* realphotosPath;
@property(strong,nonatomic) NSString* thumbnailPhotoesPath;
@property(nonatomic,assign) BOOL isShowingThumbnaiPictures;
@property(nonatomic,strong) DBPath* currentPackagePathOfDropbox;
@property(nonatomic,strong) dispatch_semaphore_t event;
@property(nonatomic,assign) BOOL isArrangePackage;
@property(nonatomic,assign)BOOL isLearning;

@end
