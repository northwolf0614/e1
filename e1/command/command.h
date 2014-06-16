//
//  command.h
//  E1
//
//  Created by linchuang on 17/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Command : NSObject
{
    @protected
    NSDictionary* _userCommandInfo;
}
@property(nonatomic,strong) NSDictionary* userCommandInfo;
-(void)execute;
-(void)undo;

@end
