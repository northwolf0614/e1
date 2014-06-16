//
//  PicInfo.h
//  E1
//
//  Created by linchuang on 7/06/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PicInfo : NSObject

@property(nonatomic,strong) NSString* fileName;
@property(nonatomic,strong) UIImage* thumbnailPic;
@property(nonatomic,assign) CGImageRef imgRef;
@property(nonatomic,strong) UIImage* picture;


@end
