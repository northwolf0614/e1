//
//  AboutViewController.m
//  E1
//
//  Created by linchuang on 22/05/2014.
//  Copyright (c) 2014 linchuang. All rights reserved.
//

#import "AboutViewController.h"
#import "WebViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];

    
    // Do any additional setup after loading the view.
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



#pragma mark - UITableViewDataSource and UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!section) {
        return 1;
    }
    else
        return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* aboutTableViewCell=@"aboutTableViewCell";
    UITableViewCell *cell = [[self tableView] dequeueReusableCellWithIdentifier:aboutTableViewCell];
    if (!cell)
    {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aboutTableViewCell];
    }
    
    NSArray *text = @[@"新手指南", @"评价应用", @"软件版本", @"免责声明"];
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:23];
    
    if (indexPath.row==0&&indexPath.section==0)
    {
        [[cell textLabel] setText:@"客服电话"];
        [[cell detailTextLabel] setText:@"400-650-9179"];
        [[cell detailTextLabel] setTextColor:[UIColor blueColor]];
        

        NSString* resPath=[[NSBundle mainBundle] pathForResource:@"AboutIcon1" ofType:@"png" inDirectory:@"res"];
        
        
        [[cell imageView] setImage:[UIImage imageWithContentsOfFile:resPath]];
    }
    else
    {
        [[cell textLabel] setText: [text objectAtIndex:indexPath.row]];
        //[[cell detailTextLabel] setText:nil];
        NSString* resPath=[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"AboutIcon%ld",(long int)(indexPath.row+2)] ofType:@"png" inDirectory:@"res"];
        
        
        [[cell imageView ] setImage:[UIImage imageWithContentsOfFile:resPath]];
    }
    
    
   
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // clear selected state
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    /*
    // TODO: Add handling to the commands
    if (indexPath.row==0&&indexPath.section==0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4006509179"]];
    }
    */
    if (indexPath.row==0&&indexPath.section==1)
    {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController0 = [sb instantiateViewControllerWithIdentifier:@"Start"];
        
        [self.navigationController pushViewController:viewController0 animated:YES];
    }
    
    else if (indexPath.row==1&&indexPath.section==1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/us/app/change-xing-shou-ji-ban-lu/id688643382?ls=1&mt=8"]];
    }
   
    else if (indexPath.row==2&&indexPath.section==1)
    {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WebViewController *viewController2 = [sb instantiateViewControllerWithIdentifier:@"Web"];
        [viewController2 setTitle:@"软件版本"];
        [viewController2 setIndicator:NO];
        
        [[self navigationController] pushViewController:viewController2 animated:YES];
    }
    else if (indexPath.row==3&&indexPath.section==1)
    {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WebViewController *viewController3= [sb instantiateViewControllerWithIdentifier:@"Web"];
        [viewController3 setTitle: @"免责声明"];
        [viewController3 setIndicator:YES];
        [[self navigationController] pushViewController:viewController3 animated:YES];
    }
    
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return @"客户服务联系方式";
    }
    else
        return @"其它信息";
}
















@end
