//
//  ViewController.h
//  E1
//
//  Created by linchuang on 21/02/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArrangeLearningPackageViewController.h"
#import "Dropbox.h"
#import "AccessCharWithDatabase.h"
#import "BasicAccessor.h"
#import "MediaPlayer/MediaPlayer.h"

@interface ViewController : UIViewController <UITabBarDelegate,AccessingWithDropBox>

@property (strong, nonatomic) UIButton *learning;
@property (strong, nonatomic) UIButton *pointOfTest;
@property(strong,nonatomic) UIButton* arrangement;
@property(strong,nonatomic) UIButton* downloadingOfLearningPackage;
@property(strong,nonatomic) UIButton* uploadingOFLearningPackage;
@property(strong,nonatomic) UIButton* setting;
@property(strong,nonatomic) UIImageView* imgView;

@property(nonatomic,strong) DBDatastore *dataStore;
@property(nonatomic,strong) DBTable *packageTable;
@property(nonatomic,strong) MPMoviePlayerController* moviePlayer;
//@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
//@property(nonatomic,strong) AccessCharWithDatabase* accessor;

@end
