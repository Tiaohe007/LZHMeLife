//
//  LZHBrandViewController.m
//  Melife
//
//  Created by 刘志恒 on 16/10/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHBrandViewController.h"
#import "LZHHotSaleViewController.h"
#import "LZHBTopClassViewController.h"

@interface LZHBrandViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *contentView;

@property(nonatomic,strong)UIScrollView *scrollV;

//来存储按钮
@property(nonatomic,strong)NSMutableArray *btns;

//底部的指示器
@property(nonatomic,strong)UIView *indicator;

@property(nonatomic,strong)UIButton *selectedBtn;

@end

@implementation LZHBrandViewController

-(NSMutableArray *)btns{
    
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    
    return _btns;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"品牌";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加子控制器到主viewController上
    [self setUpChildrenControllers];
    
    //添加显示控制器的scrollview
    [self setUpControllerView];
    
    //设置滚动的标题栏
    [self setUpTitleView];
    
}
//添加子控制器到主viewController上
-(void)setUpChildrenControllers{
    
    //正在热销
    LZHHotSaleViewController *hot = [[LZHHotSaleViewController alloc]init];
    
//    hot.view.backgroundColor = [UIColor orangeColor];
    
    [self addChildViewController:hot];
    
    //最新上架 即将下架 精品预告
    
    LZHBTopClassViewController *willOn = [[LZHBTopClassViewController alloc]init];
    willOn.type = today_v2;
    
    [self addChildViewController:willOn];
    
    LZHBTopClassViewController *willDown = [[LZHBTopClassViewController alloc]init];
    
    willDown.type = today_v2;
    
    [self addChildViewController:willDown];
    
    LZHBTopClassViewController *attention = [[LZHBTopClassViewController alloc]init];
    
    attention.type = tomorrow_v2;
    
    [self addChildViewController:attention];
    
}
//添加显示控制器的scrollview
-(void)setUpControllerView{
    
    
    self.contentView.userInteractionEnabled = YES;
    
    self.contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, LZHScreenW, LZHScreenH-44)];
    
    //设置滚动的范围
    NSInteger num = self.childViewControllers.count;
    
    
//    NSLog(@"====%ld====",(long)num);
    
    self.contentView.contentSize = CGSizeMake(num*LZHScreenW, 0);
    
    //需要翻页就得开启翻页模式
    self.contentView.pagingEnabled = YES;
    //关闭弹簧效果
    self.contentView.bounces = NO;
    
    
    [self.view addSubview:self.contentView];
    
    
}
-(void)setUpTitleView{
    
    
    UIScrollView *scrollV = [[UIScrollView alloc]init];
    
    scrollV.bounces = NO;
    
    
    scrollV.backgroundColor = [UIColor whiteColor];
    
    scrollV.frame = CGRectMake(0, 64, LZHScreenW, 44);
    
    [self.view addSubview:scrollV];
    
    self.scrollV = scrollV;
    
    self.scrollV.delegate = self;
    
    scrollV.showsHorizontalScrollIndicator = NO;
    
#pragma mark  添加底部的指示器
    
    UIView *indicator = [[UIView alloc]initWithFrame:CGRectMake(0, 42, LZHScreenW, 2)];
    
    indicator.backgroundColor = [UIColor colorWithRed:82/255.0f green:194/255.0f blue:136/255.0f alpha:1.0];
    //
    
    //    indicator.height = 2;
    //
    //    indicator.y = self.scrollV.height - indicator.height;
    
    self.indicator = indicator;
    
    
    
#pragma 添加btn到scrollview上
    
    NSArray *titles = @[@"正在热销",@"最新上架",@"即将下架",@"精品预告"];
    
    
    CGFloat Y = 2;
    CGFloat W = 100;
    CGFloat H = 40;
    CGFloat Margin = 5;
    
    for (int i = 0; i<titles.count; i++) {
        
        UIButton *btn = [[UIButton alloc]init];
        
        CGFloat X = i*(W +Margin)+Margin;
        
        btn.frame = CGRectMake(X, Y, W, H);
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [btn layoutIfNeeded];
        
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        //给btn一个tag值
        btn.tag = i;
        
        //把btn存储起来
        [self.btns addObject:btn];
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        //默认进来就显示第一个控制器
        if(i == 0){
            
            //默认页面一显示出来就默认相当于点击了第一个按钮
            [self click:btn];
            
            self.indicator.centerX = btn.centerX;
            self.indicator.width = btn.width;
            
            UITableViewController *vc = self.childViewControllers[0];
            vc.view.frame = CGRectMake(0, 0, LZHScreenW, LZHScreenH);
            [self.contentView addSubview:vc.view];
            
        }
        
        [_scrollV addSubview:btn];
    }
    
    
    //添加指示器
    [_scrollV addSubview:self.indicator];
    
    _scrollV.pagingEnabled = NO;
    _scrollV.contentSize = CGSizeMake((Margin+W)*titles.count+Margin, 0);
    _scrollV.contentInset = UIEdgeInsetsMake(0, Margin, 0, 0);
}

-(void)click:(UIButton *)button{
    
    
    self.selectedBtn.selected = NO;
    
    self.selectedBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    button.selected = YES;
    
    [button setTitleColor:[UIColor colorWithRed:82/255.0f green:194/255.0f blue:136/255.0f alpha:1.0] forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    
    self.selectedBtn = button;
    
    
    self.contentView.delegate = self;
    
#pragma mark 指示器跟着点击 也同时显示出来跟着点击的按钮走
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicator.centerX = button.centerX;
        self.indicator.width = button.width;
        
    }];
    
    CGFloat offsetX = button.center.x - LZHScreenW*0.5;
    if (offsetX<0) {
        offsetX = 0;
    }
    CGFloat maxoffsetX = self.scrollV.contentSize.width - LZHScreenW;
    if (offsetX > maxoffsetX) {
        offsetX = maxoffsetX;
    }
    [self.scrollV setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    
#pragma mark  点击标题显示对应的控制器出来
    NSInteger num = button.tag;
    
    CGFloat offsetx = num * LZHScreenW;
    //    NSLog(@"----%f",offsetx);
    
    self.contentView.contentOffset = CGPointMake(offsetx, 0);
    
    UIViewController *vc = self.childViewControllers[num];
    
    vc.automaticallyAdjustsScrollViewInsets = NO;
    
    vc.view.frame = CGRectMake(offsetx, 0, LZHScreenW, self.contentView.frame.size.height);
    
    [self.contentView addSubview:vc.view];
    
}
//当scrollview滚动完毕的时候 的监听方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.contentView) {
        
        NSInteger num = scrollView.contentOffset.x / scrollView.bounds.size.width;
    //                NSLog(@"------%ld-----",(long)num);
    UIViewController *vc = self.childViewControllers[num];
        
    //控制 控制器的尺寸为    滚动了几个控制器就用个数乘以屏幕的宽 宽高为contentView的宽高
    vc.view.frame = CGRectMake(num*LZHScreenW, 0, LZHScreenW, self.contentView.frame.size.height);
    
    vc.view.autoresizesSubviews = NO;
    
    [self.contentView addSubview:vc.view];
    
    //根据num从button数组中找到某一个button来去调用btn的监听方法来实现特定效果
    UIButton *followBtn = self.btns[num];
    
    [self click:followBtn];
    [self centerButton:followBtn];
    }
    
    
}

//设置标题按钮文字的居中效果
-(void)centerButton:(UIButton *)button{
    
    CGFloat offsetX = button.center.x - LZHScreenW*0.5;
    if (offsetX<0) {
        offsetX = 0;
    }
    CGFloat maxoffsetX = self.scrollV.contentSize.width - LZHScreenW;
    if (offsetX > maxoffsetX) {
        offsetX = maxoffsetX;
    }
    [self.scrollV setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    
}



@end
