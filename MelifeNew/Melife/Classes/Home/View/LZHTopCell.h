//
//  LZHTopCell.h
//  Melife
//
//  Created by 刘志恒 on 16/10/27.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZHTopModel;
@interface LZHTopCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Picutre;


@property(nonatomic,strong)LZHTopModel *topmodel;


-(void)setTopmodel:(LZHTopModel *)topmodel;

+(instancetype)topcell;
@end
