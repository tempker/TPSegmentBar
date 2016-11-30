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
{
    
    UIButton *_lastBtn;
}
/**  滚动视图  */
@property (nonatomic,strong) UIScrollView *contentView;

/**btn数组   */
@property (nonatomic,strong) NSMutableArray<UIButton *>*btnArray;

/** 指示器   */
@property (nonatomic,strong) UIView *indicatorView;
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
        [titleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [titleBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];

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


#pragma mark - 点击事件
-(void)btnClick:(UIButton*)btn{
    _lastBtn.selected = NO;
    btn.selected = YES;
    _lastBtn = btn;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = btn.width;
        self.indicatorView.centerX = btn.centerX;
    }];

    //记录点击btnscrollView 需要滚动到的相应的位置
    CGFloat scrollViewX = btn.centerX - self.contentView.width *0.5;
    
    if (scrollViewX < 0 ) {
        scrollViewX = 0;
    }
    if (scrollViewX > self.contentView.contentSize.width - self.contentView.width) {
        scrollViewX = self.contentView.contentSize.width - self.contentView.width;
    }
    //偏移数据过小的话直接return
    if (scrollViewX < 3) {
        return;
    }
    //进行滚动
    [self.contentView setContentOffset:CGPointMake(scrollViewX, 0) animated:YES];
    
}
#pragma mark - 懒加载
-(NSMutableArray<UIButton *> *)btnArray{
    
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

-(UIView *)indicatorView{
    
    CGFloat indicatorH = 2;
    if (!_indicatorView) {
        
        _indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - indicatorH, 0, indicatorH)];
        _indicatorView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_indicatorView];
    }
    return _indicatorView;
}


@end
