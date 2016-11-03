//
//  LZHTopModel.h
//  Melife
//
//  Created by 刘志恒 on 16/10/27.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LZHTopModel : NSObject
//图片
@property(nonatomic,copy)NSString *image_share;
//价格
@property(nonatomic,assign)NSNumber *price;
//标题
@property(nonatomic,copy)NSString *short_title;
//销售量
@property(nonatomic,copy)NSString *sales_count;
//原始网页
@property(nonatomic,copy)NSString *origin_deal_url;
//热销里面的二级跳转的url
@property(nonatomic,copy)NSString *wap_url;




-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)topmodelWithDict:(NSDictionary *)dict;


@end
