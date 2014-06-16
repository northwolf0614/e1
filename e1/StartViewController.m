//
//  StartViewController.m
//  E1
//
//  Created by linchuang on 21/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "StartViewController.h"
#define PAGECOUNT 5
#define BUTTONWIDTH 80
#define BUTTONHEIGHT 40


#define PAGECONWIDTH 80
#define PAGECONHEIGHT 40

#define VERTICALGAPBETWEENPAGEANDBUTTON 40

@interface StartViewController ()
-(void)createPages:(NSArray*) pageNames;
@property(nonatomic,strong) UIView* pagesView;
@end

@implementation StartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    if ([self navigationController]) {
        [[[self navigationController] navigationBar] setHidden:YES];
    }
    [super viewWillAppear:animated];
    
}
-(void)viewWillLayoutSubviews
{
    NSArray* pageNames=nil;
    //CGRect rect= [[self view] bounds];
    if([self interfaceOrientation]==UIInterfaceOrientationPortraitUpsideDown ||[self interfaceOrientation]==UIInterfaceOrientationPortrait)
        pageNames=@[@"HappyE_startup1",@"HappyE_startup2",@"HappyE_startup3",@"HappyE_startup4",@"HappyE_startup5"];
    else
        pageNames=@[@"HappyE_startup1-1",@"HappyE_startup2-1",@"HappyE_startup3-1",@"HappyE_startup4-1",@"HappyE_startup5-1"];
    [self createPages:pageNames];
    
    CGRect rect= [[self view] bounds];
    [[self startButton] setFrame:CGRectMake((rect.size.width/2-BUTTONWIDTH/2),(rect.size.height/2-BUTTONHEIGHT/2),BUTTONWIDTH,BUTTONHEIGHT)];
    [[self startButton] setTitle:@"开始体验" forState:UIControlStateNormal];
    [[self startButton] setUserInteractionEnabled:YES];
    [[self startButton] setEnabled:YES];
    
    
    
    
    [[self pageCon] setFrame:CGRectMake((rect.size.width/2-PAGECONWIDTH/2),rect.size.height-50,PAGECONWIDTH,PAGECONHEIGHT)];
    //[[self pageCon] setFrame:CGRectMake((rect.size.width/2-PAGECONWIDTH/2),rect.size.height-50,PAGECONWIDTH,PAGECONHEIGHT)];
    

    
    [super viewWillLayoutSubviews];
    
}
/*
-(void)viewDidAppear:(BOOL)animated
{
    
    NSArray* pageNames=nil;
    if([self interfaceOrientation]==UIInterfaceOrientationPortraitUpsideDown ||[self interfaceOrientation]==UIInterfaceOrientationPortrait)
        pageNames=@[@"HappyE_startup1",@"HappyE_startup2",@"HappyE_startup3",@"HappyE_startup4",@"HappyE_startup5"];
    else
        pageNames=@[@"HappyE_startup1-1",@"HappyE_startup2-1",@"HappyE_startup3-1",@"HappyE_startup4-1",@"HappyE_startup5-1"];
    [self createPages:pageNames];
    
    [super viewDidAppear:animated];

}
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView* tmpView= [[UIScrollView alloc] init];
    [self setStartPagesView:tmpView];
    UIButton* tmpButton= [[UIButton alloc] init];
    [self setStartButton:tmpButton];
    UIPageControl* tmpPageCon= [[UIPageControl alloc] init];
    [self setPageCon:tmpPageCon];
    
    

    
    
    // Do any additional setup after loading the view.
    //NSArray* pageNames=nil;
    [[self startButton] setHidden:YES];
    [[self startButton] setTag:0];
    [[self startButton] addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self pageCon] setHidden:NO];
    [[self pageCon] setNumberOfPages:PAGECOUNT];
    
    [[self startPagesView] setDelegate:self];
    [[self startPagesView] setPagingEnabled:YES];
    
    [[self view] addSubview:[self startPagesView]];
    [[self view] addSubview:[self startButton]];
    [[self view] addSubview:[self pageCon]];
    

    
    
    
}
-(void)buttonPressed:(id)sender
{
    UIButton* bt=sender;
    switch ([bt tag]) {
        case 0:
        {
            [[[self navigationController] navigationBar] setHidden:NO];
            if (self.navigationController==nil)
            {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setBool:YES forKey:@"hideStartPages7"];
                [self dismissViewControllerAnimated:YES completion:^(void){}];
            } else
                //[self dismissViewControllerAnimated:YES completion:^(void){}];
                //[[self navigationController] popViewControllerAnimated:YES];
                [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
            break;
            
        default:
            break;
    }
    
}

-(void)createPages:(NSArray*) pageNames
{
    
   
    CGRect rect=[[self view] bounds];

    
    [[self startPagesView] setFrame:rect];
    [[self startPagesView] setContentSize:CGSizeMake(rect.size.width*PAGECOUNT, rect.size.height)];
    
    if ([self pagesView]) {
        [[self pagesView] removeFromSuperview];
    }
    UIView *tmpView = [[UIView alloc] initWithFrame:rect];
    [self setPagesView:tmpView];
    
    
    for(NSInteger count=0;count<[pageNames count];count++)
    {
        
        NSString* path=[[NSBundle mainBundle] pathForResource:[pageNames objectAtIndex:count] ofType:@"png" inDirectory:@"res"];
        
        UIImageView* imgView= [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
        //[imgView setFrame:rect];
        UIView *onePage = [[UIView alloc] initWithFrame:rect];
        [onePage addSubview:imgView];
        
        
        rect.origin.x += [[self view] frame].size.width;
        
       
        [[self pagesView] addSubview:onePage];
    }
    [[self startPagesView] addSubview:[self pagesView] ];
    
    
}
/*
- (IBAction)enjoyClicked:(id)sender
{
    [[[self navigationController] navigationBar] setHidden:NO];
    if (self.navigationController==nil)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"hideStartPages7"];
        [self dismissViewControllerAnimated:YES completion:^(void){}];
    } else
        //[self dismissViewControllerAnimated:YES completion:^(void){}];
        //[[self navigationController] popViewControllerAnimated:YES];
        [self.navigationController popToRootViewControllerAnimated:NO];
    
    
}
*/

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
-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset1=[[self startPagesView] contentOffset].x;
    CGFloat offset2=[[self startPagesView] bounds].size.width;
    NSUInteger page=offset1/offset2;
    //NSUInteger page = [[self startPagesView] contentOffset].x/[[self startPagesView] frame].size.width;
    

    [[self startButton] setHidden:(page!=PAGECOUNT-1) ];
    [[self pageCon] setCurrentPage:page];
}


//rotation
-(BOOL)shouldAutorotate
{
    return YES;
}
-(NSUInteger) supportedInterfaceOrientations
{
    //return UIInterfaceOrientationMaskAll;
    
    return (UIInterfaceOrientationMaskLandscape|UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationPortraitUpsideDown);
}
//called when the rotation is finished
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSArray* pageNames=nil;
    if([self interfaceOrientation]==UIInterfaceOrientationPortraitUpsideDown ||[self interfaceOrientation]==UIInterfaceOrientationPortrait)
        pageNames=@[@"HappyE_startup1",@"HappyE_startup2",@"HappyE_startup3",@"HappyE_startup4",@"HappyE_startup5"];
    else
        pageNames=@[@"HappyE_startup1-1",@"HappyE_startup2-1",@"HappyE_startup3-1",@"HappyE_startup4-1",@"HappyE_startup5-1"];
    
    [self createPages:pageNames];
    
    
    
    
    
    
    
}

//called while rotating
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"rotation is happening!");
    
}
//rotation


@end
