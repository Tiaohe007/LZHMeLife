//
//  LZHMapModel.h
//  Melife
//
//  Created by 刘志恒 on 16/10/31.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZHMapModel : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *address;

@property(nonatomic,copy)NSString *location;

@property(nonatomic,copy)NSString *tel;
//省份
@property(nonatomic,copy)NSString *pname;
//市
@property(nonatomic,copy)NSString *cityname;
//区
@property(nonatomic,copy)NSString *adname;
//距离
@property(nonatomic,copy)NSString *distance;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)mapmodelWithDict:(NSDictionary *)dict;
@end
