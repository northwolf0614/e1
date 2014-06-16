//
//  AboutViewController.h
//  E1
//
//  Created by linchuang on 22/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
