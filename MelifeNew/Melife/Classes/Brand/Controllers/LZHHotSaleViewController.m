//
//  LZHHotSaleViewController.m
//  Melife
//
//  Created by 刘志恒 on 16/10/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHHotSaleViewController.h"
#import "LZHLeftCell.h"
#import "LZHRightCell.h"
#import <AFNetworking.h>
#import "LZHRFirsitModel.h"
#import <MJRefresh.h>
#import "LZHShowMoreViewController.h"
#import "LZHOnlyViewController.h"

#define FirstUrl @"http://m.api.zhe800.com/brand/list/v1"
@interface LZHHotSaleViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView *leftTV;

@property(nonatomic,strong)UITableView *RightTV;

@property(nonatomic,strong)AFHTTPSessionManager *manager;

@property(nonatomic,strong)NSArray *arr;
//存储数据的数组
@property(nonatomic,strong)NSMutableArray *DataArr;
//保存个数
@property(nonatomic,assign)NSInteger num;
//保存页码
@property(nonatomic,assign)NSInteger page;
//接口里面的种类数字的数组
@property(nonatomic,strong)NSArray *types;
//cell的总个数
@property(nonatomic,strong)NSString *TotalCounts;


@end

@implementation LZHHotSaleViewController
static NSString *IDL = @"L";
static NSString *IDR = @"R";


-(AFHTTPSessionManager *)manager{
    
    if (!_manager) {
        
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
}

-(NSArray *)types{
    
    if (!_types) {
        _types = [NSArray arrayWithObjects:@"19",@"17",@"31",@"53",@"43",@"49",@"29",@"35",@"39",@"33",@"41",@"51",@"37", nil];
    }
    return _types;
    
}
-(NSArray *)arr{
    
    if (!_arr) {
        _arr = [NSArray arrayWithObjects:@"男装",@"女装",@"母婴",@"内衣",@"美妆",@"配饰",@"箱包",@"居家",@"食品",@"家纺",@"数码",@"文体",@"家电", nil];
    }
    return _arr;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

   
    
    //添加左侧的tableview
    [self setUpLeftTableView];
    
    //添加刷新控件
    [self setUpRefresh];
    
    //默认选中第一行
    [self.leftTV selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    
    [self LoadRightData];
    

}

-(void)setUpRefresh{
    
    //一进来就加载右边的数据
//    self.RightTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(LoadRightData)];
//    
//    [self.RightTV.mj_header beginRefreshing];
    
    self.RightTV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadrightMoreData)];
    
}
#pragma mark 刚进来就第一次加载数据
-(void)LoadRightData{
    
    self.num = 20;
    self.page = 0;
    
    [self.DataArr removeAllObjects];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"url_name"] = @"19";
    
    params[@"per_page"] = @(self.num);
    
    params[@"page"] = @(self.page);
    
    [self.manager GET:FirstUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"-------%@",responseObject);
        
        NSArray *arr = responseObject[@"objects"];
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in arr) {
            
            LZHRFirsitModel *model = [LZHRFirsitModel firstmodelWithDict:dict];
            
            [arrM addObject:model];
            
        }
        
        self.DataArr = arrM;
        
        [self.RightTV reloadData];
        
        
        [self.RightTV.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}

#pragma mark第一次加载更多数据
-(void)LoadrightMoreData{
    
    self.num += 20;
    self.page += 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"url_name"] = @"19";
    
    params[@"per_page"] = @(self.num);
    
    params[@"page"] = @(self.page);
    
    [self.manager GET:FirstUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"-------%@",responseObject);
        
        NSArray *arr = responseObject[@"objects"];
        
        self.TotalCounts = responseObject[@"meta"][@"count"];
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in arr) {
            
            LZHRFirsitModel *model = [LZHRFirsitModel firstmodelWithDict:dict];
            
            [arrM addObject:model];
            
        }
        
        [self.DataArr addObjectsFromArray:arrM];
        
        [self.RightTV reloadData];
        
//        NSLog(@"目前的个数：%ld,总共的个数：%ld",self.DataArr.count,[self.TotalCounts integerValue]);
        
        if (self.DataArr.count == ([self.TotalCounts integerValue]+9)) {
            
            [self.RightTV.mj_footer endRefreshingWithNoMoreData];
            
        }else{
        
        [self.RightTV.mj_footer endRefreshing];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
}
//添加左侧的tableview
-(void)setUpLeftTableView{
    
    
    
    UITableView *leftTV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 85, LZHScreenH-44)];
    
    leftTV.contentInset = UIEdgeInsetsMake(44, 0, 69, 0);
    
    self.leftTV = leftTV;
    
    [self.leftTV registerNib:[UINib nibWithNibName:NSStringFromClass([LZHLeftCell class]) bundle:nil] forCellReuseIdentifier:IDL];
//    [self.LeftTV registerNib:[UINib nibWithNibName:NSStringFromClass([LZHLeftTableViewCell class]) bundle:nil] 
    
    [self.view addSubview:self.leftTV];
   
    self.leftTV.delegate = self;
    
    self.leftTV.dataSource = self;
    
    UITableView *RightTV = [[UITableView alloc]initWithFrame:CGRectMake(85, 0, LZHScreenW-85, LZHScreenH-44)];
    
    RightTV.contentInset = UIEdgeInsetsMake(44, 0, 69, 0);
    
    self.RightTV = RightTV;
    
    self.RightTV.rowHeight = 150;
    
    [self.view addSubview:self.RightTV];
    
    self.RightTV.delegate =self;
    
    self.RightTV.dataSource = self;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    if (tableView == self.leftTV) {
        
        return self.arr.count;
    
    }else{

        return self.DataArr.count;
    
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    LZHRFirsitModel *model = self.DataArr[indexPath.row];
    
//    UITableViewCell *temp = nil;
    
    if (tableView == self.leftTV) {
        
        LZHLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:IDL];
        
        cell.height = 82;
   
#pragma mark 如果想要选中cell时 背景没有颜色可以把这个设置为None
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = self.arr[indexPath.row];
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;

        return cell;
        
    }else{
        
        LZHRightCell *cell = [tableView dequeueReusableCellWithIdentifier:IDR];
        
        if (cell == nil) {
            
            cell = [LZHRightCell rightcell];
        
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.model = model;
        
        return cell;
    }
 
}

#pragma mark 点击了cell跳转之后的代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    if (tableView == self.leftTV) {
        
//        [self LoadRightDataWithType:self.types[indexPath.row]];
        
        self.RightTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [self LoadRightDataWithType:self.types[indexPath.row]];
        }];
        
        [self.RightTV.mj_header beginRefreshing];
        
        
        self.RightTV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [self LoadrightMoreDataWithType:self.types[indexPath.row]];
            
        }];
        
        
        
    }else{
        
        LZHRFirsitModel *model = self.DataArr[indexPath.row];
        
        LZHOnlyViewController *only = [[LZHOnlyViewController alloc]init];
        
        only.ID = [model.ID integerValue];
        
        only.Names = model.name;
        
        [self.navigationController pushViewController:only animated:YES];
        
    }
    
}
#pragma mark 第二次点击了其他类别加载的数据
-(void)LoadRightDataWithType:(NSString *)type{
    
    self.num = 20;
    self.page = 0;
    
    [self.DataArr removeAllObjects];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"url_name"] = type;
    
    params[@"per_page"] = @(self.num);
    
    params[@"page"] = @(self.page);
    
    [self.manager GET:FirstUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"-------%@",responseObject);
        
        NSArray *arr = responseObject[@"objects"];
        
        self.TotalCounts = responseObject[@"meta"][@"count"];
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in arr) {
            
            LZHRFirsitModel *model = [LZHRFirsitModel firstmodelWithDict:dict];
            
            [arrM addObject:model];
            
        }
        
        self.DataArr = arrM;
        
        [self.RightTV reloadData];
        
        [self.RightTV.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}
#pragma mark 第二次点击其他的按钮加载更多的数据
-(void)LoadrightMoreDataWithType:(NSString *)type{
    
    self.num += 20;
    self.page += 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"url_name"] = type;
    
    params[@"per_page"] = @(self.num);
    
    params[@"page"] = @(self.page);
    
    [self.manager GET:FirstUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"-------%@",responseObject);
        
        NSArray *arr = responseObject[@"objects"];
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        for (NSDictionary *dict in arr) {
            
            LZHRFirsitModel *model = [LZHRFirsitModel firstmodelWithDict:dict];
            
            [arrM addObject:model];
            
        }
        
        [self.DataArr addObjectsFromArray:arrM];
        
        [self.RightTV reloadData];

//        NSLog(@"目前的个数：%ld,总共的个数：%ld",self.DataArr.count,[self.TotalCounts integerValue]);

        //判断是否已经把items的个数加载完毕 这个借口返回的数据有问题 只能手动去设定
        if (self.DataArr.count == 60 || self.DataArr.count == 79 || self.DataArr.count == 48 || self.DataArr.count == 53 || self.DataArr.count == 46 || self.DataArr.count == 45 || self.DataArr.count == 41 || self.DataArr.count == 70 || self.DataArr.count == 38 || self.DataArr.count == 39 || self.DataArr.count == 42 || self.DataArr.count == 28) {
            
            [self.RightTV.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            
            [self.RightTV.mj_footer endRefreshing];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}


@end
