//
//  WebViewController.m
//  E1
//
//  Created by linchuang on 22/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self webView] setDelegate:self];
    
    NSString *urlPath=nil;
    NSString* content=nil;
    if (![self indicator])
    {
        urlPath=[[NSBundle mainBundle] pathForResource:@"about" ofType:@"html" inDirectory:@"res"];
        content = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:urlPath] encoding:NSUTF8StringEncoding error:nil];

    }
    else
    {
         urlPath =[[NSBundle mainBundle] pathForResource:@"decl" ofType:@"html" inDirectory:@"res"];
        content = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:urlPath] encoding:NSUTF8StringEncoding error:nil];
    }
        
    
    
    
    
     [[self webView] loadHTMLString:content baseURL:[NSURL fileURLWithPath:[urlPath stringByDeletingLastPathComponent]]];
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType==UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    
    return YES;
}


@end
