//
//  LZHRFirsitModel.h
//  Melife
//
//  Created by 刘志恒 on 16/10/29.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZHRFirsitModel : NSObject
//标题
@property(nonatomic,copy)NSString *special_name;
//图片
@property(nonatomic,strong)NSDictionary *brand_image_url;
//销量
@property(nonatomic,assign)NSNumber *brand_sales_count;
//点击跳转之后的url
@property(nonatomic,copy)NSString *ban_pingou_url;

@property(nonatomic,copy)NSString *ID;

@property(nonatomic,copy)NSString *name;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)firstmodelWithDict:(NSDictionary *)dict;

@end
