//
//  Study_Check.h
//  E1
//
//  Created by linchuang on 4/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Study : NSObject
{
    @private
    NSInteger _rowID;
    NSString* _learner;
    NSString* _studyContent;
    NSString* _studyTime;// data format contracted from the database shall be "yyyy-MM-dd HH:mm:ss"
    NSInteger _selfEvaluation;
    NSString* _learnerComment;
    NSString* _learnerVoiceCommentFile;
    NSString* _superviser;
    
    
    
}
@property(nonatomic, assign) NSInteger rowID;
@property(nonatomic, strong) NSString*  learner;
@property(nonatomic, strong) NSString*  studyContent;
@property(nonatomic, strong) NSString* studyTime;
@property(nonatomic, assign) NSInteger selfEvaluation;
@property(nonatomic, strong) NSString* learnerComment;
@property(nonatomic, strong) NSString* learnerVoiceCommentFile;
@property(nonatomic, strong) NSString*  superviser;


@end

@interface Check: NSObject
{
@private
   
    
    NSString* _checkTime;// data format contracted from the database shall be "yyyy-MM-dd HH:mm:ss"
    NSString* _superComment;
    NSInteger _superEvaluation;
    NSString* _superVoiceCommentFile;
    
}


@property(nonatomic, strong) NSString* checkTime;
@property(nonatomic, strong) NSString* superComment;
@property(nonatomic, assign) NSInteger superEvaluation;
@property(nonatomic, strong) NSString* superVoiceCommentFile;

@end

