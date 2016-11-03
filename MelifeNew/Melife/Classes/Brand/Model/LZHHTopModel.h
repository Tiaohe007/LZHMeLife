//
//  LZHTopModel.h
//  Melife
//
//  Created by 刘志恒 on 16/10/31.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZHHTopModel : NSObject

//标题
@property(nonatomic,copy)NSString *special_name;
//图片
@property(nonatomic,strong)NSDictionary *brand_image_url;
//销量
@property(nonatomic,assign)NSNumber *brand_sales_count;

@property(nonatomic,copy)NSString *ID;

@property(nonatomic,copy)NSString *name;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)topmodelWithDict:(NSDictionary *)dict;
@end
