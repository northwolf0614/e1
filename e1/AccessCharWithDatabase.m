//
//  AccessCharWithDatabase.m
//  E1
//
//  Created by linchuang on 25/02/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "AccessCharWithDatabase.h"
#import "BasicAccessor.h"
#import "Study_Check.h"
@implementation AccessCharWithDatabase

@synthesize basicInfoArray=_basicInfoArray;
@synthesize db=_db;
@synthesize study_checkInfoArray=_study_checkInfoArray;
@synthesize databaseName=_databaseName;

-(void)closeDatabase
{
    sqlite3_close([self db]);
}
//the following function will open the default database located in "app/res/gradeX.sqlite"
-(int)openDatabase: (NSString*) databaseName
{
   /*
    this method is not working
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path1 = [documents stringByAppendingPathComponent:databaseName];
    
    this method is not working
     */
     
    //the following method is working,so the client shall use the following method to access the database
    /*
    NSString *database_path = [[NSBundle mainBundle] pathForResource:databaseName ofType:@"sqlite" inDirectory:@"res"];
    NSError* error=nil;
    
    NSFileManager* fm=[NSFileManager defaultManager];
    NSString* filePath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/app/E-Learner"];//Documents/app/E-Learner
    if(![fm fileExistsAtPath:filePath])
    if(![fm fileExistsAtPath:databaseName])
    {
        [fm createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"creating directory error %@",[error localizedDescription]);
            
        }
        
        
    }
    NSData* data=[fm contentsAtPath:database_path];
    NSString* str=[filePath stringByAppendingPathComponent:@"DBDefault.sqlite"];
    [fm createFileAtPath:str contents:data attributes:nil];
    */
    
       
    //the following method is working,so the client shall use the following method to access the database
    
    
    /*
    difference of the above 2 methods!
    database_path1	NSPathStore2 *	@"/Users/linchuang/Library/Application Support/iPhone Simulator/7.1-64/Applications/1C1FE939-89CC-4BF8-BD15-A7E489EB2797/Documents/config.sqlite"	0x000000010a02ad00
    database_path	__NSCFString *	@"/Users/linchuang/Library/Application Support/iPhone Simulator/7.1-64/Applications/1C1FE939-89CC-4BF8-BD15-A7E489EB2797/E1.app/res/config.sqlite"	0x000000010a02ae30
    */
    
    //self.databaseName=[filePath stringByAppendingPathComponent:@"DBDefault.sqlite"];
    NSFileManager* fm=[NSFileManager defaultManager];
    [self setDatabaseName:databaseName];
    if ([fm fileExistsAtPath:[self databaseName]])
    {
        int returnCode=sqlite3_open([[self databaseName] UTF8String], &_db);
        if (returnCode != SQLITE_OK)
        {
            sqlite3_close([self db]);
            NSLog(@"Opening the database error");
            return -1;
            
        }
        return SQLITE_OK;

    }
    return -1;
    
    
}
/*
-(BOOL)updateStorageInfoToDatabase: (NSInteger)value forKey:(NSString*)character dataBase:(sqlite3*)db parameter:(NSString*) par
{
    char* errorMsg;
    int returnCode;
    char* sqlStatement;
    
    if ([par isEqualToString:@"study_check"])
    {   //UPDATE "main"."grade1" SET isDownloaded = 1 WHERE ID =1
         sqlStatement=sqlite3_mprintf("UPDATE study_check SET selfEvaluation = %d WHERE studyContent=%s",value,[character UTF8String]);
    }
    else
    {
        
        sqlStatement=sqlite3_mprintf("UPDATE grade1 SET isDownloaded = %d WHERE character =%s",value,[character UTF8String]);
    }
    
    
    returnCode  =  sqlite3_exec(db,  sqlStatement,  NULL,  NULL,  &errorMsg);
    if(returnCode!=SQLITE_OK)
    {
        NSLog(@"an error in updateStorageInfoToDatabase:%@", [NSString stringWithUTF8String:errorMsg]);
        sqlite3_free(errorMsg);
        sqlite3_close([self db]);
        return false;
    }
    
    return true;
    
}
*/

-(int)enquiryBasicOfDatabase: (sqlite3*) db  gradeInfo:(NSInteger)grade lessonInfo:(NSInteger)lesson
{
    
    
    
    sqlite3_stmt* statement=nil;
    char* sqlstatement=sqlite3_mprintf("SELECT * FROM basic where grade=%d and lessonID=%d",grade, lesson);
    
    
    //first step of 3 steps:preparation
    int returnCode=sqlite3_prepare_v2(db, sqlstatement, -1, &statement, nil);
    
    
    if (returnCode!=SQLITE_OK)
    {
        sqlite3_close(db);
        return  -1;
        
    }
    
    
    //second step of 3 steps: execution
   
    

    while (sqlite3_step(statement)==SQLITE_ROW)
    {
        
        //processing every record here:store the records to NSArray
        
        BasicAccessor* newBasicRecorder= [[BasicAccessor alloc] init];
      
  
        //char* tmpCharacter=(char*)sqlite3_column_text(statement,0);
        //[newBasicRecorder setRowID:(NSInteger)sqlite3_column_int(statement,3)];
        [newBasicRecorder setCharacter: [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,0)]];
        [newBasicRecorder setGrade:(NSInteger)sqlite3_column_int(statement,3)];
        [newBasicRecorder setLessonNumber:(NSInteger)sqlite3_column_int(statement,1)];
        [newBasicRecorder setLessonName:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,2)]];
        [newBasicRecorder setPinyin:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,4)]];
        
        [newBasicRecorder setMarkedChar:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,5)]];
        [newBasicRecorder setTone:(NSInteger)sqlite3_column_int(statement,6)];
        [newBasicRecorder setExample:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,7)]];
        
        
        
        
        [[self basicInfoArray] addObject:newBasicRecorder];
        
        
    }
    
    ////third step of 3 steps: finish
    sqlite3_finalize(statement);
    
    
    sqlite3_free(sqlstatement);
    return 0;
    
    
}

-(id)init
{
    if(self=[super init])
    {
        
        NSMutableArray *newBasicArray = [[NSMutableArray alloc] init];
        self.basicInfoArray=newBasicArray;
        NSMutableArray *newStudy_checkInfoArray = [[NSMutableArray alloc] init];
        self.study_checkInfoArray=newStudy_checkInfoArray;

        
    }
    
    
    return self;
}


/*
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    CharacterModel* changedCharModel=nil;
    if([object isKindOfClass:[CharacterModel class]])
    {
    
        changedCharModel= [change objectForKey:NSKeyValueChangeNewKey];
        
        
        if([keyPath isEqualToString:@"downloadInfo"])
        {
            //update database
            [self updateStorageInfoToDatabase:[changedCharModel downloaded] forKey:[changedCharModel seID] dataBase:self.db parameter:@"downloadInfo"];
            
            //update NSArray? no need to do?
            
           // [[self infoArray] indexOfObjectIdenticalTo:changedCharModel];
            
            
            
        }
        
        if([keyPath isEqualToString:@"recordInfo"])
        {
            //update database
            [self updateStorageInfoToDatabase:[changedCharModel recorded] forKey:[changedCharModel seID] dataBase:self.db parameter:@"recordInfo"];
            //update NSArray? no need to do?
        }
    
    
    }
}
*/



-(int)enquiryStudy_checkOfDatabase: (sqlite3*) db sql:(NSString*) sqlStatement
{
       //first step of 3 steps:preparation
    Check* checkInfo= [[Check alloc] init];
    Study* studyInformation= [[Study alloc] init];
    
    
    sqlite3_stmt* statement=nil;
    int returnCode=sqlite3_prepare_v2(db, [sqlStatement UTF8String], -1, &statement, nil);
    
    
    if (returnCode!=SQLITE_OK)
    {
        sqlite3_close([self db]);
        return  -1;
        
    }
    
    
    //second step of 3 steps: execution
    
    
    
    while (sqlite3_step(statement)==SQLITE_ROW)
    {
        
        //processing every record here:store the records to NSArray
        
        //Study_Check* newStudy_checkRecorder= [[Study_Check alloc] init];
        
   
        //char* tmpCharacter=(char*)sqlite3_column_text(statement,0);
        [studyInformation setLearner: [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,0)]];
        [studyInformation setStudyContent:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,1)]];
        [studyInformation setStudyTime:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,2)]];
        [studyInformation setSelfEvaluation:(NSInteger)sqlite3_column_text(statement,3)];
        [studyInformation setSuperviser:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,4)]];
        [studyInformation setLearnerComment:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,8)]];
        //[studyInformation setLearnerVoiceCommentFile:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,9)]];
        
        [checkInfo setCheckTime:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,5)]];
        [checkInfo setSuperComment:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,6)]];
        //[checkInfo setSuperVoiceCommentFile:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,10)]];
        
       
        //SHOULD HAVE SOME PROBLEM
         //[newCharModel addObserver:self forKeyPath:@"downloadInfo" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
         //[newCharModel addObserver:self forKeyPath:@"recordInfo" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
         
         //SHOULD HAVE SOME PROBLEM
 
        
        [[self study_checkInfoArray] addObject:studyInformation];
        [[self study_checkInfoArray] addObject:checkInfo];
        
        
    }
    
    ////third step of 3 steps: finish
    sqlite3_finalize(statement);
    
    
    //sqlite3_free(sqlstatement);//this shall be accomplished by client;
    return 0;

}


-(BOOL)addRecordToStudy_checkOfDatabase:(sqlite3*) db data:(Study*) recorder time:(NSDate*)dataTime
{
    
     //sqlite show the following infor when submitting
     
     //INSERT INTO "main"."study_check" ("learner","studyContent","studyTime","selfEvaluation","superviser","learnerComment") VALUES (?1,?2,?3,?4,?5,?6)
     //Parameters:
     //param 1 (text): 林佳薪
     //param 2 (text): 星
     //param 3 (text): 2014-05-05 13:00:00
     //param 4 (integer): 90
     //param 5 (text):许林
     //param 6 (text): 我喜欢天上的星星，我想学习星座的知识

    
    
    
    char* errorMsg=nil;
    
    NSDateFormatter*dateFormat =[[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* dateString=[dateFormat stringFromDate:dataTime];
    
    NSString *submitSQL = [NSString stringWithFormat:
                      @"INSERT INTO study_check (learner,studyContent,studyTime,selfEvaluation,superviser,learnerComment) VALUES ('%@','%@','%@','%ld','%@','%@')",[recorder learner],[recorder studyContent],dateString,(long)[recorder selfEvaluation],[recorder superviser],[recorder learnerComment]];
    

    int returnCode  =  sqlite3_exec(db,  [submitSQL UTF8String],  NULL,  NULL,  &errorMsg);
    if(returnCode!=SQLITE_OK)
    {
        NSLog(@"an error in updateStorageInfoToDatabase:%@", [NSString stringWithUTF8String:errorMsg]);
        sqlite3_free(errorMsg);
        sqlite3_close(db);
        return false;
    }
    
    return true;

}

-(bool)updateRecordToStudy_checkOfDatabase:(sqlite3*) db data:(Check*) recorder checkTimeInfo:(NSDate*)checkTime learnerInfo: (NSString*) learner studyTimeInfo:(NSString*) studyTime
{
    
    // UPDATE "main"."study_check" SET "checkTime" = ?1, "superComment" = ?2, "superEvaluation" = ?3 WHERE  "rowid" = 3
     //Parameters:
     //param 1 (text): 2014-05-06 21:00:00
     //param 2 (text): 已经下载了关于星座的知识的文档在电脑中
     //param 3 (integer): 90
     //
    char* errorMsg=nil;
    
    NSDateFormatter*dateFormat =[[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* checkTimeString=[dateFormat stringFromDate:checkTime];
    
    NSString *submitSQL = [NSString stringWithFormat:
                           @"UPDATE study_check SET checkTime='%@',SUPERCOMMENT='%@', superEvaluation='%ld' where learner='%@' and studyTime='%@'",checkTimeString,[recorder superComment],(long)[recorder superEvaluation],learner,studyTime];
    
    
    int returnCode  =  sqlite3_exec(db,  [submitSQL UTF8String],  NULL,  NULL,  &errorMsg);
    if(returnCode!=SQLITE_OK)
    {
        NSLog(@"an error in updateStorageInfoToDatabase:%@", [NSString stringWithUTF8String:errorMsg]);
        sqlite3_free(errorMsg);
        sqlite3_close(db);
        return false;
    }
    
    return true;
    
}

-(void)InsertRecordToDB:(sqlite3*) db record:(NSArray*) record type: (NSInteger) recordType

{
    const char* sequel1 = "insert into content(pictureName,thumbnailPicName,pointOfLearning,pinyin,makingSentence,tone,pro_char) values(?,?,?,?,?,?,?)";
    const char* sequel2 = "insert into Test(pictureName,tester,pro_accuracy,por_sound,drawing,pro_makingSentence) values(?,?,?,?,?,?)";
    const char* sequel3 = "insert into Suptervising(pictureName,tester,superviser,comment_pro,result) values(?,?,?,?,?)";
    
    sqlite3_stmt * UPDATE=nil;
    
    
    
    for (NSInteger count=0; count<[record count]; count++)
    {
        if (recordType==0)
        {
            Content* content=[record objectAtIndex:count];
            
            if (sqlite3_prepare_v2(db, sequel1, -1, &UPDATE, NULL) == SQLITE_OK)
            {
                
                sqlite3_bind_text(UPDATE, 1, [[content pictureName] UTF8String], -1, NULL);
                sqlite3_bind_text(UPDATE, 2, [[content picThumbNailName] UTF8String], -1, NULL);
                sqlite3_bind_text(UPDATE, 3, [[content pointOfLearning] UTF8String], -1, NULL);
                sqlite3_bind_text(UPDATE, 4, [[content pinyin] UTF8String], -1, NULL);
                sqlite3_bind_text(UPDATE, 5, [[content makingSentence] UTF8String], -1, NULL);
                sqlite3_bind_int(UPDATE,  6, (int)[content tone]);
                sqlite3_bind_text(UPDATE, 7, [[content markedChar] UTF8String], -1, NULL);
                if( sqlite3_step(UPDATE) == SQLITE_DONE)
                {
                    NSLog(@"已经写入数据");
                }
                sqlite3_finalize(UPDATE);
            }
            
            
        }
        
        if (recordType==1)
        {
            Test* content=[record objectAtIndex:count];
            
            if (sqlite3_prepare_v2(db, sequel2, -1, &UPDATE, NULL) == SQLITE_OK)
            {
                
                sqlite3_bind_text(UPDATE, 1, [[content pictureName] UTF8String], -1, NULL);
                sqlite3_bind_text(UPDATE, 2, [[content tester] UTF8String], -1, NULL);
                sqlite3_bind_double(UPDATE,3, [content pro_accuracy]);
                sqlite3_bind_blob(UPDATE, 4, [[content pronounce] bytes],(int)[[content pronounce] length],NULL);
                sqlite3_bind_blob(UPDATE, 5, [[content drawing] bytes],(int)[[content pronounce] length],NULL);
                sqlite3_bind_blob(UPDATE, 6, [[content makingSentence] bytes],(int)[[content pronounce] length],NULL);
                
                
                if( sqlite3_step(UPDATE) == SQLITE_DONE)
                {
                    NSLog(@"已经写入数据");
                }
                sqlite3_finalize(UPDATE);
            }
            
            
        }
        
        if (recordType==2)
        {
            Supervising* content=[record objectAtIndex:count];
            
            if (sqlite3_prepare_v2(db, sequel3, -1, &UPDATE, NULL) == SQLITE_OK)
            {
                
                sqlite3_bind_text(UPDATE, 1, [[content pictureName] UTF8String], -1, NULL);
                sqlite3_bind_text(UPDATE, 2, [[content tester] UTF8String], -1, NULL);
                sqlite3_bind_text(UPDATE, 3, [[content superviser] UTF8String], -1, NULL);
                sqlite3_bind_blob(UPDATE, 4, [[content comment] bytes],(int)[[content comment] length],NULL);
                sqlite3_bind_int(UPDATE,  5, (int)[content result]);
                
                
                
                if( sqlite3_step(UPDATE) == SQLITE_DONE)
                {
                    NSLog(@"已经写入数据");
                }
                sqlite3_finalize(UPDATE);
            }
            
            
        }
        
    }
    //sqlite3_finalize(UPDATE);
    
}
-(NSMutableArray*)readRecords:(sqlite3*) db sql:(NSString*)sqlStatement type:(NSInteger)readType
{
    
    //first step of 3 steps:preparation
    
    
    NSMutableArray* resultArray= [[NSMutableArray alloc] initWithCapacity:1];
    
    
    sqlite3_stmt* statement=nil;
    int returnCode=sqlite3_prepare_v2(db, [sqlStatement UTF8String], -1, &statement, nil);
    
    
    if (returnCode!=SQLITE_OK)
    {
        sqlite3_close(db);
        return  nil;
        
    }
    
    
    //second step of 3 steps: execution
    
    
    
    while (sqlite3_step(statement)==SQLITE_ROW)
    {
        
        //processing every record here:store the records to NSArray
        
        //Study_Check* newStudy_checkRecorder= [[Study_Check alloc] init];
        
        
        //char* tmpCharacter=(char*)sqlite3_column_text(statement,0);
        if (readType==0)
        {
            Content* contentInfo= [[Content alloc] init];
            [contentInfo setPictureName: [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,0)]];
            [contentInfo setPicThumbNailName:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,1)]];
            [contentInfo setPointOfLearning:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,2)]];
            [contentInfo setPinyin:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,3)]];
            [contentInfo setMakingSentence:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,4)]];
            [contentInfo setTone:(int)sqlite3_column_int(statement,5)];
            [contentInfo setMarkedChar:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,6)]];
            
            [resultArray addObject:contentInfo];
            
            
            
            
            
            
        }
        if (readType==1)
        {
            NSInteger length;
            NSData* data=nil;
            Test* contentInfo= [[Test alloc] init];
            [contentInfo setPictureName: [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,0)]];
            [contentInfo setTester:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,1)]];
            [contentInfo setPro_accuracy:(double)sqlite3_column_double(statement,2)];
            
            
            length=sqlite3_column_bytes(statement,3);
            data=[NSData dataWithBytes:sqlite3_column_blob(statement,3) length:length ];
            [contentInfo setPronounce:data];
            
            length=sqlite3_column_bytes(statement,4);
            data=[NSData dataWithBytes:sqlite3_column_blob(statement,4) length:length ];
            [contentInfo setDrawing:data];
            
            length=sqlite3_column_bytes(statement,5);
            data=[NSData dataWithBytes:sqlite3_column_blob(statement,5) length:length ];
            [contentInfo setMakingSentence:data];
            
            
            
            [resultArray addObject:contentInfo];
            
            
            
            
            
            
        }
        if (readType==2)
        {
            Supervising* contentInfo= [[Supervising alloc] init];
            NSInteger length;
            NSData* data=nil;
            
            [contentInfo setPictureName: [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,0)]];
            [contentInfo setTester:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,1)]];
            [contentInfo setSuperviser:[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement,2)]];
            
            
            
            length=sqlite3_column_bytes(statement,3);
            data=[NSData dataWithBytes:sqlite3_column_blob(statement,3) length:length ];
            [contentInfo setComment:data];
            
            [contentInfo setResult:(int)sqlite3_column_int(statement,4)];
            
            [resultArray addObject:contentInfo];
            
            
            
            
        }
        
        
    }
    sqlite3_finalize(statement);
    
    return resultArray;
    
    
    
    
}


@end
