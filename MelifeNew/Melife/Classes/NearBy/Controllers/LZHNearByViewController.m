//
//  LZHNearByViewController.m
//  Melife
//
//  Created by 刘志恒 on 16/10/31.
//  Copyright © 2016年 Jack. All rights reserved.
//
/*
 添加大头针
 1、建立大头针模型  导入头文件<mapKit\mapKit.h>
 2、让模型遵守协议<MKMapViewDelegate>
 3、设置属性 坐标  title subtitle
 4、添加
 */

#import "LZHNearByViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LZHAnnotation.h"
#import <AFNetworking.h>
#import "LZHMapModel.h"



@interface LZHNearByViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>

@property(nonatomic,strong)CLLocationManager *manager;

@property(nonatomic,strong)MKMapView *map;

@property(nonatomic,strong)UIImageView *img;

@property(nonatomic,strong)id <MKAnnotation> annotation;

@property(nonatomic,strong)AFHTTPSessionManager *LoadManager;


@property(nonatomic,strong)NSMutableDictionary *NowLoaction;

@property(nonatomic,strong)NSMutableArray *DataArr;

@property(nonatomic,copy)NSString *shops;

@property(nonatomic,copy)NSString *address;

@property(nonatomic,assign)CGPoint point;
//保存店名的数组
@property(nonatomic,strong)NSMutableArray *names;
//保存地址的数组
@property(nonatomic,strong)NSMutableArray *addresses;
//保存坐标点的数组
@property(nonatomic,strong)NSMutableArray *points;
@end

@implementation LZHNearByViewController

-(NSMutableArray *)names{
    
    if (!_names) {
        _names = [NSMutableArray array];
        
    }
    return _names;
}

-(NSMutableArray *)addresses{
    
    if (!_addresses) {
        _addresses = [NSMutableArray array];
    }
    return _addresses;
}
-(NSMutableArray *)points{
    
    if (!_points) {
        _points = [NSMutableArray array];
    }
    return _points;
}
-(NSMutableArray *)DataArr{
    
    if (!_DataArr) {
        _DataArr = [NSMutableArray array];
    }
    return _DataArr;
}
-(NSMutableDictionary *)NowLoaction{
    
    if (!_NowLoaction) {
        _NowLoaction = [NSMutableDictionary dictionary];
    }
    return _NowLoaction;
    
}
-(AFHTTPSessionManager *)LoadManager{
    
    if (!_LoadManager) {
    
        _LoadManager = [AFHTTPSessionManager manager];
    
    }
    
    return _LoadManager;
}


-(void)viewWillAppear:(BOOL)animated{
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"附近商户";
    
    
    //请求数据
    [self LoadData];
    
    //初始化mapView
    [self setUpMap];
    
    self.manager = [[CLLocationManager alloc]init];
    
    [self.manager requestAlwaysAuthorization];
    
    [self.manager requestWhenInUseAuthorization];
    
    self.manager.delegate = self;
    
    [self.manager startUpdatingLocation];
    
    
    //这个是显示大头针的
    self.map.showsUserLocation = YES;
    
    self.map.userTrackingMode = 2;
    
    [self showLocation];
    
}
//初始化mapView
-(void)setUpMap{
    
    MKMapView *map = [[MKMapView alloc]initWithFrame:CGRectMake(0, 64, LZHScreenW, LZHScreenH-168)];
    
    map.delegate = self;
    
    [self.view addSubview:map];
    
    self.map = map;
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    
    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
//    NSLog(@"1231231231");
    [_manager startUpdatingLocation];
    
    
    
}
-(void)showLocation{
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.018, 0.018);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(self.map.userLocation.location.coordinate, span);
    
    
    [self.map setRegion:region animated:YES];
    
    [_manager stopUpdatingLocation];
    
    
}
#pragma mark 加载数据 请求完毕之后马上在地图上显示相关的大头针效果
-(void)LoadData{
    
#pragma mark 创建一个GCD组
    dispatch_group_t group = dispatch_group_create();
    

#pragma mark GCD的思想 串行队列
    dispatch_queue_t queue = dispatch_queue_create("load", DISPATCH_QUEUE_SERIAL);
    
#pragma mark GCD 异步串行
    dispatch_group_async(group, queue, ^{

        [self.LoadManager GET:NowURL parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //添加显示当前位置的label
            self.NowLoaction = responseObject[@"regeocode"];
            //代码的封装
            [self setUpShowLocation];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
        
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self.LoadManager GET:MapUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
            NSArray *arr = responseObject[@"pois"];
            
            NSMutableArray *arrM = [NSMutableArray array];
            
            for (NSDictionary *dict in arr) {
                
                LZHMapModel *model = [LZHMapModel mapmodelWithDict:dict];
     
                [self.names addObject:model.name];
           
                [self.addresses addObject:model.address];
                
                NSString *temp = model.location;
                
                NSArray *cut = [temp componentsSeparatedByString:@","];
                
                CGPoint point = CGPointMake([cut[0] floatValue], [cut[1] floatValue]);
                
                [self.points addObject:NSStringFromCGPoint(point)];
                
                [arrM addObject:model];
            }
            
            self.DataArr = arrM;
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"%@",error);
            
            }];
        });
    });
    
#pragma mark GCD的延迟操作 很好的解决了 效果的显示问题 应该先显示出来当前位置的大头针 延迟5秒后再显示出附近商户的大头针
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //延迟后要操作的代码
        
        [self setUpShowShopsWithPoints:_points andName:_names andSubName:_addresses];
        
    });

}
#pragma mark 添加显示当前位置的label
-(void)setUpShowLocation{
    
    UILabel *location = [[UILabel alloc]initWithFrame:CGRectMake(0, LZHScreenH-104, LZHScreenW, 54)];
    
    NSString *content = [NSString stringWithFormat:@"当前位置:%@",self.NowLoaction[@"formatted_address"]];
    
    NSInteger num = content.length;
    
#pragma mark 富文本的操作 让”当前位置“显示为红色 字体可调解
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc]initWithString:content];
    
    [attrs addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 5)];
    
    [attrs addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(0, 5)];
    
    [attrs addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(5, num-5)];
    
    location.attributedText = attrs;
    
    location.textAlignment = NSTextAlignmentCenter;
    
    location.numberOfLines = 2;
    
    location.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.5];
    
    [self.view addSubview:location];
    

    
    
    
}

#pragma mark抽取代码封装 来进行显示周围商户
-(void)setUpShowShopsWithPoints:(NSArray *)points andName:(NSArray *)names andSubName:(NSArray *)sub{
    
    NSMutableArray *arrA = [NSMutableArray array];
    
    for (int i = 0; i<20; i++) {
        
        LZHAnnotation *annotation = [[LZHAnnotation alloc]init];

        annotation.coordinate = CLLocationCoordinate2DMake(CGPointFromString(points[i]).y,CGPointFromString(points[i]).x);
        
        annotation.title = names[i];
        
        annotation.subtitle = sub[i];

        [arrA addObject:annotation];
    }
    
    [self.map addAnnotations:arrA];
    
}
#pragma mark 自定义大头针的显示效果view
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    MKAnnotationView *view = nil;
    
    //    判断是不是默认的大头针数据模型 如果是默认的就自定义大头针view
    if (![annotation isKindOfClass:[MKUserLocation class]]) {
        MKAnnotationView *annotationView = [[MKAnnotationView alloc]init];
        annotationView.image = [UIImage imageNamed:@"google_places"];
        
        //        是否允许显示插入视图*********
        annotationView.canShowCallout = YES;
        
        view =  annotationView;
        
    }
    
    return view;
    
}

@end
