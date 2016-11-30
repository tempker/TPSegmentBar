//
//  TPSegmentBar.h
//  TPSegmentBar
//
//  Created by WPF on 16/11/30.
//  Copyright © 2016年 WPF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPSegmentBar;

@protocol TPSegmentBarDelegate <NSObject>

-(void)segmentBar:(TPSegmentBar *) SegmentBar DidselectIndexFrom:(NSInteger) fromIndex toIndex:(NSInteger )toIndex;

@end

@interface TPSegmentBar : UIView

+(instancetype)segmentBarWithFrame:(CGRect)frame;

/** title数组   */
@property (nonatomic,strong) NSArray <NSString *>*titleItems;

/** delegate   */
@property (nonatomic,weak) id<TPSegmentBarDelegate> delegate;


/** index   */
@property (nonatomic,assign) NSInteger selectIndex;


@end
