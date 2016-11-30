//
//  TPSegmentBar.h
//  TPSegmentBar
//
//  Created by WPF on 16/11/30.
//  Copyright © 2016年 WPF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPSegmentBar : UIView

+(instancetype)segmentBarWithFrame:(CGRect)frame;

/** title数组   */
@property (nonatomic,strong) NSArray <NSString *>*titleItems;

@end
