//
//  DrawScribbleCommand.h
//  E1
//
//  Created by linchuang on 17/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "command.h"
#import "Mark.h"
#import "Scribble.h"
@interface DrawScribbleCommand : Command
{
    //weak concept
    //__weak id<Mark> _mark;
    //__weak Scribble* _scribble;
   //weak concept
    
    //id<Mark> _mark;
    //Scribble* _scribble;
    //BOOL _shouldBeAddedToPreviousMark;
    
    
    
}
//weak concept
//@property (nonatomic,weak) id<Mark> mark;
//@property(nonatomic,weak) Scribble* scribble;
//weak concept
//@property (nonatomic,strong) id<Mark> mark;
//@property(nonatomic,strong) Scribble* scribble;

//@property(nonatomic,assign) BOOL shouldBeAddedToPreviousMark;
@end
