//
//  CanvasViewController.h
//  E1
//
//  Created by linchuang on 8/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CanvasView.h"
#import "Scribble.h"
#import "ScribbleManager.h"
#import "ScribbleThumbnaiViewProxy.h"
#import "DrawScribbleCommandManager.h"
@interface CanvasViewController : UIViewController
{
    @private
    CanvasView* _canvasView;
    Scribble* _scribble;
    CGPoint _startPoint;
    UIColor* _strokeColor;
    CGFloat _strokeSize;
    ScribbleManager* _scribbleManager;
    ScribbleThumbnaiViewProxy* _thumbnailViewProxy;
    DrawScribbleCommandManager* _drawScribbleCommandManager;
    
    
    
    
}

@property(nonatomic, strong)CanvasView* canvasView;
@property(nonatomic, strong)Scribble* scribble;
@property(nonatomic, assign) CGFloat strokeSize;
@property(nonatomic, strong) UIColor* strokeColor;
@property(nonatomic, assign) CGPoint startPoint;
@property(nonatomic, strong) ScribbleManager* scribbleManager;
@property(nonatomic, strong) ScribbleThumbnaiViewProxy* thumbnailViewProxy;
@property(nonatomic, strong) DrawScribbleCommandManager* drawScribbleCommandManager;


-(UIImage*)convertViewToImage:(UIView*)v;


@end
