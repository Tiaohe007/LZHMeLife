//
//  LZHTopCell.h
//  Melife
//
//  Created by 刘志恒 on 16/10/31.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZHHTopModel;
@interface LZHHTopCell : UITableViewCell

@property(nonatomic,strong)LZHHTopModel *model;

-(void)setModel:(LZHHTopModel *)model;

+(instancetype)hhtopcell;

@end
