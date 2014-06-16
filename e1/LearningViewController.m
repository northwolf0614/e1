//
//  LearningViewController.m
//  E1
//
//  Created by linchuang on 8/06/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "LearningViewController.h"
#import "Dropbox.h"
#import "CharacterModel.h"

#define AlertViewShowingTime 2
#define SystemTopSystemBarHeight 20

#define KeyPointLabel_X_Scale 0.4492
#define KeyPointLabel_Y_Scale 0.7959

#define ContentKeyPoint_X_Scale 0.4492
#define ContentKeyPoint_Y_Scale 0.8360

#define Speaker_X_Scale 0.7903
#define Speaker_Y_Scale 0.7959

@interface LearningViewController ()

@end

@implementation LearningViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)speaker:(id)sender
{
    
    [[self charModel] fetchAndPlayURLMP3: [[self currentRecord] pointOfLearning]];

    /*
    AVSpeechUtterance *utterance = [AVSpeechUtterance
                                    speechUtteranceWithString:@"This is a teacher"];
    AVSpeechSynthesizer *asynth = [[AVSpeechSynthesizer alloc] init];
    [self setSynth:asynth];
    [[self synth] speakUtterance:utterance];
    */

    
}
-(void) handleGesture:(UISwipeGestureRecognizer*) gesture
{
    if (gesture.direction==UISwipeGestureRecognizerDirectionLeft) {
        if (++_currentIndex<[[self databaseRecords] count])
        {
            [self setCurrentRecord: [[self databaseRecords] objectAtIndex:_currentIndex]];
            
            dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                DBPath* dropboxPackagePath = [[[DBPath root] childPath:[self currentPackageName]] childPath:@"photos"];
                DBPath* picImagePath= [dropboxPackagePath childPath:[[self currentRecord] pictureName ]];
                NSData* data=[[self dropBoxDelegate] readFile:picImagePath];
                UIImage* img= [UIImage imageWithData:data];
                [[self imageView] setImage:img];
                
            });
            [[self contentKeyPoint] setText:[[self currentRecord] pointOfLearning]];
        }
        else
        {
            NSLog(@"this is the last learning card");
            [[self alertViewLast] show];
            [NSThread sleepForTimeInterval:AlertViewShowingTime];
            [[self alertViewLast] dismissWithClickedButtonIndex:0 animated:YES];
            
            
            [self setCurrentIndex:[[self databaseRecords] count]-1];
        }

        
    }
    if (gesture.direction==UISwipeGestureRecognizerDirectionRight) {
        if (--_currentIndex>=0)
        {
            [self setCurrentRecord: [[self databaseRecords] objectAtIndex:_currentIndex]];
            
            dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                DBPath* dropboxPackagePath = [[[DBPath root] childPath:[self currentPackageName]] childPath:@"photos"];
                DBPath* picImagePath= [dropboxPackagePath childPath:[[self currentRecord] pictureName ]];
                NSData* data=[[self dropBoxDelegate] readFile:picImagePath];
                UIImage* img= [UIImage imageWithData:data];
                [[self imageView] setImage:img];
                
            });
            [[self contentKeyPoint] setText:[[self currentRecord] pointOfLearning]];
        }
        else
        {
            NSLog(@"this is the first learning card");
            
            [[self alertViewFirst] show];
            [NSThread sleepForTimeInterval:AlertViewShowingTime];
            [[self alertViewFirst] dismissWithClickedButtonIndex:0 animated:YES];
            
            [self setCurrentIndex:0];
        }

    }
    
}

-(void) handleRightSwipeGesture:(UISwipeGestureRecognizer*) gesture
{
    if (++_currentIndex<[[self databaseRecords] count])
    {
        [self setCurrentRecord: [[self databaseRecords] objectAtIndex:_currentIndex]];
        
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            DBPath* dropboxPackagePath = [[[DBPath root] childPath:[self currentPackageName]] childPath:@"photos"];
            DBPath* picImagePath= [dropboxPackagePath childPath:[[self currentRecord] pictureName ]];
            NSData* data=[[self dropBoxDelegate] readFile:picImagePath];
            UIImage* img= [UIImage imageWithData:data];
            [[self imageView] setImage:img];
            
        });
        [[self contentKeyPoint] setText:[[self currentRecord] pointOfLearning]];
    }
    else
    {
        NSLog(@"this is the last learning card");
        [[self alertViewLast] show];
        [NSThread sleepForTimeInterval:AlertViewShowingTime];
        [[self alertViewLast] dismissWithClickedButtonIndex:0 animated:YES];
        
        
        [self setCurrentIndex:[[self databaseRecords] count]-1];
    }

    
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    CharacterModel* aModel=[[CharacterModel alloc] init];
    [self setCharModel:aModel];
    
    //[[self view] addSubview:[self imageView]];
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        DBPath* dropboxPackagePath = [[[DBPath root] childPath:[self currentPackageName]] childPath:@"photos"];
        DBPath* picImagePath= [dropboxPackagePath childPath:[[self currentRecord] pictureName ]];
        NSData* data=[[self dropBoxDelegate] readFile:picImagePath];
        UIImage* img= [UIImage imageWithData:data];
        [[self imageView] setImage:img];

    });
    [[self contentKeyPoint] setText:[[self currentRecord] pointOfLearning]];
    /*
    DBPath* dropboxPackagePath = [[[DBPath root] childPath:[self currentPackageName]] childPath:@"photos"];
    DBPath* picImagePath= [dropboxPackagePath childPath:[[self record] pictureName ]];
    NSData* data=[[self dropBoxDelegate] readFile:picImagePath];
    UIImage* img= [UIImage imageWithData:data];
    */

    // Do any additional setup after loading the view.
    UIAlertView* alertViewFirst= [[UIAlertView alloc] initWithTitle:@"提示" message:@"这已经是第一张图片了" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [self setAlertViewFirst:alertViewFirst];
    [[self alertViewFirst] setAlertViewStyle:UIAlertViewStyleDefault];
    
    UIAlertView* alertViewLast= [[UIAlertView alloc] initWithTitle:@"提示" message:@"这已经是最后一张图片了" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [self setAlertViewLast:alertViewLast];
    [[self alertViewLast] setAlertViewStyle:UIAlertViewStyleDefault];
    
    
     UISwipeGestureRecognizer *leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
     initWithTarget:self
     action:@selector(handleGesture:)];
     [leftSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    
     
     UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
     initWithTarget:self
     action:@selector(handleGesture:)];
     [rightSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionRight ];
    
     [[self view] addGestureRecognizer:leftSwipeGestureRecognizer];
     [[self view] addGestureRecognizer:rightSwipeGestureRecognizer];
    
     
    
     
     
    
     
     
     



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

-(void)viewDidLayoutSubviews
{
    CGRect rectView= [[self view] bounds];
    
    CGRect rectNavBar=[[[self navigationController] navigationBar] frame];

    
    [[self imageView] setFrame: CGRectMake(0, rectNavBar.size.height+SystemTopSystemBarHeight, rectView.size.width, 0.5*rectView.size.height)];
    
    
    [[self keyPointLabel] setFrame:CGRectMake(rectView.size.width*KeyPointLabel_X_Scale,rectView.size.height*KeyPointLabel_Y_Scale, [[self keyPointLabel] frame].size.width,[[self keyPointLabel] frame].size.height)];
    
    [[self contentKeyPoint] setFrame:CGRectMake(rectView.size.width*ContentKeyPoint_X_Scale,rectView.size.height*ContentKeyPoint_Y_Scale, [[self contentKeyPoint] frame].size.width,[[self contentKeyPoint] frame].size.height)];
    
    [[self speaker] setFrame:CGRectMake(rectView.size.width*Speaker_X_Scale,rectView.size.height*Speaker_Y_Scale, [[self speaker] frame].size.width,[[self speaker] frame].size.height)];
    
   
}





@end
