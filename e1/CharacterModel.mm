//
//  CharacterModel.m
//  E1
//
//  Created by linchuang on 23/02/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "CharacterModel.h"
#import <AVFoundation/AVMediaFormat.h>

#define REAPETATIONTIMES 5
#define SLEEPTIME 1
@interface CharacterModel()

-(void)playURL:(NSURL*) url;

@end

@implementation CharacterModel

//@property(nonatomic, assign) NSInteger seID;
@synthesize seID=_seID;
@synthesize grade=_grade;
@synthesize character=_character;
@synthesize lesson=_lesson;
@synthesize lessonName=_lessonName;
@synthesize resourceName=_resourceName;
@synthesize wordData=_wordData;
@synthesize recordData=_recordData;
@synthesize downloaded=_downloaded;
@synthesize recorded=_recorded;
@synthesize isDeleteRecordedFile=_isDeleteRecordedFile;
@synthesize avAudioSession=_avAudioSession;
@synthesize avAudioPlayer=_avAudioPlayer;
@synthesize avAudioRecorder=_avAudioRecorder;
@synthesize downloadedFile=_downloadedFile;
@synthesize recordedFile=_recordedFile;

-(void)fetchAndPlayURLMP3:(NSString*) ch
{
    
    
    //if (![self downloaded])
    //{
        for(int i=0;i<REAPETATIONTIMES;i++)
            
        {
            //ENGLISH ENGINE:
            //NSString* urlString = [@"http://translate.google.com/translate_tts?tl=en&q=" stringByAppendingString:ch];
            
            //CHINESE ENGINE:
            NSString* urlString1=[@"http://translate.google.com/translate_tts?ie=UTF-8&oe=UTF-8&tl=zh&q=" stringByAppendingString:ch] ;
            NSString *urlString = [urlString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            //CHINESE ENGINE:
            
            

            NSURL *url = [[NSURL alloc] initWithString:[urlString stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
            [self setCurrentURL:url];//newly added


            //获得返回的mp3文件,格式为NSdata
            NSData *voiceData = [[NSData alloc] initWithContentsOfURL:url];
            
            
            
            
            [NSThread sleepForTimeInterval:SLEEPTIME];//等待3秒获取google词库的发音数据
    
            if(voiceData)
        
            {
                [self play:voiceData];
                /*
                [self willChangeValueForKey:@"downloadInfo"];//call KVO manually
                [self setWordData:voiceData];
                NSLog(@"已经1次性获取到voice");
                //store the voice data to local
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                
                //NSLog(@"documentsDirectory is %@",documentsDirectory);
                ch= [ch stringByAppendingString:@".mp3"];
                [voiceData writeToFile:[documentsDirectory stringByAppendingPathComponent:ch]  atomically:YES];
                NSLog(@"the stored file is %@",[documentsDirectory stringByAppendingPathComponent:ch]);

                [self setCurrentURL: [NSURL fileURLWithPath:[documentsDirectory stringByAppendingPathComponent:ch]]];
                
                
               
                //test
                //NSString* testpath=[[NSBundle mainBundle] pathForResource:@"legend" ofType:@"mp3" inDirectory:@"res"];
                //NSURL* testURL = [NSURL fileURLWithPath:testpath];
                
                //[self playURL:testURL];
                //test
               
                [self setDownloaded:TRUE];
                
                //[self setDownloadedFileDirectory:[documentsDirectory stringByAppendingPathComponent:ch]];
                [self didChangeValueForKey:@"downloadInfo"];//call KVO manually
                //[self playURL:[self currentURL]];
                [self play:[self wordData]];
                 */
                break;
        
            }
            
        }
    
    //}
    
    
        
    
    
    

}

-(void)playStoredURLMP3:(NSString*) ch
{
    //ch=[ch stringByAppendingString:@".mp3"];
    if([self downloaded])
    {
        //prepare the file to be played
      
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* appFile =[documentsDirectory stringByAppendingPathComponent:ch];
        NSLog(@"the fetched file is %@",appFile);
        
        NSURL* newFilePath = [NSURL fileURLWithPath:appFile isDirectory:NO];
        [self setDownloadedFile:newFilePath];
        [self setWordData:[NSData dataWithContentsOfURL:self.downloadedFile]];
       /////////////////////////////////////
        //[self play:[self wordData]];
        [self playURL:newFilePath];
        ////////////////////////////////////////////////
        /*
        NSString* testpath=[[NSBundle mainBundle] pathForResource:@"legend" ofType:@"mp3" inDirectory:@"res"];
        NSURL* testURL = [NSURL fileURLWithPath:testpath];
        
        //[self playURL:testURL];
        [self playURL:[self currentURL] ];
        */
    }

}

-(void)play:(NSData*) dataToBePlayed
{
    
    //play
    NSError* error=nil;
    AVAudioPlayer* avAudioPlayer_new=  [[AVAudioPlayer alloc] initWithData:dataToBePlayed error:&error];
    //AVAudioPlayer* avAudioPlayer_new=  [[AVAudioPlayer alloc] initWithContentsOfURL:[self currentURL]  error:&error];

    if (error) {
        NSLog(@"an error in creating an AVAudioPlayer:%@", [error localizedDescription]);
    }
    [self setAvAudioPlayer:avAudioPlayer_new];
    [[self avAudioPlayer] setDelegate:(id<AVAudioPlayerDelegate>)self];
    [[self avAudioPlayer] setVolume:1.0f];
    [[self avAudioPlayer] setNumberOfLoops:1];
    [[self avAudioPlayer] prepareToPlay];//分配播放所需的资源，并将其加入内部播放队列
    if(![[self avAudioPlayer] isPlaying])
        [[self avAudioPlayer] play];

}
-(void)playURL:(NSURL*) url
{
    
    //play
    NSError* error=nil;
    //AVAudioPlayer* avAudioPlayer_new=  [[AVAudioPlayer alloc] initWithData:dataToBePlayed error:&error];
    /*
     NSString *const AVFileType3GPP;
     NSString *const AVFileType3GPP2;
     NSString *const AVFileTypeAIFC;
     NSString *const AVFileTypeAIFF;
     NSString *const AVFileTypeAMR;
     NSString *const AVFileTypeAC3;
     NSString *const AVFileTypeMPEGLayer3;
     NSString *const AVFileTypeSunAU;
     NSString *const AVFileTypeCoreAudioFormat;
     NSString *const AVFileTypeAppleM4V;
     NSString *const AVFileTypeMPEG4;
     NSString *const AVFileTypeAppleM4A;
     NSString *const AVFileTypeQuickTimeMovie;
     NSString *const AVFileTypeWAVE;
     */
    AVAudioPlayer* avAudioPlayer_new=  [[AVAudioPlayer alloc] initWithContentsOfURL:url fileTypeHint:AVFileTypeMPEGLayer3 error:&error];
    
    if (error) {
        NSLog(@"an error in creating an AVAudioPlayer:%@", [error localizedDescription]);
    }
    [self setAvAudioPlayer:avAudioPlayer_new];
    [[self avAudioPlayer] setDelegate:(id<AVAudioPlayerDelegate>)self];
    [[self avAudioPlayer] setVolume:1.0f];
    [[self avAudioPlayer] setNumberOfLoops:1];
    [[self avAudioPlayer] prepareToPlay];//分配播放所需的资源，并将其加入内部播放队列
    if(![[self avAudioPlayer] isPlaying])
        [[self avAudioPlayer] play];
    
}


-(void)recordStory:(NSString*) ch

{
    //      kAudioFormatLinearPCM
    //      kAudioFormatAppleLossless
    //      kAudioFormatAppleIMA4
    //      kAudioFormatiLBC
    //      kAudioFormatULaw
    //      kAudioFormatALaw

    NSError* error=nil;
    
    if(![self recorded])
    {
        
         NSMutableDictionary *recordSetting = [NSMutableDictionary dictionary];
              [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
              [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
              [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];

        //file stored in document directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString* recordFilePath =[[documentsDirectory stringByAppendingPathComponent:ch] stringByAppendingString:@".wav"];
    
        //NSFileManager* fm= [NSFileManager defaultManager];
        //[fm createFileAtPath:recordFilePath contents:nil attributes:nil];
        NSURL* recordedTmpFile = [NSURL fileURLWithPath:recordFilePath isDirectory:NO];
        [self setRecordedFile:recordedTmpFile];
        AVAudioRecorder* newRecorder = [[ AVAudioRecorder alloc] initWithURL:[self recordedFile] settings:recordSetting error:&error];
    
        
        if (error)
        {
            NSLog(@"an error in recordStory:%@", [error localizedDescription]);
            
        }
        [self setAvAudioRecorder:newRecorder];
        [[self avAudioRecorder] setDelegate:(id<AVAudioRecorderDelegate>) self];
        [[self avAudioRecorder] prepareToRecord];
        
      
        if (![[self avAudioRecorder] isRecording])
        {
            [[self avAudioRecorder] record];
        }
        

        
        
    }
    
}

-(void)stopRecordStory
{
    
    [[self avAudioRecorder] stop];
    NSError* error=nil;
    //if(![self isDeleteRecordedFile])//store the data to member:recordedData
    //{
        [self willChangeValueForKey:@"recordInfo"];//manually KVO
        [self setRecordData:[NSData dataWithContentsOfURL:[self recordedFile]]];
        [self setRecorded:YES];
        [self didChangeValueForKey:@"recordInfo"];//manually KVO
    //}
   /*
    else//delete the recorded file
    {
        NSFileManager * fm = [NSFileManager defaultManager];
        [fm removeItemAtPath:[[self recordedFile] path] error:&error];
        
        if (error) {
            NSLog(@"an error in stopRecordStory:%@",[error localizedDescription]);
        }
        
    }
    */
    
    
    
    //test record
    //[self playURL:[self recordedFile]];
    [self play: [self recordData] ];
    //test record

}

-(id)init
{
    if (self= [super init] )
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        
        NSError *error = nil;
        
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
        
        if (error)
        {
            NSLog(@"an error in playStoredURLMP3:%@", [error localizedDescription]);
        }
        
        [audioSession setActive:YES error:&error];
        
        if (error) {
            NSLog(@"an error during activation:%@", [error localizedDescription]);
        }
        

    }
    return self;
}


@end
