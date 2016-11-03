//
//  UIImage+LZHCategory.m
//  Melife
//
//  Created by 刘志恒 on 16/10/17.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "UIImage+LZHCategory.h"

@implementation UIImage (LZHCategory)

+(instancetype)imageWithOriRenderingImage:(NSString *)imageName{

    
    UIImage *img = [UIImage imageNamed:imageName];
    return [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
