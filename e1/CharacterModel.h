//
//  CharacterModel.h
//  E1
//
//  Created by linchuang on 23/02/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVAudioSession.h>
#import <AVFoundation/AVAudioRecorder.h>

@interface CharacterModel:NSObject
{
@private
    NSInteger _seID;
    char* _character;
    NSInteger _grade;
    NSInteger _lesson;
    char* _lessonName;
    NSData* _wordData;
    NSData* _recordData;
    BOOL _downloaded;
    NSURL* _downloadedFile;
    BOOL _recorded;
    NSURL* _recordedFile;
    AVAudioPlayer* _avAudioPlayer;
    AVAudioSession* _avAudioSession;
    AVAudioRecorder *_avAudioRecorder;
    BOOL _isDeleteRecordedFile;
    //NSError* error;
    
    
}

@property(nonatomic, assign) NSInteger seID;
@property(nonatomic, assign) NSInteger grade;
@property(nonatomic, assign) char* character;
@property(nonatomic, assign) NSInteger lesson;
@property(nonatomic, assign) char* lessonName;
@property(nonatomic, assign) char* resourceName;
@property(nonatomic, strong) NSData* wordData;
@property(nonatomic, strong) NSData* recordData;
@property(nonatomic, assign) BOOL downloaded;
@property(nonatomic, assign) BOOL recorded;
@property(nonatomic, assign) BOOL isDeleteRecordedFile;
@property(nonatomic, strong) AVAudioSession* avAudioSession;
@property(nonatomic, strong) AVAudioPlayer* avAudioPlayer;
@property(nonatomic, strong) AVAudioRecorder* avAudioRecorder;

@property(nonatomic, strong) NSURL* downloadedFile;
@property(nonatomic, strong) NSURL* recordedFile;
@property(nonatomic,strong) NSURL* currentURL;

//@property(nonatomic, strong) NSError* error;
-(void)fetchAndPlay:(NSString*) ch;
-(void)fetchAndPlayURLMP3:(NSString*) ch;
-(void)playStoredURLMP3:(NSString*) ch;
-(void)recordStory:(NSString*) ch;
-(void)stopRecordStory;
-(void)play:(NSData*) dataToBePlayed;
-(void)playURL:(NSURL*) url;
@end

