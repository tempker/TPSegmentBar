//
//  TPSegmentBarConfig.m
//  TPSegmentBar
//
//  Created by Tempker on 16/12/1.
//  Copyright © 2016年 Tempker. All rights reserved.
//

#import "TPSegmentBarConfig.h"

@implementation TPSegmentBarConfig

+(instancetype)defaultConfig{
    
    TPSegmentBarConfig *config = [[TPSegmentBarConfig alloc]init];
    
    config.segmentBarBackColor = [UIColor clearColor];
    config.itemFont = [UIFont systemFontOfSize:15];
    config.itemNormalColor = [UIColor lightGrayColor];
    config.itemSelectColor = [UIColor redColor];
    config.indicatorColor = [UIColor redColor];
    config.indicatorHeight = 2;
    config.indicatorExtraW = 10;
    
    return config;
    
}


@end
