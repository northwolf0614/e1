//
//  WebViewController.h
//  E1
//
//  Created by linchuang on 22/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(strong, nonatomic) NSString* htmlString;
@property(assign,nonatomic) BOOL indicator;

@end
