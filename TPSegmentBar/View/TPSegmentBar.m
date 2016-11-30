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
    
    return segmentBar;
    
}

#pragma mark - UI

-(void)setTitleItems:(NSArray<NSString *> *)titleItems{
    
    _titleItems = titleItems;
    
    //删除之前添加的
    [self.btnArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.btnArray = nil;
    
    for (NSString *titleItem in titleItems) {
        
        UIButton *titleBtn = [[UIButton alloc]init];
        titleBtn.tag = self.btnArray.count;
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
    
    if (self.btnArray.count == 0) {
        return;
    }
    UIButton *btn = self.btnArray[self.selectIndex];
    
    self.indicatorView.width = btn.width;
    self.indicatorView.centerX = btn.centerX;
    self.indicatorView.y = self.height - self.indicatorView.height;
}


-(void)setSelectIndex:(NSInteger )selectIndex{
    
    
    //数据过滤
    if (self.btnArray.count == 0 || selectIndex < 0 || selectIndex > self.btnArray.count - 1) {
        return;
    }
    _selectIndex = selectIndex;
    
    //根据外界传递过来的 进行btn的点击
    UIButton *btn = self.btnArray[selectIndex];
    
    [self btnClick:btn];
}

#pragma mark - 点击事件
-(void)btnClick:(UIButton*)btn{
    
    //代理传递
    if ([self.delegate respondsToSelector:@selector(segmentBar:DidselectIndexFrom:toIndex:)]) {
        [self.delegate segmentBar:self DidselectIndexFrom:_lastBtn.tag toIndex:btn.tag];
    }
    
    _selectIndex = btn.tag;
    
    _lastBtn.selected = NO;
    btn.selected = YES;
    _lastBtn = btn;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = btn.width;
        self.indicatorView.centerX = btn.centerX;
    }];

    //记录点击btnscrollView 需要滚动到的相应的位置
    CGFloat scrollViewX = btn.centerX - self.contentView.width * 0.5;
    
    if (scrollViewX < 0 ) {
        scrollViewX = 0;
    }
    if (scrollViewX > self.contentView.contentSize.width - self.contentView.width) {
        scrollViewX = self.contentView.contentSize.width - self.contentView.width;
    }
    //偏移数据过小的话直接return
//    if (scrollViewX < 3) {
//        return;
//    }
    
    
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

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_contentView];
    }
    return _contentView;
}


@end
