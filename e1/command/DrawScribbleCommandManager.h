//
//  DrawScribbleCommandManager.h
//  E1
//
//  Created by linchuang on 17/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "DrawScribbleCommand.h"
#define levelsOfStacks 10
@interface DrawScribbleCommandManager : NSObject
{
    @private
    NSMutableArray* _undoStack;
    NSMutableArray* _redoStack;
}
@property(nonatomic,strong)NSMutableArray* undoStack;
@property(nonatomic,strong)NSMutableArray* redoStack;

-(void) executeCommand: (Command*) command prepareForUndo:(BOOL)prepareForUndo;
-(void) undoCommand;
-(void) redoCommand;
@end
