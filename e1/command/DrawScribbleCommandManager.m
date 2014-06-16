//
//  DrawScribbleCommandManager.m
//  E1
//
//  Created by linchuang on 17/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "DrawScribbleCommandManager.h"
@interface DrawScribbleCommandManager()

@end




@implementation DrawScribbleCommandManager


@synthesize redoStack=_redoStack;
@synthesize undoStack=_undoStack;

-(void) executeCommand: (Command*) aCommand prepareForUndo:(BOOL)prepareForUndo
{
    if (prepareForUndo)
    {
        if ([self undoStack]==nil)
        {
            NSMutableArray* tmpArray=[[NSMutableArray alloc] initWithCapacity:levelsOfStacks];
            [self setUndoStack: tmpArray];
            
        }
        
        
   
        if ([[self undoStack] count]==levelsOfStacks)
            [[self undoStack] removeObjectAtIndex:0];
        
        [[self undoStack] addObject:aCommand];
     }
    [aCommand execute];
        
}
-(void) undoCommand
{
    Command* aCommand=nil;
    BOOL couldPerformRedo=NO;
    if ([[self undoStack] count]>0)
    {
        aCommand= [[self undoStack] lastObject];
        [aCommand undo];
        [[self undoStack] removeLastObject];
        couldPerformRedo=YES;
    }
    
    
    if (![self redoStack])
    {
        NSMutableArray* tmpArray=[[NSMutableArray alloc] initWithCapacity:levelsOfStacks];
        [self setRedoStack: tmpArray];
    }
    if ([[self redoStack] count]==levelsOfStacks)
        [[self redoStack] removeObjectAtIndex:0];
    if (couldPerformRedo)
    {
         [[self redoStack] addObject:aCommand];
    }
   

    
    
    
    
    
    
}

-(void) redoCommand
{
    Command* aCommand=nil;
    BOOL couldPerformUndo=NO;
    if ([[self redoStack] count]>0)
    {
        aCommand= [[self redoStack] lastObject];
        [aCommand execute];
        [[self redoStack] removeLastObject];
        couldPerformUndo=YES;
    }
    
    if ([self undoStack]==nil)
    {
        NSMutableArray* tmpArray=[[NSMutableArray alloc] initWithCapacity:levelsOfStacks];
        [self setUndoStack: tmpArray];
        
    }

    if ([[self undoStack] count]==levelsOfStacks)
        [[self undoStack] removeObjectAtIndex:0];
    if (couldPerformUndo)
    {
        [[self undoStack] addObject:aCommand];
    }
    
    
    
}
@end
