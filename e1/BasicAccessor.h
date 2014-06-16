//
//  BasicAccessor.h
//  E1
//
//  Created by linchuang on 4/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicAccessor : NSObject
{
  
    @private
        //NSInteger _rowID;
        NSString* _character;
        NSInteger _grade;
        NSInteger _lessonNumber;
        NSString* _lessonName;
        NSString* _pinyin;
        NSString* _markedChar;
        NSInteger _tone;
        NSString* _example;
    
        
}
@property(nonatomic,strong) NSString* character;
@property(nonatomic,strong) NSString* lessonName;
@property(nonatomic,strong) NSString* pinyin;
//@property(nonatomic,assign) NSInteger rowID;
@property(nonatomic,assign) NSInteger grade;
@property(nonatomic,assign) NSInteger lessonNumber;
@property(nonatomic,strong) NSString*  markedChar;
@property(nonatomic,assign) NSInteger tone;
@property(nonatomic,strong) NSString*  example;



@end

@interface Content : NSObject
{
    
@private
    //NSInteger _rowID;
    NSString* _pictureName;
    NSString* _picThumbNailName;
    NSString* _pinyin;
    NSString* _markedChar;
    NSInteger _tone;
    NSString* _makingSentence;
    NSString* _pointOfLearning;
    
    
}
@property(nonatomic,strong) NSString* pictureName;
@property(nonatomic,strong) NSString* picThumbNailName;

@property(nonatomic,strong) NSString*  makingSentence;
@property(nonatomic,assign) NSInteger tone;
@property(nonatomic,strong) NSString*  pointOfLearning;
@property(nonatomic,strong) NSString*  pinyin;
@property(nonatomic,strong) NSString*  markedChar;



@end
@interface Test : NSObject
{
    
@private
    
    NSString* _pictureName;
    NSString* _tester;
    double _pro_accuracy;
    NSData* _drawing;
    NSData* _pronounce;
    NSData* _makingSentence;
    
}
@property(nonatomic,strong) NSString* pictureName;
@property(nonatomic,strong) NSString* tester;
@property(nonatomic,assign) double pro_accuracy;
@property(nonatomic,strong) NSData*  drawing;
@property(nonatomic,strong) NSData*  pronounce;
@property(nonatomic,strong) NSData*  makingSentence;
@end

@interface Supervising : NSObject
{
    
@private
    
    NSString* _pictureName;
    NSString* _tester;
    NSString* _superviser;
    NSData* _comment;
    BOOL _result;
}
@property(nonatomic,strong) NSString* pictureName;
@property(nonatomic,strong) NSString* tester;
@property(nonatomic,strong) NSString* superviser;
@property(nonatomic,assign) BOOL result;
@property(nonatomic,strong) NSData*  comment;
@end
/*
 returned JSON format
 {
 "status":0,//返回状态
 "id":"",
 "hypotheses"://结果列表
 [
 {
 "utterance":"hello", //语音所转换的文字
 "confidence":0.8394497 //识别信心度
 }
 ]
 }
 returned JSON format
 */

@interface JSONReportForRecognition : NSObject
{
    
@private
    
    int _status;
    NSString* _reportID;
    //NSString* _hypotheses;
    NSMutableArray* _reportResults;
}
@property(nonatomic,assign) int status;
@property(nonatomic,strong) NSString* reportID;
//@property(nonatomic,strong) NSString* hypotheses;
@property(nonatomic,strong) NSMutableArray* reportResults;



@end

@interface Hypothesis : NSObject
{
    
@private
    
    NSString* _utterance;
    float _confidence;
    
}
@property(nonatomic,strong) NSString* utterance;
@property(nonatomic,assign) float confidence;




@end




