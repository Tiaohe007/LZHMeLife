//
//  LZHRegisterViewController.m
//  Melife
//
//  Created by 刘志恒 on 16/11/2.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHRegisterViewController.h"
#import <SMS_SDK/SMSSDK.h>
@interface LZHRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *YZM;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *VCode;

@end

@implementation LZHRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"注册";

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
#pragma mark 获取验证码
- (IBAction)GetMessage:(id)sender {
   
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:@"18610470411" zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"SUCCESS!");
            //显示发送验证码
            [self showAlertWithString:@"验证码已发送!"];
        }else{
            
            NSLog(@"Fail!");
        }
    }];
    
    
    
}

#pragma mark 注册成功
- (IBAction)Registe:(id)sender {
    
    [SMSSDK commitVerificationCode:self.VCode.text phoneNumber:_phone.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
        if (!error) {
            NSLog(@"SUccess!");
            //显示注册成功
            [self showAlertWithString:@"注册成功!"];
        }else{
            NSLog(@"Fail! %@",error);
        }
    }];
    
    
}

-(void)showAlertWithString:(NSString *)str{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示:" message:str preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end
