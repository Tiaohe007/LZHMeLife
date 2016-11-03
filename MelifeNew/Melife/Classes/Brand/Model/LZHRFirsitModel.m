
//
//  LZHRFirsitModel.m
//  Melife
//
//  Created by 刘志恒 on 16/10/29.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHRFirsitModel.h"

@implementation LZHRFirsitModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        
        _special_name = dict[@"special_name"];
        
        _brand_image_url = dict[@"brand_image_url"];
        
        _brand_sales_count = dict[@"brand_sales_count"];
        
        _ban_pingou_url = dict[@"ban_pingou_url"];
        
        _ID = dict[@"id"];
        
        _name = dict[@"name"];
    }
    return self;
}

+(instancetype)firstmodelWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}

@end
