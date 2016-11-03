//
//  LZHShowMoreViewController.m
//  Melife
//
//  Created by 刘志恒 on 16/10/30.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHShowMoreViewController.h"

@interface LZHShowMoreViewController ()

@end

@implementation LZHShowMoreViewController

-(void)loadView{
    
    self.view = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"商品详情";

    UIWebView *web = (UIWebView *)self.view;
    
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];

}



@end
