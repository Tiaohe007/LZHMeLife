//
//  LZHHomeViewController.m
//  Melife
//
//  Created by 刘志恒 on 16/10/17.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHHomeViewController.h"
#import "LZHTopClassViewController.h"




@interface LZHHomeViewController ()<UIScrollViewDelegate>

//显示控制器的scrollview
@property(nonatomic,strong)UIScrollView *controllerScrollview;

@property(nonatomic,strong)UIScrollView *scrollV;

//来存储按钮
@property(nonatomic,strong)NSMutableArray *btns;

//底部的指示器
@property(nonatomic,strong)UIView *indicator;

@property(nonatomic,strong)UIButton *selectedBtn;


@end

@implementation LZHHomeViewController

-(NSMutableArray *)btns{
    
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    
    return _btns;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";

    //添加子控制器到主viewController上
    [self setUpChildrenControllers];
    
    //设置当前控制器的导航栏属性
    [self setUpNavi];
    
    //添加显示控制器的scrollview
    [self setUpControllerView];
    
    //设置滚动的标题栏
    [self setUpTitleView];
    
    
    //关闭这个控制器上的自动适应scrollview的功能
    self.automaticallyAdjustsScrollViewInsets =NO;
    

}
//添加子控制器
-(void)setUpChildrenControllers{

    
    LZHTopClassViewController *Man = [[LZHTopClassViewController alloc]init];
    
    Man.type = LZHTypeMan;
    
    [self addChildViewController:Man];
    
    LZHTopClassViewController *shuma = [[LZHTopClassViewController alloc]init];
    
    shuma.type = LZHTypeSMJD;
    
    [self addChildViewController:shuma];
    
    LZHTopClassViewController *wenyu = [[LZHTopClassViewController alloc]init];
    
    wenyu.type = LZHTypeWYSports;
    
    [self addChildViewController:wenyu];
    
    LZHTopClassViewController *under = [[LZHTopClassViewController alloc]init];
    
    under.type = LZHTypeUnderWear;
    
    [self addChildViewController:under];
    
    
    LZHTopClassViewController *jujia = [[LZHTopClassViewController alloc]init];
    
    jujia.type = LZHTypeJUJIA;
    
    [self addChildViewController:jujia];
    
    LZHTopClassViewController *jiafang = [[LZHTopClassViewController alloc]init];
    
    jiafang.type = LZHTypeJIAF;
    
    [self addChildViewController:jiafang];
    
    
    LZHTopClassViewController *shoes = [[LZHTopClassViewController alloc]init];
    
    shoes.type = LZHTypeXIEPIN;
    
    [self addChildViewController:shoes];
    
    LZHTopClassViewController *bao = [[LZHTopClassViewController alloc]init];
    
    bao.type = LZHTypeXBAO;
    
    [self addChildViewController:bao];
    
    LZHTopClassViewController *food = [[LZHTopClassViewController alloc]init];
    
    food.type = LZHTypeFOOD;
    
    [self addChildViewController:food];
    
    LZHTopClassViewController *woman = [[LZHTopClassViewController alloc]init];
    
    woman.type = LZHTypeWoman;
    
    [self addChildViewController:woman];


}
//设置导航栏的属性
-(void)setUpNavi{

    
    //右边的按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriRenderingImage:@"search_navBar"] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    
    
}
-(void)search{

    NSLog(@"123123");
}
//添加显示控制器的scrollview
-(void)setUpControllerView{

    self.controllerScrollview.userInteractionEnabled = YES;
    
    self.controllerScrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, LZHScreenW, LZHScreenH-44)];
    
    //设置滚动的范围
    NSInteger num = self.childViewControllers.count;
    
    self.controllerScrollview.contentSize = CGSizeMake(num*LZHScreenW, 0);
    
    //需要翻页就得开启翻页模式
    self.controllerScrollview.pagingEnabled = YES;
    //关闭弹簧效果
    self.controllerScrollview.bounces = NO;
    
    
    [self.view addSubview:self.controllerScrollview];
    
}

//添加显示标题的scrollview
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
    
    NSArray *titles = @[@"男装",@"数码家电",@"文娱运动",@"内衣",@"居家",@"家纺",@"鞋品",@"箱包",@"美食",@"女装"];
    
    
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
            [self.controllerScrollview addSubview:vc.view];
            
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
    
    
    self.controllerScrollview.delegate = self;
    
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
    
    self.controllerScrollview.contentOffset = CGPointMake(offsetx, 0);
    
    UIViewController *vc = self.childViewControllers[num];
    
    vc.automaticallyAdjustsScrollViewInsets = NO;
    
    vc.view.frame = CGRectMake(offsetx, 0, LZHScreenW, self.controllerScrollview.frame.size.height);
    
    [self.controllerScrollview addSubview:vc.view];
    
}
//当scrollview滚动完毕的时候 的监听方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.controllerScrollview) {
        NSInteger num = scrollView.contentOffset.x / scrollView.bounds.size.width;
        //        NSLog(@"%ld",(long)num);
        UIViewController *vc = self.childViewControllers[num];
        
        //控制 控制器的尺寸为    滚动了几个控制器就用个数乘以屏幕的宽 宽高为contentView的宽高
        vc.view.frame = CGRectMake(num*LZHScreenW, 0, LZHScreenW, self.controllerScrollview.frame.size.height);
        
        vc.view.autoresizesSubviews = NO;
        
        [self.controllerScrollview addSubview:vc.view];
        
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
