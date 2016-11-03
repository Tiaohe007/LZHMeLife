//
//  LZHLeftCell.m
//  Melife
//
//  Created by 刘志恒 on 16/10/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "LZHLeftCell.h"

@interface LZHLeftCell()

@property (weak, nonatomic) IBOutlet UIView *Indicator;

@end

@implementation LZHLeftCell

//+(instancetype)leftcell{
//    
//    
//    return [[[NSBundle mainBundle] loadNibNamed:@"LZHLeftCell" owner:nil options:nil]lastObject];
//    
//}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.textLabel.height = self.contentView.height - 4;
    
    
}

- (void)awakeFromNib {
    
   
    
    
    self.backgroundColor = LZHRGBColor(244, 244, 244);

    UIView *bg = [[UIView alloc]init];
    bg.backgroundColor = [UIColor clearColor];
    self.backgroundView = bg;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    //没有被选中就隐藏
    self.Indicator.hidden = !selected;
    
    self.textLabel.textColor = selected ? LZHRGBColor(219, 21, 26) :LZHRGBColor(78, 78, 78);
    
    
}

@end
