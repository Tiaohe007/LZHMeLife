//
//  LZHMineViewController.m
//  Melife
//
//  Created by 刘志恒 on 16/11/2.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHMineViewController.h"
#import "LZHRegisterViewController.h"

@interface LZHMineViewController ()
- (IBAction)Rbt:(id)sender;

@end

@implementation LZHMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (IBAction)Rbt:(id)sender {
    
    LZHRegisterViewController *reg = [[LZHRegisterViewController alloc]init];
    
    [self.navigationController pushViewController:reg animated:YES];
}
@end
