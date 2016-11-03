//
//  LZHBTopClassViewController.m
//  Melife
//
//  Created by 刘志恒 on 16/10/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHBTopClassViewController.h"
#import <AFNetworking.h>
#import "LZHHTopModel.h"
#import "LZHHTopCell.h"
#import <MJRefresh.h>
#import "LZHOnlyViewController.h"


#define HURL @"http://m.api.zhe800.com/brand/list/v1"
@interface LZHBTopClassViewController ()<UITableViewDataSource,UITableViewDelegate>

//Tableview
@property(nonatomic,strong)UITableView *MainTableV;

@property(nonatomic,strong)AFHTTPSessionManager *manager;

@property(nonatomic,strong)NSMutableArray *DataArr;


@property(nonatomic,assign)NSInteger num;;

@property(nonatomic,assign)NSInteger page;

@property(nonatomic,assign)NSInteger total;

@end

@implementation LZHBTopClassViewController



-(NSMutableArray *)DataArr{
    
    if (!_DataArr) {
        
        _DataArr = [NSMutableArray array];
        
    }
    
    return _DataArr;
}

-(AFHTTPSessionManager *)manager{
    
    if (!_manager) {
        
        _manager = [AFHTTPSessionManager manager];
        
    }
    return _manager;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //设置collectionView
    [self setUpTableView];
    
    self.MainTableV.rowHeight = 150;
    
    //加载数据
    [self setUpRefresh];
    
}
//设置刷新控件
-(void)setUpRefresh{
    
    self.MainTableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(LoadData)];
    
    [self.MainTableV.mj_header beginRefreshing];
    
    self.MainTableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMoreData)];
    
    
}

#pragma mark加载数据
-(void)LoadData{
    
    self.num = 20;
    self.page = 1;
    
    [self.DataArr removeAllObjects];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"per_page"] = @(self.num);
    
    params[@"page"] = @(self.page);
    //接口的类型需要判断一下
    if (self.type == today_v2) {
        
        params[@"t_dim"] = @"today_v2";
        
    }else if (self.type == tomorrow_v2){
        
        params[@"t_dim"] = @"tomorrow_v2";
        
    }
    
    
    [self.manager GET:HURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.total = [responseObject[@"meta"][@"count"] integerValue];
        
        NSArray *arr = responseObject[@"objects"];
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in arr) {
            
            LZHHTopModel *model = [LZHHTopModel topmodelWithDict:dict];
            
            [arrM addObject: model];
            
        }
        
        self.DataArr = arrM;
        
        [self.MainTableV reloadData];
        
        [self.MainTableV.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
   
    }];
    
    
}
#pragma mark 加载更多数据
-(void)LoadMoreData{
    
    self.num += 20;
    
    self.page += 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"per_page"] = @(self.num);
    
    params[@"page"] = @(self.page);
    
    if (self.type == today_v2) {
        
        params[@"t_dim"] = @"today_v2";
        
    }else if (self.type == tomorrow_v2){
        
        params[@"t_dim"] = @"tomorrow_v2";
        
    }
    
    
    [self.manager GET:HURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arr = responseObject[@"objects"];
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in arr) {
            
            LZHHTopModel *model = [LZHHTopModel topmodelWithDict:dict];
            
            [arrM addObject: model];
            
        }
        
        [self.DataArr addObjectsFromArray:arrM];
        
        [self.MainTableV reloadData];
        
//        NSLog(@"目前的个数：%ld  总共的个数:%ld",self.total,self.DataArr.count);
        
        if (self.DataArr.count == 120 || self.DataArr.count == 37) {
            
            [self.MainTableV.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            
        [self.MainTableV.mj_footer endRefreshing];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
    
}
#pragma mark设置tableveiw
-(void)setUpTableView{
    
    _MainTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, LZHScreenW, LZHScreenH-69)];
    
    _MainTableV.delegate = self;
    
    _MainTableV.dataSource = self;
    
    _MainTableV.contentInset = UIEdgeInsetsMake(0, 0, 89, 0);
    
    _MainTableV.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:_MainTableV];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.DataArr.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    LZHHTopModel *model = self.DataArr[indexPath.row];
    
    static NSString *ID = @"cell";
    
    LZHHTopCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil) {
        
        cell = [LZHHTopCell hhtopcell];
        
    }
    
    cell.model = model;
    
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    LZHHTopModel *model = self.DataArr[indexPath.row];
    
    LZHOnlyViewController *only = [[LZHOnlyViewController alloc]init];
    
    only.ID = [model.ID integerValue];
    
    only.Names = model.name;
    
    [self.navigationController pushViewController:only animated:YES];
    
//    NSLog(@"------click-------");
    
}






@end
