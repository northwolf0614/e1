//
//  PhotoCell.m
//  E1
//
//  Created by linchuang on 3/06/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
 CGContextRef context= UIGraphicsGetCurrentContext();
 //if _realImage==nil we have to draw a default image,then launch a thread which shall load the image and redraw it
 
 if ([[self imageView] image]==nil)
 {
     [self drawDefaultImage:context rect:rect];
 
 }
 //first else
// else// this branch means that the image has been loarded(_realImage!=nil).this branch shall be invoke by "[self performSelectorInBackground:@selector(setNeedsDisplay) withObject:nil];" in the forwardImageLoadingThread function
 //{
   //  [[[self imageView] image] drawInRect:rect];
 
 //}

}
-(void)drawDefaultImage:(CGContextRef) context rect:(CGRect) aRect
{
    UIGraphicsPushContext(context);
    
    //setting up the configuration of context
    CGContextSetLineWidth(context, 5);//set the width of line
    CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);// set the color of line
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);//set the filling color
    //setting up the configuration of context
    
    //draw content here
    CGContextAddRect(context, aRect);
    CGContextDrawPath(context, kCGPathFillStroke);
    //draw content here
    
    UIGraphicsPopContext();
    
}

@end
