//
//  LearningViewController.h
//  E1
//
//  Created by linchuang on 8/06/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicAccessor.h"
#import "ArrangeLearningPackageViewController.h"
#import "CharacterModel.h"
#import <AVFoundation/AVSpeechSynthesis.h>

@interface LearningViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *speaker;
@property (weak, nonatomic) IBOutlet UILabel *keyPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentKeyPoint;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic,weak) id<AccessingWithDropBox> dropBoxDelegate;
@property(nonatomic,strong) Content* currentRecord;
@property(nonatomic,strong) NSString* currentPackageName;

@property(nonatomic,strong)NSMutableArray* databaseRecords;
@property(nonatomic,assign) NSInteger currentIndex;
@property(nonatomic,strong) CharacterModel* charModel;
@property(nonatomic,strong) UIAlertView* alertViewFirst;
@property(nonatomic,strong) UIAlertView* alertViewLast;
@property(nonatomic,strong)UISwipeGestureRecognizer* leftSwipeGesture;
@property(nonatomic,strong)UISwipeGestureRecognizer* rightSwipeGesture;
@property(nonatomic,strong) AVSpeechSynthesizer *synth;
@end
