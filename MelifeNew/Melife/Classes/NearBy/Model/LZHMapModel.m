//
//  LZHMapModel.m
//  Melife
//
//  Created by 刘志恒 on 16/10/31.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHMapModel.h"

@implementation LZHMapModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    
    
    if (self = [super init]) {
        
        _name = dict[@"name"];
        
        _address = dict[@"address"];
        
        _location = dict[@"location"];
        
        _tel = dict[@"tel"];
        
        _pname = dict[@"pname"];
        
        _cityname = dict[@"cityname"];
        
        _adname = dict[@"adname"];
        
        _distance = dict[@"distance"];
    }
    
    return self;
    
}
+(instancetype)mapmodelWithDict:(NSDictionary *)dict{
    
    return  [[self alloc]initWithDict:dict];
}
@end
