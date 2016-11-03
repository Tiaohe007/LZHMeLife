//
//  UIView+LZHFrame.h
//  Melife
//
//  Created by 刘志恒 on 16/10/17.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LZHFrame)
//这个方法只会在分类里生成set get方法的声明 不会有实现
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGFloat centerY;
@property(nonatomic,assign)CGFloat centerX;

@end
