//
//  LZHTabBarController.m
//  Melife
//
//  Created by 刘志恒 on 16/10/17.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHTabBarController.h"
#import "LZHHomeViewController.h"
#import "LZHBrandViewController.h"
#import "LZHNearByViewController.h"
#import "LZHMineViewController.h"
@interface LZHTabBarController ()

@end

@implementation LZHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setUpChildViewControllers];


}

//进来之后加载tabbar上面的控制器
-(void)setUpChildViewControllers{

    
    //首页
    
    LZHHomeViewController *vc = [[LZHHomeViewController alloc]init];
    
    [self setUpOneChildViewControllersWith:vc andImage:[UIImage imageNamed:@"tab_main_37x37_"] andTitle:@"首页"];
    
    //品牌
    LZHBrandViewController *brand = [[LZHBrandViewController alloc]init];
    
    [self setUpOneChildViewControllersWith:brand andImage:[UIImage imageNamed:@"tab_cat_37x37_"] andTitle:@"品牌"];
    
    //附近
    
    UIViewController *near = [[LZHNearByViewController alloc]init];
    
    [self setUpOneChildViewControllersWith:near andImage:[UIImage imageNamed:@"tab_map_37x37_"] andTitle:@"附近"];
    
    //我的
    UIViewController *mine = [[LZHMineViewController alloc]init];
    
    [self setUpOneChildViewControllersWith:mine andImage:[UIImage imageNamed:@"tab_self_37x37_"] andTitle:@"我的"];
    
}

-(void)setUpOneChildViewControllersWith:(UIViewController *)vc andImage:(UIImage *)image andTitle:(NSString *)title{

    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    

    

    //给子控制器包装一个导航控制器
    
    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:nv];
    
    
    
}



@end
