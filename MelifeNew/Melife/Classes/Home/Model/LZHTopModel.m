//
//  LZHTopModel.m
//  Melife
//
//  Created by 刘志恒 on 16/10/27.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHTopModel.h"
@implementation LZHTopModel


-(instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        _image_share = dict[@"image_share"];
        
        _sales_count = dict[@"sales_count"];
        
        _price = dict[@"price"];
        
        _short_title = dict[@"short_title"];
        
        _origin_deal_url = dict[@"origin_deal_url"];
        
        _wap_url = dict[@"wap_url"];
    }
    
    return self;
}

+(instancetype)topmodelWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}

@end
