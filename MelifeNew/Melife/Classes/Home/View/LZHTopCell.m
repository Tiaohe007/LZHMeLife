//
//  LZHTopCell.m
//  Melife
//
//  Created by 刘志恒 on 16/10/27.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHTopCell.h"
#import <UIImageView+WebCache.h>
#import "LZHTopModel.h"

@interface LZHTopCell()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *Price;
@property (weak, nonatomic) IBOutlet UILabel *SalesCoutn;

@end

@implementation LZHTopCell

-(void)setTopmodel:(LZHTopModel *)topmodel{
    
    
    
    _topmodel = topmodel;
    
    [self.Picutre sd_setImageWithURL:[NSURL URLWithString:_topmodel.image_share] placeholderImage:[UIImage imageNamed:@"normol_bg"]];
    
    self.title.text = _topmodel.short_title;
    
#pragma mark 设置富文本
    
    NSString *content  = [NSString stringWithFormat:@"包邮 已卖%@件",_topmodel.sales_count];
    
    NSInteger num = content.length;
    
    //用的属性字符串
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc]initWithString:content];

    //设置：在0-3个单位长度内的内容显示成红色
    [attrs addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    //设置：在0-3个单位长度内的内容显示成红色
    [attrs addAttribute:NSForegroundColorAttributeName value:[UIColor brownColor] range:NSMakeRange(3,num-3)];
    
    self.SalesCoutn.attributedText = attrs;
//
    _Price.text = [NSString stringWithFormat:@"￥%ld",[_topmodel.price integerValue]/100];
}

+(instancetype)topcell{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LZHTopCell" owner:nil options:nil]lastObject];
    
}
- (void)awakeFromNib {
    // Initialization code
}

@end
