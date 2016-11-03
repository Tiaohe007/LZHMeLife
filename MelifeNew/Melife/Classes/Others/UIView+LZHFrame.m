//
//  UIView+LZHFrame.m
//  Melife
//
//  Created by 刘志恒 on 16/10/17.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "UIView+LZHFrame.h"

@implementation UIView (LZHFrame)

-(void)setCenterX:(CGFloat)centerX{
    
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}
-(CGFloat)centerX{
    return self.center.x;
}
-(void)setCenterY:(CGFloat)centerY{
    
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}
-(CGFloat)centerY{
    return self.center.y;
}
-(void)setHeight:(CGFloat)height{
    
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setWidth:(CGFloat)width{
    
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}
-(CGFloat)width{
    return self.frame.size.width;
}
-(void)setX:(CGFloat)x{
    
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}
-(CGFloat)x{
    return self.frame.origin.x;
}
-(void)setY:(CGFloat)y{
    
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}
-(CGFloat)y{
    return self.frame.origin.y;
}

@end
