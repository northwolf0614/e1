//
//  InitialViewController.m
//  E1
//
//  Created by linchuang on 20/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "InitialViewController.h"
#import "StartViewController.h"
#import "ViewController.h"

#define WAITINGTIME 3

@interface InitialViewController ()

@end

@implementation InitialViewController

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
    UIImageView* tmpImgView= [[UIImageView alloc] init];
    [self setImgView:tmpImgView];
    [[self view] addSubview:[self imgView]];
    
    //NSString* path=[[NSBundle mainBundle] pathForResource:@"HappyE_initial" ofType:@"png" inDirectory:@"res"];
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"test2" ofType:@"png" inDirectory:@"res"];
    //[[self imgView] setImage:[UIImage imageWithContentsOfFile:path]];
    
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void) viewWillLayoutSubviews
{
    NSString* path=nil;
    NSString* pageNames=nil;
    [super viewWillLayoutSubviews];
    CGRect rect= [[self view] bounds];
    [[self imgView] setFrame:rect];
    
    
    
    
    if([self interfaceOrientation]==UIInterfaceOrientationPortraitUpsideDown ||[self interfaceOrientation]==UIInterfaceOrientationPortrait)
        pageNames=@"HappyE_initial";
    else
        pageNames=@"HappyE_initial-1";
    path=[[NSBundle mainBundle] pathForResource:pageNames ofType:@"png" inDirectory:@"res"];
    
    [[self imgView] setImage:[UIImage imageWithContentsOfFile:path]];
    
    

    
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
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [NSThread sleepForTimeInterval:WAITINGTIME];
    
    UIStoryboard* sb= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NSUserDefaults* defaults= [NSUserDefaults standardUserDefaults];
    bool hideStartPages=[defaults boolForKey:@"hideStartPages7"];
    
    if (!hideStartPages)
    {
        StartViewController* stView=[sb instantiateViewControllerWithIdentifier:@"Start"];
        [self presentViewController:stView animated:NO completion:^{
            
        }];
        
            
    }
    else
    {
        
        //ViewController* viewController= [sb instantiateViewControllerWithIdentifier:@"mainboard"];
        ViewController* viewController= [sb instantiateViewControllerWithIdentifier:@"navi"];
        [self presentViewController:viewController animated:NO completion:^{
            
        }];
        
        
        
        
        
    }
}

@end
