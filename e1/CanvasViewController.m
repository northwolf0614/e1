//
//  CanvasViewController.m
//  E1
//
//  Created by linchuang on 8/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "CanvasViewController.h"
#import "Stroke.h"
#import "Dot.h"
#import "Vertex.h"
#import "DrawScribbleCommandManager.h"


@interface CanvasViewController ()

@end

@implementation CanvasViewController



@synthesize canvasView=_canvasView;
@dynamic  scribble;
@synthesize strokeColor=_strokeColor;
@synthesize strokeSize=_strokeSize;
@synthesize startPoint=_startPoint;
@synthesize scribbleManager=_scribbleManager;
@synthesize thumbnailViewProxy=_thumbnailViewProxy;
@synthesize drawScribbleCommandManager=_drawScribbleCommandManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    Scribble* aScribble= [[Scribble alloc] init];
    
    [self setScribble:aScribble];
    
    //CanvasView
    CanvasView* canvasView1= [[CanvasView alloc] initWithFrame: CGRectMake(50, 50, 250, 250)];
    [self setCanvasView:canvasView1];
    [[self canvasView] setBounds:CGRectMake(0, 0, 200, 200)];
    [[self view] addSubview:[self canvasView]];
     //CanvasView
    
    [self setStrokeColor:[UIColor whiteColor]];
    [self setStrokeSize:1];
    
    
    ScribbleManager* tmpManager=[[ScribbleManager alloc] init];
    [self setScribbleManager:tmpManager];
    
    DrawScribbleCommandManager* tmpDrawScribbleCommangManager= [[DrawScribbleCommandManager alloc] init];
    [self setDrawScribbleCommandManager:tmpDrawScribbleCommangManager];
    
    
    
    
    
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(selectLeftAction:)];
    
    [[self navigationItem] setLeftBarButtonItem:leftButton];
    
    

   
    
   
  
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

-(void) setScribble: (Scribble*) aScribble
{
    if (_scribble!=aScribble)
    {
        _scribble=aScribble;
   
        // the according response function observeValueForKeyPath will be called when observed items change
        [_scribble addObserver:self forKeyPath:@"mark" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial) context:nil];
    
     }
}
-(Scribble*) scribble
{
    return _scribble;
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"mark"]&&[object isKindOfClass: [Scribble class]])
    {
        
        id<Mark> aMark= [change objectForKey:NSKeyValueChangeNewKey];
        [[self canvasView] setMarkDelegate:aMark];
        [[self canvasView] setNeedsDisplay];
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
}












-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setStartPoint:[[touches anyObject] locationInView:[self canvasView]]];
    
}
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint lastPoint= [[touches anyObject] previousLocationInView:[self canvasView]];
    CGPoint currentPoint= [[touches anyObject] locationInView:[self canvasView]];
    //this branch will be valid only once during a continuous moving
    // this brance means it is moving actually
    if (CGPointEqualToPoint([self startPoint], lastPoint))
    {
        Stroke* aStroke= [[Stroke alloc] init];
        [aStroke setColor:[self strokeColor]];
        [aStroke setSize: [self strokeSize]];
        
        
        //[[self scribble] addMark:aStroke shouldAddToPreviousMark:NO];
        
        //command replace the expression" [[self scribble] addMark:aStroke shouldAddToPreviousMark:NO];"
        NSDictionary* aUserCommandInfo2= [NSDictionary dictionaryWithObjectsAndKeys:[self scribble],@"scribbleObjectUserCommandInfo", aStroke,@"markObjectUserCommandInfo", [NSNumber numberWithBool:NO],@"shouldBeAddedToPreciousUserCommandInfo", nil];
        Command* aCommand= [[DrawScribbleCommand alloc] init];
        [aCommand setUserCommandInfo:aUserCommandInfo2];
        [[self drawScribbleCommandManager] executeCommand:aCommand prepareForUndo:YES];
        //command replace the expression" [[self scribble] addMark:aStroke shouldAddToPreviousMark:NO];"
        
        
    }
    
    Vertex* v= [[[Vertex alloc] init] initWithLocation:currentPoint];
    
    [[self scribble] addMark:v shouldAddToPreviousMark:YES];
    
    /*
     //command replace the expression" [[self scribble] addMark:v shouldAddToPreviousMark:YES];"
     NSDictionary* aUserCommandInfo1= [NSDictionary dictionaryWithObjectsAndKeys:[self scribble],@"scribbleObjectUserCommandInfo", v,@"markObjectUserCommandInfo", [NSNumber numberWithBool:YES],@"shouldBeAddedToPreciousUserCommandInfo", nil];
     Command* aCommand= [[DrawScribbleCommand alloc] init];
     [aCommand setUserCommandInfo:aUserCommandInfo1];
     [[self drawScribbleCommandManager] executeCommand:aCommand prepareForUndo:YES];
      //command replace the expression" [[self scribble] addMark:v shouldAddToPreviousMark:YES];"
    */
    
    


}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint lastPoint= [[touches anyObject] previousLocationInView:[self canvasView]];
    CGPoint currentPoint=[[touches anyObject] locationInView:[self canvasView]];
    // if no moving at all
    if(CGPointEqualToPoint(currentPoint, lastPoint))
    {
        
        Dot* aDot= [[Dot alloc] initWithLocation:currentPoint];//?
        //CGPoint testLocation1=[aDot location];
        [aDot setColor:[self strokeColor]];
        [aDot setSize:[self strokeSize]];
        
        //[[self scribble] addMark:aDot shouldAddToPreviousMark:NO];
        
        
        //command replace the expression" [[self scribble] addMark:aDot shouldAddToPreviousMark:NO];"
        NSDictionary* aUserCommandInfo1= [NSDictionary dictionaryWithObjectsAndKeys:[self scribble],@"scribbleObjectUserCommandInfo", aDot,@"markObjectUserCommandInfo", [NSNumber numberWithBool:NO],@"shouldBeAddedToPreciousUserCommandInfo", nil];
        Command* aCommand= [[DrawScribbleCommand alloc] init];
        [aCommand setUserCommandInfo:aUserCommandInfo1];
        [[self drawScribbleCommandManager] executeCommand:aCommand prepareForUndo:YES];
        //command replace the expression" [[self scribble] addMark:aStroke shouldAddToPreviousMark:NO];"
        
        
        
        
    }
    
    [self setStartPoint:CGPointZero];
    
}
- (IBAction)clearScribble:(id)sender
{
    [[self scribble] removeAllMark];
    
}
- (IBAction)saveScribble:(id)sender
{
    

    UIImage* img= [self convertViewToImage:[self canvasView]];
    UIView* aView=[[self scribbleManager] saveScribble_alternative:[self scribble] image:img];
    
    //only test the scribble and the according image
    [self setThumbnailViewProxy:aView];
    [[self view] addSubview:[self thumbnailViewProxy]];
    //only test the scribble and the according image

    
}
- (IBAction)undo:(id)sender
{
    [[self drawScribbleCommandManager] undoCommand];
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setStartPoint:CGPointZero];
}
- (IBAction)redo:(id)sender
{
    [[self drawScribbleCommandManager] redoCommand];
    
}


-(void)selectLeftAction:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:^{}];
}



-(UIImage*)convertViewToImage:(UIView*)v
{
    CGSize s = v.bounds.size;
    
    //UIGraphicsBeginImageContext(s);
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, YES, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
