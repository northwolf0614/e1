//
//  BuildCardViewController.m
//  E1
//
//  Created by linchuang on 8/06/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "BuildCardViewController.h"
#import "BrowsePhotosViewController.h"
#define SystemTopSystemBarHeight 20

#define PinYin_X_Scale 0.0339
#define PinYin_Y_Scale 0.6045

#define KeyPoint_X_Scale 0.4388
#define KeyPoint_Y_Scale 0.6045

#define HeightGap 0.0390

#define Content_PinYin_X_Scale 0.1536
#define Content_PinYin_Y_Scale 0.6005

#define Content_KeyPoint_X_Scale 0.6302
#define Content_KeyPoint_Y_Scale 0.6006

#define Content_HeightGap 0.0371
#define ToolBarHeight 44

#define GapToolBarTapBar 20







@interface BuildCardViewController ()

@end

@implementation BuildCardViewController

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
    [[self toolBar] setHidden:YES];
    _adjust_Y_WhenKeyboardShowing=0;
    [[self imageView] setImage:[[self picInfo] picture]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // change of height info notification which is newly added
    #ifdef __IPHONE_5_0
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    #endif
    // change of height info notification which is newly added
    
    
    
    
    
     //tabBar
     UITabBarItem* tabBarItem_tools=[[UITabBarItem alloc] initWithTitle:@"工具箱" image:[UIImage imageNamed:@"tools.png" ] tag:0];
    //[tabBarItem_tools setImageInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
     
    UITabBarItem* tabBarItem_save=[[UITabBarItem alloc] initWithTitle:@"保存" image:[UIImage imageNamed:@"save.png" ] tag:1];
    //[tabBarItem_save setImageInsets:UIEdgeInsetsMake(13, 13, 13, 13)];
    
    UITabBarItem* tabBarItem_cancel=[[UITabBarItem alloc] initWithTitle:@"取消" image:[UIImage imageNamed:@"cancel.png" ] tag:2];
    //[tabBarItem_cancel setImageInsets:UIEdgeInsetsMake(3, 50, 20, 50)];
    NSArray* tabBarItemsArray= [[NSArray alloc] initWithObjects:tabBarItem_tools,tabBarItem_save,tabBarItem_cancel,nil];
     [[self tabBar] setItems:tabBarItemsArray animated:YES];
     //[[self tabBar] setOpaque:YES];
     //[[self tabBar] setBackgroundColor:[UIColor clearColor]];
     //[[self tabBar] setAlpha:1];
     [[self tabBar] setDelegate:self];
     //tabBar
    
    //toolbar
    
    UIBarButtonItem* barButton_redo=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"redo.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(redo:)];
    UIBarButtonItem* barButton_undo=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"undo.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(undo:)];
    UIBarButtonItem* barButton_clear=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"clear.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(clear:)];
    //UIBarButtonItem* barButton_line4=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"line4.png"] style:(UIBarButtonItemStylePlain) target:self action:@selector(line4Selected:)];
    
    
     
     
    NSArray* toolBarItemsArray= [[NSArray alloc] initWithObjects:barButton_redo,barButton_undo,barButton_undo,barButton_clear,nil];
    [[self toolBar] setItems:toolBarItemsArray animated:YES];

     [[self toolBar] setDelegate:self];

     
    
    //toolbar
     

    
}
-(void)clear:(id) sender
{
}
-(void)redo:(id) sender
{
}
-(void)undo:(id) sender
{
}

-(void)viewDidLayoutSubviews
{
    CGRect rectView= [[self view] bounds];
    _currentBounds=rectView;
    CGRect rectNavBar=[[[self navigationController] navigationBar] frame];
    CGRect rectTabBar= [[self tabBar] frame];
    
    [[self imageView] setFrame: CGRectMake(0, rectNavBar.size.height+SystemTopSystemBarHeight, rectView.size.width, 0.5*rectView.size.height)];
    [[self tabBar] setFrame:CGRectMake(0, rectView.size.height-rectTabBar.size.height, rectView.size.width, rectTabBar.size.height)];
    
    [[self pinyin] setFrame:CGRectMake(rectView.size.width*PinYin_X_Scale,rectView.size.height*PinYin_Y_Scale, [[self pinyin] frame].size.width,[[self pinyin] frame].size.height)];
    
    [[self pro_char] setFrame:CGRectMake(rectView.size.width*PinYin_X_Scale,rectView.size.height*(PinYin_Y_Scale+HeightGap), [[self pro_char] frame].size.width,[[self pro_char] frame].size.height)];
    
    [[self tone] setFrame:CGRectMake(rectView.size.width*PinYin_X_Scale,rectView.size.height*(PinYin_Y_Scale+2*HeightGap), [[self tone] frame].size.width,[[self tone] frame].size.height)];
    
    [[self keyPoint] setFrame:CGRectMake(rectView.size.width*KeyPoint_X_Scale,rectView.size.height*KeyPoint_Y_Scale, [[self keyPoint] frame].size.width,[[self keyPoint] frame].size.height)];
    
    [[self makingSentence] setFrame:CGRectMake(rectView.size.width*KeyPoint_X_Scale,rectView.size.height*(KeyPoint_Y_Scale+HeightGap), [[self makingSentence] frame].size.width,[[self makingSentence] frame].size.height)];
    
    ///////////////////////////////////////////
    [[self content_pinyin] setFrame:CGRectMake(rectView.size.width*Content_PinYin_X_Scale,rectView.size.height*Content_PinYin_Y_Scale, [[self content_pinyin] frame].size.width,[[self content_pinyin] frame].size.height)];
    
    [[self content_pro_char] setFrame:CGRectMake(rectView.size.width*Content_PinYin_X_Scale,rectView.size.height*(Content_PinYin_Y_Scale+Content_HeightGap), [[self content_pro_char] frame].size.width,[[self content_pro_char] frame].size.height)];
    
    [[self content_tone] setFrame:CGRectMake(rectView.size.width*Content_PinYin_X_Scale,rectView.size.height*(Content_PinYin_Y_Scale+2*Content_HeightGap), [[self content_tone] frame].size.width,[[self content_tone] frame].size.height)];
    
    
    
    
    
    [[self content_keyPoint] setFrame:CGRectMake(rectView.size.width*Content_KeyPoint_X_Scale,rectView.size.height*Content_KeyPoint_Y_Scale, [[self content_keyPoint] frame].size.width,[[self content_keyPoint] frame].size.height)];
    
    [[self content_makingSentence] setFrame:CGRectMake(rectView.size.width*Content_KeyPoint_X_Scale,rectView.size.height*(Content_KeyPoint_Y_Scale+Content_HeightGap), [[self content_makingSentence] frame].size.width,[[self content_makingSentence] frame].size.height)];
    CGRect rectToolBar= [[self toolBar] frame];
    [[self toolBar] setFrame:CGRectMake(0, rectView.size.height-rectTabBar.size.height-rectToolBar.size.height-GapToolBarTapBar, rectView.size.width, ToolBarHeight)];
    
    
    
    
    
    
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
#pragma mark -
#pragma mark Responding to keyboard events
- (void)keyboardWillShow:(NSNotification *)notification {
    
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    CGRect rect;
    NSDictionary *userInfo = [notification userInfo];
    /*
     NSValue *value = [info objectForKey:UIKeyboardBoundsUserInfoKey];
     CGSize keyboardSize = [value CGRectValue].size;
     */
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardBoundsUserInfoKey];
    //the following is not working
    //NSValue* aValue=[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    float y=_currentBounds.size.height-keyboardRect.size.height;
    CGRect toneRect=[[self content_tone] frame];
    if ((toneRect.origin.y+toneRect.size.height)>y)
    {
        
        float adjustValue=(toneRect.origin.y+toneRect.size.height)-y;
        _adjust_Y_WhenKeyboardShowing=adjustValue;
    
    rect=[[self imageView] frame];
    [[self imageView] setFrame:CGRectMake(rect.origin.x, rect.origin.y-adjustValue, rect.size.width, rect.size.height)];
    rect=[[self pinyin] frame];
    [[self pinyin] setFrame:CGRectMake(rect.origin.x, rect.origin.y-adjustValue, rect.size.width, rect.size.height)];

    rect=[[self pro_char] frame];
    [[self pro_char] setFrame:CGRectMake(rect.origin.x, rect.origin.y-adjustValue, rect.size.width, rect.size.height)];

    rect=[[self tone] frame];
    [[self tone] setFrame:CGRectMake(rect.origin.x, rect.origin.y-adjustValue, rect.size.width, rect.size.height)];

    rect=[[self content_pinyin] frame];
    [[self content_pinyin] setFrame:CGRectMake(rect.origin.x, rect.origin.y-adjustValue, rect.size.width, rect.size.height)];

    rect=[[self content_pro_char] frame];
    [[self content_pro_char] setFrame:CGRectMake(rect.origin.x, rect.origin.y-adjustValue, rect.size.width, rect.size.height)];

    rect=[[self content_tone] frame];
    [[self content_tone] setFrame:CGRectMake(rect.origin.x, rect.origin.y-adjustValue, rect.size.width, rect.size.height)];

    rect=[[self keyPoint] frame];
    [[self keyPoint] setFrame:CGRectMake(rect.origin.x, rect.origin.y-adjustValue, rect.size.width, rect.size.height)];
    
    rect=[[self content_keyPoint] frame];
    [[self content_keyPoint] setFrame:CGRectMake(rect.origin.x, rect.origin.y-adjustValue, rect.size.width, rect.size.height)];

    rect=[[self makingSentence] frame];
    [[self makingSentence] setFrame:CGRectMake(rect.origin.x, rect.origin.y-adjustValue, rect.size.width, rect.size.height)];
    rect=[[self content_makingSentence] frame];
    [[self content_makingSentence] setFrame:CGRectMake(rect.origin.x, rect.origin.y-adjustValue, rect.size.width, rect.size.height)];
        
    }


    
    
    
    
    
    
    
    
    
    
    
    
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    //[self moveInputBarWithKeyboardHeight:keyboardRect.size.height withDuration:animationDuration];
}


- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    CGRect rect;
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    if (_adjust_Y_WhenKeyboardShowing>0) {
        rect=[[self imageView] frame];
        [[self imageView] setFrame:CGRectMake(rect.origin.x, rect.origin.y+_adjust_Y_WhenKeyboardShowing, rect.size.width, rect.size.height)];
        rect=[[self pinyin] frame];
        [[self pinyin] setFrame:CGRectMake(rect.origin.x, rect.origin.y+_adjust_Y_WhenKeyboardShowing, rect.size.width, rect.size.height)];
        
        rect=[[self pro_char] frame];
        [[self pro_char] setFrame:CGRectMake(rect.origin.x, rect.origin.y+_adjust_Y_WhenKeyboardShowing, rect.size.width, rect.size.height)];
        
        rect=[[self tone] frame];
        [[self tone] setFrame:CGRectMake(rect.origin.x, rect.origin.y+_adjust_Y_WhenKeyboardShowing, rect.size.width, rect.size.height)];
        
        rect=[[self content_pinyin] frame];
        [[self content_pinyin] setFrame:CGRectMake(rect.origin.x, rect.origin.y+_adjust_Y_WhenKeyboardShowing, rect.size.width, rect.size.height)];
        
        rect=[[self content_pro_char] frame];
        [[self content_pro_char] setFrame:CGRectMake(rect.origin.x, rect.origin.y+_adjust_Y_WhenKeyboardShowing, rect.size.width, rect.size.height)];
        
        rect=[[self content_tone] frame];
        [[self content_tone] setFrame:CGRectMake(rect.origin.x, rect.origin.y+_adjust_Y_WhenKeyboardShowing, rect.size.width, rect.size.height)];
        
        rect=[[self keyPoint] frame];
        [[self keyPoint] setFrame:CGRectMake(rect.origin.x, rect.origin.y+_adjust_Y_WhenKeyboardShowing, rect.size.width, rect.size.height)];
        
        rect=[[self content_keyPoint] frame];
        [[self content_keyPoint] setFrame:CGRectMake(rect.origin.x, rect.origin.y+_adjust_Y_WhenKeyboardShowing, rect.size.width, rect.size.height)];
        
        rect=[[self makingSentence] frame];
        [[self makingSentence] setFrame:CGRectMake(rect.origin.x, rect.origin.y+_adjust_Y_WhenKeyboardShowing, rect.size.width, rect.size.height)];
        rect=[[self content_makingSentence] frame];
        [[self content_makingSentence] setFrame:CGRectMake(rect.origin.x, rect.origin.y+_adjust_Y_WhenKeyboardShowing, rect.size.width, rect.size.height)];
    }
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    //[self moveInputBarWithKeyboardHeight:0.0 withDuration:animationDuration];
}
#pragma UITabBarDelegate
-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    static BOOL isShow=NO;
    switch (item.tag) {
        case 0:
        {
           
            
            [[self toolBar] setHidden:isShow];
            isShow=!isShow;
            
        }
            
            
            
            break;
        case 1:
            //[self saveLearningCard];----save sqlite file and update to dropbox and transfer the thumbnial and real picture to dropbox in photos directiory
            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isKindOfClass:[BrowsePhotosViewController class]]) {
                    [self.navigationController popToViewController:temp animated:YES];
                }
            }
            
            break;
        case 2:
            [[self navigationController] popViewControllerAnimated:YES];
            break;
    
        default:
            break;
    }
    
    
    
}


@end
