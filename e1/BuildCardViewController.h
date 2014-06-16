//
//  BuildCardViewController.h
//  E1
//
//  Created by linchuang on 8/06/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PicInfo.h"
@interface BuildCardViewController : UIViewController<UITextFieldDelegate,UITabBarDelegate,UIToolbarDelegate>
@property(nonatomic,strong) PicInfo* picInfo;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(strong,nonatomic) UIImage* image;
@property (weak, nonatomic) IBOutlet UILabel *pinyin;
@property (weak, nonatomic) IBOutlet UILabel *pro_char;

@property (weak, nonatomic) IBOutlet UILabel *tone;
@property (weak, nonatomic) IBOutlet UITextField *content_pinyin;

@property (weak, nonatomic) IBOutlet UITextField *content_pro_char;
@property (weak, nonatomic) IBOutlet UITextField *content_tone;
@property (weak, nonatomic) IBOutlet UILabel *keyPoint;
@property (weak, nonatomic) IBOutlet UITextField *content_keyPoint;
@property (weak, nonatomic) IBOutlet UILabel *makingSentence;
@property (weak, nonatomic) IBOutlet UITextField *content_makingSentence;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property(assign,nonatomic) float adjust_Y_WhenKeyboardShowing;
@property(assign,nonatomic) CGRect currentBounds;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@end
