//
//  StartViewController.h
//  E1
//
//  Created by linchuang on 21/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartViewController : UIViewController<UIScrollViewDelegate>


//@property (weak, nonatomic) IBOutlet UIScrollView *startPagesView;
//@property (weak, nonatomic) IBOutlet UIPageControl *pageCon;
@property (strong, nonatomic)  UIPageControl *pageCon;

//@property (weak, nonatomic) IBOutlet UIScrollView *startPagesView;
@property (strong, nonatomic)  UIScrollView *startPagesView;

//@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic)  UIButton *startButton;

@end
