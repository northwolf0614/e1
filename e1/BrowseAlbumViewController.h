//
//  BrowseAlbumViewController.h
//  E1
//
//  Created by linchuang on 7/06/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface BrowseAlbumViewController : UICollectionViewController<UIAlertViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic,strong)NSMutableArray* assetsGroups;
@property(nonatomic,strong)ALAssetsLibrary* assetsLibrary;
@property(nonatomic,strong)UIImagePickerController* imagePickerController;
//@property(nonatomic,strong) NSMutableArray* picArray;


@end
