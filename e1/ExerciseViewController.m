//
//  ExerciseViewController.m
//  E1
//
//  Created by linchuang on 10/06/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "ExerciseViewController.h"
#import "BasicAccessor.h"

@interface ExerciseViewController ()

@end

@implementation ExerciseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self recordModel]==nil) {
        CharacterModel* aModel= [[CharacterModel alloc] init];
        [self setRecordModel:aModel];
        [[self recordModel] setIsDeleteRecordedFile:NO];
    }
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//start to record
- (IBAction)recorderClickedDown:(id)sender
{
    [[self recordModel] recordStory:@"recordedAudio.mp3"];
    
    
    
}
- (IBAction)recorderClickedUp:(id)sender
{
    [[self recordModel] stopRecordStory];
    [[self recordModel] recordedFile];
    [self beginRecognition];
}

-(void)beginRecognition
{
   
    //Chinese recognition
    //—参数解释：
    //xjerr：错误标准;client： 客户端类型;lang：待识别语言类型，en-US是英文，中文为zh-CN，maxresults：最大返回识别结果数量

    NSURL *url_old=[NSURL URLWithString:@"http://www.google.com/speech-api/v1/recognize?xjerr=1&client=chromium&lang=zh-CN&maxresults=1"];
    
    
    
    NSData* data= [NSData dataWithContentsOfURL:[[self recordModel] recordedFile]];
    //NSURLRequest* request= [NSURLRequest requestWithURL:url];
    
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url_old];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"audio/L16; rate=16000" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];

    _receivedData = [NSMutableData data];
    _urlConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    [_urlConnection start];
    
        
}

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

- (void)convertJSONObject:(id)jsonObject
{
    if (jsonObject==nil )
    {
        return;
    }
    
    NSMutableArray *mutableReports = [NSMutableArray array];
    
    for (NSDictionary *categories in jsonObject)
    {
        JSONReportForRecognition *recognitionInfo = [[JSONReportForRecognition alloc] init];
        
        NSNumber* statusObject = [categories objectForKey:@"status"];
        //id statusObject = [categories objectForKey:@"category"];

        if ([statusObject integerValue]<0)
            continue;
        [recognitionInfo setStatus:[statusObject integerValue]];
        
        id reportIDObject = [categories objectForKey:@"id"];
        if (reportIDObject==nil || ![reportIDObject isKindOfClass:[NSString class]])
            continue;
        [recognitionInfo setReportID:(NSString *)reportIDObject];
        
        
        
        id hypothesisContent= [categories objectForKey:@"hypotheses"];
        NSMutableArray *mutablehypothesis = [NSMutableArray array];
        
        for (NSDictionary *hypothesis in hypothesisContent)
        {
            Hypothesis* aHypothesisRecord= [[Hypothesis alloc] init];
            id uterrance = [hypothesis objectForKey:@"utterance"];
            if (uterrance==nil || ![uterrance isKindOfClass:[NSString class]])
                continue;
            [aHypothesisRecord setUtterance:(NSString *)uterrance];
            
            NSNumber* confidence =[hypothesis objectForKey:@"confidence"];
            [aHypothesisRecord setConfidence:[confidence floatValue]];
            
            
            
            
            [mutablehypothesis addObject:aHypothesisRecord];
        }
        [recognitionInfo setReportResults: mutablehypothesis];
        
        [mutableReports addObject:recognitionInfo];
    }


}

#pragma

- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSHTTPURLResponse*)response
{
    [[self receivedData] setLength:0];
}

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [[self receivedData] appendData:data];

}
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    NSLog(@"Connection failed! Error:%@ ",[error localizedDescription]);
         
    
    
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"succeeded  %ld byte received",(long int)[[self receivedData] length]);
       NSError* error=nil;
    
    
    /*
    //test
    // fetch offline city list
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"offline" ofType:@"json" inDirectory:@"res"];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    if (data)
    {
        NSError *error=nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        [self convertJSONObject:jsonObject];
    }
     id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    //test
     */
    
   //real jsonObject
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[self receivedData] options:0 error:&error];
   //real jsonObject
    
    
    if (jsonObject==nil||error!=nil) {
        NSLog(@"convert into JSON error: %@", [error localizedDescription]);
        [[self receivedData] setLength:0];
        return;
    }
    [self convertJSONObject:jsonObject];
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








@end
