//
//  ExerciseViewController.h
//  E1
//
//  Created by linchuang on 10/06/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicAccessor.h"
#import "ArrangeLearningPackageViewController.h"
#import "CharacterModel.h"
#import <AVFoundation/AVSpeechSynthesis.h>


@interface ExerciseViewController : UIViewController< NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UILabel *content_keyPoint;

@property (weak, nonatomic) IBOutlet UILabel *keyPoint_label;
@property(nonatomic,strong) CharacterModel* recordModel;
@property (weak, nonatomic) IBOutlet UIButton *recorder;
@property(strong,nonatomic) NSURLConnection* urlConnection;
@property(strong,nonatomic) NSMutableData* receivedData;


@property (weak, nonatomic) IBOutlet UIImageView *image;


@property(nonatomic,weak)  id<AccessingWithDropBox> dropBoxDelegate;
@property(nonatomic,strong) Content* currentRecord;
@property(nonatomic,strong) NSString* currentPackageName;

@property(nonatomic,strong) NSMutableArray* databaseRecords;
@property(nonatomic,assign) NSInteger currentIndex;

@property(nonatomic,strong) UIAlertView* alertViewFirst;
@property(nonatomic,strong) UIAlertView* alertViewLast;


@end
