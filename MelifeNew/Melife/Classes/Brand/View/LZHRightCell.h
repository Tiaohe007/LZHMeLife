//
//  LZHRightCell.h
//  Melife
//
//  Created by 刘志恒 on 16/10/28.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZHRFirsitModel;
@interface LZHRightCell : UITableViewCell

@property(nonatomic,strong)LZHRFirsitModel *model;

-(void)setModel:(LZHRFirsitModel *)model;
+(instancetype)rightcell;

@end
