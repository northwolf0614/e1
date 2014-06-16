//
//  BrowsingPhotosViewController.h
//  E1
//
//  Created by linchuang on 27/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ArrangeLearningPackageViewController.h"
#import "AccessCharWithDatabase.h"


@interface BrowsingPhotosViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView* collectionView;

@property(nonatomic,strong)ALAssetsLibrary* assetsLibrary;
@property(nonatomic,strong)ALAssetsGroup* assetsGroup;

@property(nonatomic,strong)NSMutableArray* assetsGroups;
@property(nonatomic,strong)NSMutableArray* assets;
@property (weak, nonatomic) IBOutlet UICollectionView *browsingView;

//@property (weak, nonatomic) IBOutlet UICollectionView *browsingView;
@property(strong,nonatomic) NSString* packageName;
@property(nonatomic,weak) id<AccessingWithDropBox> dropBoxDelegate;
@property(strong,nonatomic) NSString* localDatabaseFile;
@property(strong,nonatomic) AccessCharWithDatabase* accessor;
@property(strong,nonatomic) NSString* realphotosPath;
@property(strong,nonatomic) NSString* thumbnailPhotoesPath;





@end
