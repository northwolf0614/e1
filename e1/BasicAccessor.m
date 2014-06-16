//
//  BasicAccessor.m
//  E1
//
//  Created by linchuang on 4/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "BasicAccessor.h"

@implementation BasicAccessor

@synthesize character=_character;
@synthesize lessonName=_lessonName;
@synthesize pinyin=_pinyin;
//@synthesize rowID=_rowID;
@synthesize grade=_grade;
@synthesize lessonNumber=_lessonNumber;
@synthesize markedChar=_markedChar;
@synthesize tone=_tone;
@synthesize example=_example;
@end

@implementation Content
@synthesize pictureName=_pictureName;
@synthesize picThumbNailName=_picThumbNailName;

@synthesize makingSentence=_makingSentence;
@synthesize tone=_tone;
@synthesize pointOfLearning=_pointOfLearning;
@synthesize pinyin=_pinyin;
@synthesize markedChar=_markedChar;



@end


@implementation Test
@synthesize pictureName=_pictureName;
@synthesize tester=_tester;
@synthesize pro_accuracy=_pro_accuracy;
@synthesize drawing=_drawing;
@synthesize pronounce=_pronounce;
@synthesize makingSentence=_makingSentence;

@end


@implementation Supervising
@synthesize pictureName=_pictureName;
@synthesize tester=_tester;
@synthesize superviser=_superviser;
@synthesize result=_result;
@synthesize comment=_comment;

@end

@implementation JSONReportForRecognition


@synthesize status=_status;
@synthesize reportID=_reportID;
//@synthesize hypotheses=_hypotheses;
@synthesize reportResults=_reportResults;

@end

@implementation Hypothesis

@synthesize  utterance=_utterance;
@synthesize confidence=_confidence;


@end










