//
//  LZHAnnotation.h
//  Melife
//
//  Created by 刘志恒 on 16/10/31.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface LZHAnnotation : NSObject<MKAnnotation>

@property(nonatomic,assign)CLLocationCoordinate2D coordinate;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *subtitle;

@end
