//
//  TPSegmentBarVC.h
//  TPSegmentBar
//
//  Created by WPF on 16/11/30.
//  Copyright © 2016年 Tempker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPSegmentBar.h"
@interface TPSegmentBarVC : UIViewController

/** segmentBar   */
@property (nonatomic,strong) TPSegmentBar *segmentBar;

/**
 添加标题及子控制器

 @param itemArray 标题数组
 @param childVCs 子控制器数组
 */
-(void)setUpItems:(NSArray <NSString *>*)itemArray addChildController:(NSArray<UIViewController *>*)childVCs;
@end
