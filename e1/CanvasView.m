//
//  CanvasView.m
//  E1
//
//  Created by linchuang on 8/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "CanvasView.h"

@implementation CanvasView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //added
        [self setBackgroundColor:[UIColor redColor]];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context= UIGraphicsGetCurrentContext();
    [[self markDelegate] drawWithContext:context];
}


@end
