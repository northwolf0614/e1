//
//  ArrangeLearningPackageViewController.h
//  E1
//
//  Created by linchuang on 27/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIView+AnimationExtensions.h"
#import "Dropbox.h"
@protocol AccessingWithDropBox <NSObject>
-(NSInteger) numberOFRecordsOfLearningPackage;
-(NSArray*)resultsOfQuery:(NSDictionary*) request;
-(NSString*)oneResultOfTable:(NSInteger) rowNumber;

-(BOOL) CreateOneRecordByPackageName:(NSString*)packageName andBy:(NSString*) discription;
-(BOOL) DeleteOneRecordByPackageName:(NSString*)packageName;
-(NSData*) readDatabaseFile: (NSString*) packageName;
-(NSData*) readFile: (DBPath*) filePath;
-(BOOL)writeFileWithData:(DBPath*) filePath data:(NSData*) dataContent;


@end


@interface ArrangeLearningPackageViewController : UIViewController<UITableViewDataSource,UITabBarDelegate,UITableViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,weak) id<AccessingWithDropBox> dropBoxDelegate;
@property(nonatomic,strong)UIAlertView* packageInfoView;
@property(nonatomic,strong)NSString* currentlyWorkingPackageName;
@property(nonatomic,assign)BOOL isArrangePackage;
@property(nonatomic,assign)BOOL isLearning;


//@property(nonatomic,strong)UIView* testAnimationView;

//@property (weak, nonatomic) IBOutlet UILabel *packageName;
//@property (weak, nonatomic) IBOutlet UILabel *packageDiscription;
//@property (weak, nonatomic) IBOutlet UIView *packageInfoView;

@end
