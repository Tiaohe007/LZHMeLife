//
//  LZHRightCell.m
//  Melife
//
//  Created by 刘志恒 on 16/10/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHRightCell.h"
#import <UIImageView+WebCache.h>
#import "LZHRFirsitModel.h"
@interface LZHRightCell()
@property (weak, nonatomic) IBOutlet UIImageView *Picture;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *SalesCount;
@property (weak, nonatomic) IBOutlet UILabel *Day;


@end

@implementation LZHRightCell


-(void)setModel:(LZHRFirsitModel *)model{
    
    
    _model = model;
        
    _Title.text = _model.special_name;
    
    NSString *content = [NSString stringWithFormat:@"%@件已售",_model.brand_sales_count];
    
//    NSLog(@"----%@-----",_model.brand_sales_count);
#pragma mark 富文本的处理  1.先把要处理的文字转换成attributeString 2.在根据需要设定 4.把设定只有的富文本赋值给label的attributeText属性里
    NSNumber *count = _model.brand_sales_count;
    
    NSInteger num = [count stringValue].length;
    
    //用的属性字符串
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc]initWithString:content];
    
    //设置：在0-3个单位长度内的内容显示成红色
    [attrs addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, num)];
    
    _SalesCount.attributedText = attrs;
    
    NSString *url = _model.brand_image_url[@"normal"];
    
    NSMutableString *temp = [NSMutableString stringWithString:url];
    
    NSRange range = [url rangeOfString:@".webp"];
    
    [temp deleteCharactersInRange:range];
    
    [_Picture sd_setImageWithURL:[NSURL URLWithString:temp] placeholderImage:[UIImage imageNamed:@"normol_bg2"]];
    
    
}
    


+(instancetype)rightcell{
    
    
    return [[[NSBundle mainBundle]loadNibNamed:@"LZHRightCell" owner:nil options:nil]lastObject];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
