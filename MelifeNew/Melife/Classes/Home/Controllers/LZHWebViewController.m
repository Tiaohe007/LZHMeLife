//
//  LZHWebViewController.m
//  Melife
//
//  Created by 刘志恒 on 16/10/27.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHWebViewController.h"

@interface LZHWebViewController ()

@end

@implementation LZHWebViewController

-(void)loadView{
    

    self.view = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];

}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"商品详情";

    UIWebView *web = (UIWebView *)self.view;

    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
