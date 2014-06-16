//
//  AccessCharWithDatabase.h
//  E1
//
//  Created by linchuang on 25/02/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "CharacterModel.h"
#import "Study_Check.h"

typedef enum TAGUpdateRange
{
    LEARNER,SUPERVISER
}UpdateRange;


@interface AccessCharWithDatabase : NSObject
{
    @private
    NSMutableArray* _basicInfoArray;
    NSMutableArray* _study_checkInfoArray;
    sqlite3* _db;
    NSString* _databaseName;
}
@property(nonatomic,assign) sqlite3* db;
@property(nonatomic,strong) NSMutableArray* basicInfoArray;
@property(nonatomic,strong) NSMutableArray* study_checkInfoArray;
@property(nonatomic,strong)NSString* databaseName;


-(int)openDatabase: (NSString*) databaseName;
-(int)enquiryBasicOfDatabase: (sqlite3*) db  gradeInfo:(NSInteger)grade lessonInfo:(NSInteger)lesson;
-(int)enquiryStudy_checkOfDatabase: (sqlite3*) db sql:(NSString*) sqlStatement;
-(BOOL)addRecordToStudy_checkOfDatabase:(sqlite3*) db data:(Study*) recorder time:(NSDate*)dataTime;
-(bool)updateRecordToStudy_checkOfDatabase:(sqlite3*) db data:(Check*) recorder checkTimeInfo:(NSDate*)checkTime learnerInfo: (NSString*) learner studyTimeInfo:(NSString*) studyTime;

//-(BOOL)updateStorageInfoToDatabase: (NSInteger)value forKey:(NSString*)character dataBase:(sqlite3*)db parameter:(NSString*) par;

-(void)closeDatabase;
-(void)InsertRecordToDB:(sqlite3*) db record:(NSArray*) record type: (NSInteger) recordType;
-(NSMutableArray*)readRecords:(sqlite3*) db sql:(NSString*)sqlStatement type:(NSInteger)readType;

@end
