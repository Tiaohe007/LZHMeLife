//
//  LZHTopClassViewController.m
//  Melife
//
//  Created by 刘志恒 on 16/10/17.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHTopClassViewController.h"
#import "LZHTopModel.h"
#import "LZHTopCell.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import "LZHWebViewController.h"


@interface LZHTopClassViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionV;

@property(nonatomic,strong)NSMutableArray *DataArr;
//保存个数
@property(nonatomic,assign)NSInteger num;
//保存页码
@property(nonatomic,assign)NSInteger page;
@end

@implementation LZHTopClassViewController

static NSString *ID = @"cell";

-(NSMutableArray *)DataArr{

    if (!_DataArr) {
        _DataArr = [NSMutableArray array];
    }
    return _DataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    //设置collectionView
    [self setUpCollectionView];
    
    //加载数据
    [self setUpRefresh];
    
}
-(void)setUpRefresh{
    
//    
    self.collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    [self.collectionV.mj_header beginRefreshing];
    
    self.collectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //开始出来要隐藏 要不然就显示在上部和下拉刷新显示在一起的
    self.collectionV.mj_footer.hidden = YES;
    
}
-(void)loadData{
    
    self.num = 20;
    self.page = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *name = [NSString stringWithFormat:@"wireless%u",self.type];
    
    params[@"url_name"] = name;
    
    params[@"per_page"] = @(self.num);
    
    params[@"page"] = @(self.page);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:URL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"-------%@",responseObject);
        
        NSArray *arr = responseObject[@"objects"];
        
        for (NSDictionary *dict in arr) {
            LZHTopModel *model = [LZHTopModel topmodelWithDict:dict];
            
            [self.DataArr addObject:model];
        }
        
        [self.collectionV reloadData];
        
        [self.collectionV.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}
-(void)loadMoreData{
    
    self.num += 20;
    self.page +=1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *name = [NSString stringWithFormat:@"wireless%u",self.type];
    
    params[@"url_name"] = name;
    
    params[@"per_page"] = @(self.num);
    
    params[@"page"] = @(self.page);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:URL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        NSLog(@"-------%@",responseObject);
        
        NSArray *arr = responseObject[@"objects"];
        
        for (NSDictionary *dict in arr) {
            LZHTopModel *model = [LZHTopModel topmodelWithDict:dict];
            
            [self.DataArr addObject:model];
        }
        
        [self.collectionV reloadData];
        
        [self.collectionV.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}


//设置collectionView
-(void)setUpCollectionView{
    
#pragma mark Step.1 设置好collectionvie的布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    
    if (LZHScreenW == 414) {
        layout.itemSize = CGSizeMake(190, 250);
        layout.scrollDirection = 0;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(15, 12, 50, 12);
    }else if (LZHScreenW == 375){
        
        layout.itemSize = CGSizeMake(172.5, 220);
        layout.scrollDirection = 0;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(15, 10, 50, 10);
    }else{
        
        layout.itemSize = CGSizeMake(145, 190);
        layout.scrollDirection = 0;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(15, 12, 50, 12);
    }
    
#pragma mark再设置collectionveiw
    
    _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) collectionViewLayout:layout];
    
    
    _collectionV.backgroundColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1.0];
    
    _collectionV.delegate = self;
    
    _collectionV.dataSource = self;
    
    
    //让collection里面内容全部显示出来
    _collectionV.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    //    UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
#pragma mark 给collectionview的cell注册类
    //    [_collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [_collectionV registerNib:[UINib nibWithNibName:@"LZHTopCell" bundle:nil] forCellWithReuseIdentifier:ID];

    [self.view addSubview:_collectionV];
    
}
#pragma mark collectionview的代理方法

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LZHTopModel *model = self.DataArr[indexPath.row];
    
    LZHTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [LZHTopCell topcell];
    }
    
    cell.layer.cornerRadius = 5;
    
    cell.layer.masksToBounds = YES;
    
    cell.topmodel = model;
    
    return cell;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.DataArr.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"%ld",(long)indexPath.row);
    
    LZHTopModel *model = self.DataArr[indexPath.row];
    
    LZHWebViewController *web = [[LZHWebViewController alloc]init];
    
    web.hidesBottomBarWhenPushed = YES;
    
    web.url = model.origin_deal_url;
    
    [self.navigationController pushViewController:web animated:YES];
    
    
}






@end