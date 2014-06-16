//
//  DrawScribbleCommand.m
//  E1
//
//  Created by linchuang on 17/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "DrawScribbleCommand.h"

@implementation DrawScribbleCommand
//@synthesize mark=_mark;
//@synthesize scribble=_scribble;
//@synthesize shouldBeAddedToPreviousMark=_shouldBeAddedToPreviousMark;



-(void)execute
{
    
    
    if (![self userCommandInfo]) {
        return;
    }
    id<Mark> tmpMak=[[self userCommandInfo] objectForKey:@"markObjectUserCommandInfo"];
    //[self setMark:tmpMak];
    Scribble* tmpScribble=[[self userCommandInfo] objectForKey:@"scribbleObjectUserCommandInfo"];
    //[self setScribble:tmpScribble];
    BOOL tmpShouldBeAddedToPreviousMark=[[[self userCommandInfo] objectForKey:@"shouldBeAddedToPreciousUserCommandInfo"] boolValue];
    //[self setShouldBeAddedToPreviousMark:tmpShouldBeAddedToPreviousMark];
    
    [tmpScribble  addMark:tmpMak shouldAddToPreviousMark:tmpShouldBeAddedToPreviousMark];
    
    
}
-(void)undo
{
    
    //[[self scribble] removeMark:[self mark]];
    
    if (![self userCommandInfo]) {
        return;
    }
    id<Mark> tmpMak=[[self userCommandInfo] objectForKey:@"markObjectUserCommandInfo"];
        //[self setMark:tmpMak];
    Scribble* tmpScribble=[[self userCommandInfo] objectForKey:@"scribbleObjectUserCommandInfo"];
    //[self setScribble:tmpScribble];
    //BOOL tmpShouldBeAddedToPreviousMark=[[[self userCommandInfo] objectForKey:@"shouldBeAddedToPreciousUserCommandInfo"] boolValue];
    //[self setShouldBeAddedToPreviousMark:tmpShouldBeAddedToPreviousMark];
    
    [tmpScribble  removeMark:tmpMak ];
    
}


@end
