//
//  TPSegmentBar.m
//  TPSegmentBar
//
//  Created by WPF on 16/11/30.
//  Copyright © 2016年 WPF. All rights reserved.
//

#import "TPSegmentBar.h"
#import "UIView+Cateory.h"


#define KBtnMiniMargin 30

@interface TPSegmentBar ()
/**  滚动视图  */
@property (nonatomic,strong) UIScrollView *contentView;

/**btn数组   */
@property (nonatomic,strong) NSMutableArray<UIButton *>*btnArray;

@end


@implementation TPSegmentBar

+(instancetype)segmentBarWithFrame:(CGRect)frame{
    
    TPSegmentBar *segmentBar = [[TPSegmentBar alloc]initWithFrame:frame];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.showsHorizontalScrollIndicator = NO;
    [segmentBar addSubview:scrollView];
    segmentBar.contentView = scrollView;
    
    return segmentBar;
    
}

#pragma mark - UI

-(void)setTitleItems:(NSArray<NSString *> *)titleItems{
    
    _titleItems = titleItems;
    
    
    for (NSString *titleItem in titleItems) {
        
        UIButton *titleBtn = [[UIButton alloc]init];
        
        [titleBtn setTitle:titleItem forState:UIControlStateNormal];

        [self.contentView addSubview:titleBtn];
        [self.btnArray addObject:titleBtn];
    }
    
    // 手动刷新布局
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}



-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
    
    //计算margin
    
    //总的btn宽度
    CGFloat totoalBtnWith = 0;
    
    for (UIButton *btn in self.btnArray) {

        [btn sizeToFit];
        totoalBtnWith += btn.width;
    }

    CGFloat btnMagin = (self.width - totoalBtnWith) / (self.btnArray.count + 1);
    if (btnMagin < KBtnMiniMargin) {
        
        btnMagin = KBtnMiniMargin;
    }
    
    //layoutBtn
    CGFloat lastX = btnMagin;
    for (UIButton *btn in self.btnArray) {
        
        [btn sizeToFit];
        
        btn.y = 0;
        
        btn.x = lastX;

        lastX += btn.width + btnMagin;
    }
    
    self.contentView.contentSize = CGSizeMake(lastX, 0);
    
}

#pragma mark - 懒加载
-(NSMutableArray<UIButton *> *)btnArray{
    
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}






@end
