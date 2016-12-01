//
//  TPSegmentBarConfig.h
//  TPSegmentBar
//
//  Created by Tempker on 16/12/1.
//  Copyright © 2016年 Tempker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TPSegmentBarConfig : NSObject

+(instancetype)defaultConfig;


/** 背景颜色 */
@property (nonatomic, strong) UIColor *segmentBarBackColor;
/** 正常颜色 */
@property (nonatomic, strong) UIColor *itemNormalColor;
/** 选中颜色 */
@property (nonatomic, strong) UIColor *itemSelectColor;
/** 字体大小 */
@property (nonatomic, strong) UIFont *itemFont;
/** 指示器颜色 */
@property (nonatomic, strong) UIColor *indicatorColor;
/** 指示器高度 */
@property (nonatomic, assign) CGFloat indicatorHeight;
/** 指示器宽度 */
@property (nonatomic, assign) CGFloat indicatorExtraW;

@end
